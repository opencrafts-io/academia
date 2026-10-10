import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portal_sync/portal_sync.dart';

/// A scripted, in-memory [HttpClientAdapter]: never touches the network, so
/// these tests exercise exactly the guardrail logic in [DioIcsFeedFetcher]
/// (redirect re-validation, byte ceiling, status handling) deterministically.
class _ScriptedAdapter implements HttpClientAdapter {
  _ScriptedAdapter(this._responses);
  final List<ResponseBody> _responses;
  int calls = 0;
  final List<String> requestedUris = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requestedUris.add(options.uri.toString());
    final response =
        _responses[calls < _responses.length ? calls : _responses.length - 1];
    calls++;
    return response;
  }

  @override
  void close({bool force = false}) {}
}

class _NeverCalledAdapter implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    throw StateError('The network must never be reached for this request.');
  }

  @override
  void close({bool force = false}) {}
}

DioIcsFeedFetcher _fetcherWith(HttpClientAdapter adapter) {
  final dio = Dio();
  dio.httpClientAdapter = adapter;
  return DioIcsFeedFetcher(dio: dio);
}

void main() {
  group('DioIcsFeedFetcher', () {
    test('fetches a feed under the size ceiling', () async {
      final adapter = _ScriptedAdapter([
        ResponseBody.fromString('BEGIN:VCALENDAR\r\nEND:VCALENDAR\r\n', 200),
      ]);
      final fetcher = _fetcherWith(adapter);
      final text = await fetcher.fetchIcsText(
        Uri.parse('https://canvas.example.edu/feeds/a.ics'),
      );
      expect(text, contains('BEGIN:VCALENDAR'));
      expect(adapter.calls, 1);
    });

    test(
      'rejects a non-HTTPS feed URL without ever calling the network',
      () async {
        final fetcher = _fetcherWith(_NeverCalledAdapter());
        await expectLater(
          fetcher.fetchIcsText(
            Uri.parse('http://canvas.example.edu/feeds/a.ics'),
          ),
          throwsA(
            isA<IcsFeedFetchException>().having(
              (error) => error.reasonCode,
              'reasonCode',
              'scheme_not_allowed',
            ),
          ),
        );
      },
    );

    test('rejects a feed URL pointed at a private/link-local host', () async {
      final fetcher = _fetcherWith(_NeverCalledAdapter());
      await expectLater(
        fetcher.fetchIcsText(Uri.parse('https://169.254.169.254/feeds/a.ics')),
        throwsA(
          isA<IcsFeedFetchException>().having(
            (error) => error.reasonCode,
            'reasonCode',
            'host_not_allowed',
          ),
        ),
      );
    });

    test(
      'rejects a response over the byte ceiling before buffering it all',
      () async {
        final oversized = Uint8List(DioIcsFeedFetcher.maxFeedBytes + 1024);
        final adapter = _ScriptedAdapter([
          ResponseBody(Stream.fromIterable([oversized]), 200),
        ]);
        final fetcher = _fetcherWith(adapter);
        await expectLater(
          fetcher.fetchIcsText(
            Uri.parse('https://canvas.example.edu/feeds/a.ics'),
          ),
          throwsA(
            isA<IcsFeedFetchException>().having(
              (error) => error.reasonCode,
              'reasonCode',
              'response_too_large',
            ),
          ),
        );
      },
    );

    test(
      're-validates scheme on every redirect hop and follows a safe one',
      () async {
        final adapter = _ScriptedAdapter([
          ResponseBody.fromString(
            '',
            302,
            headers: {
              'location': ['https://safe.example.edu/feeds/a.ics'],
            },
          ),
          ResponseBody.fromString('BEGIN:VCALENDAR\r\nEND:VCALENDAR\r\n', 200),
        ]);
        final fetcher = _fetcherWith(adapter);
        final text = await fetcher.fetchIcsText(
          Uri.parse('https://canvas.example.edu/feeds/a.ics'),
        );
        expect(text, contains('BEGIN:VCALENDAR'));
        expect(adapter.calls, 2);
        expect(
          adapter.requestedUris.last,
          'https://safe.example.edu/feeds/a.ics',
        );
      },
    );

    test('refuses a redirect to a non-HTTPS target', () async {
      final adapter = _ScriptedAdapter([
        ResponseBody.fromString(
          '',
          302,
          headers: {
            'location': ['http://downgraded.example.edu/feeds/a.ics'],
          },
        ),
      ]);
      final fetcher = _fetcherWith(adapter);
      await expectLater(
        fetcher.fetchIcsText(
          Uri.parse('https://canvas.example.edu/feeds/a.ics'),
        ),
        throwsA(
          isA<IcsFeedFetchException>().having(
            (error) => error.reasonCode,
            'reasonCode',
            'scheme_not_allowed',
          ),
        ),
      );
    });

    test('refuses a redirect to a private host even over HTTPS', () async {
      final adapter = _ScriptedAdapter([
        ResponseBody.fromString(
          '',
          302,
          headers: {
            'location': ['https://169.254.169.254/latest/meta-data'],
          },
        ),
      ]);
      final fetcher = _fetcherWith(adapter);
      await expectLater(
        fetcher.fetchIcsText(
          Uri.parse('https://canvas.example.edu/feeds/a.ics'),
        ),
        throwsA(
          isA<IcsFeedFetchException>().having(
            (error) => error.reasonCode,
            'reasonCode',
            'host_not_allowed',
          ),
        ),
      );
    });

    test('gives up after too many redirect hops', () async {
      final responses = List.generate(
        DioIcsFeedFetcher.maxRedirects + 2,
        (index) => ResponseBody.fromString(
          '',
          302,
          headers: {
            'location': ['https://canvas.example.edu/feeds/hop-$index.ics'],
          },
        ),
      );
      final adapter = _ScriptedAdapter(responses);
      final fetcher = _fetcherWith(adapter);
      await expectLater(
        fetcher.fetchIcsText(
          Uri.parse('https://canvas.example.edu/feeds/a.ics'),
        ),
        throwsA(
          isA<IcsFeedFetchException>().having(
            (error) => error.reasonCode,
            'reasonCode',
            'too_many_redirects',
          ),
        ),
      );
    });
  });
}
