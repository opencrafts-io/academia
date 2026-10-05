import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:magnet/src/models/scrapping_instruction.dart';
import './base_task.dart';

/// Handles 'extract' instruction.
class ExtractTask implements ScrapingTask {
  @override
  Future<Map<String, dynamic>?> run(
    InAppWebViewController controller,
    ScrapingInstruction instruction,
  ) async {
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

    return {outputKey ?? "result": result};
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
