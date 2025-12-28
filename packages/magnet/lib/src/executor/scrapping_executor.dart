import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:logger/logger.dart';
import 'package:magnet/src/models/scrapping_instruction.dart';

/// The scrapping execution engine
///
/// The [ScrappingExecutor] digests and executes both commands and
//  instructions passed to the engine.
class ScrappingExecutor {
  final InAppWebViewController controller;
  final Logger logger;
  final Map<String, dynamic> extractedData = {};

  ScrappingExecutor({required this.controller, required this.logger});

  /// Runs [instruction] against the current webpage
  Future<void> execute(ScrapingInstruction instruction) async {
    switch (instruction.type) {
      case "extract":
        await _extract(instruction);
        break;
      case "wait":
        await _wait(instruction);
        break;
      case 'click':
        await _click(instruction);
        break;

      default:
        throw Exception("Unkown instruction type: [${instruction.type}]");
    }
  }

  /// Clicks an element specified by its selector
  Future<void> _click(ScrapingInstruction instruction) async {
    final selector = instruction.selector;
    if (selector == null) throw Exception('Click requires selector');

    await controller.evaluateJavascript(
      source:
          '''
        (function() {
          document.querySelector('$selector')?.click();
        })()
      ''',
    );
    logger.i('Clicked: $selector');
  }

  /// Waits for a specified instruction duration otherwise wait for a second
  Future<void> _wait(ScrapingInstruction instruction) async {
    final duration = instruction.waitDuration ?? const Duration(seconds: 1);
    await Future.delayed(duration);
    logger.i('Waited ${duration.inMilliseconds}ms');
  }

  Future<void> _extract(ScrapingInstruction instruction) async {
    if (instruction.outputKey == null) {
      throw Exception('Extract requires a valid outputKey');
    }
    if (instruction.selectorToUse == '') {
      throw Exception("Extract requires a valid selector to use");
    }
    final outputKey = instruction.outputKey;

    String jsCode;
    if (instruction.isXPath) {
      jsCode = _buildXPathQueryExtractor(
        instruction.xpath!,
        instruction.attribute,
      );
    } else {
      jsCode = _buildCSSQueryExtractor(
        instruction.selector!,
        instruction.attribute,
      );
    }

    final result = await controller.evaluateJavascript(source: jsCode);
    extractedData[outputKey!] = result;
    logger.i('Extracted $outputKey: $result');
  }

  String _buildCSSQueryExtractor(String selector, String? attribute) {
    if (attribute == null) {
      return '''(function() {
      const el = document.querySelector('$selector');
      return el ? el.innerText.trim() : null;
    })()''';
    } else {
      return '''(function() {
      const el = document.querySelector('$selector');
      return el ? el.getAttribute('$attribute') : null;
    })()''';
    }
  }

  String _buildXPathQueryExtractor(String xpath, String? attribute) {
    if (attribute == null) {
      return '''const el = (function getElementByXPath() {
          return document.evaluate('$xpath', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
      })();
      el? el.innerText.trim(): null;
      ''';
    }
    return '''const el = (function getElementByXPath() {
          return document.evaluate('$xpath', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
      })();
      el ? el.getAttribute('$attribute') : null;
      ''';
  }
}
