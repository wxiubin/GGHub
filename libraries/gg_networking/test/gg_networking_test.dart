import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gg_networking/gg_networking.dart';

import 'mock_adapter.dart';

void main() {
  const testPath = '/test';

  group('restful', () {
    HttpClient client;
    setUp(() {
      client = HttpClient(adapter: MockAdapter());
    });
    test('test', () async {
      final response = await client.dispatch(
        Request(
          baseUrl: MockAdapter.mockBase,
          url: testPath,
        ),
      );
      expect(response.data['code'], 0);
    });
  });

  group('interceptor', () {
    const notFound = '/404';

    Request<T> requestInterceptor<T>(Request<T> request) {
      if (request.url == notFound) {
        request.url = testPath;
      }
      return request;
    }

    HttpClient client;
    setUp(() {
      client = HttpClient(
          adapter: MockAdapter(), requestInterceptor: [requestInterceptor]);
    });
    test('test', () async {
      {
        final response = await client.dispatch(
          Request(
            baseUrl: MockAdapter.mockBase,
            url: testPath,
          ),
        );
        expect(response.data['code'], 0);
      }
      {
        final response = await client.dispatch(
          Request(
            baseUrl: MockAdapter.mockBase,
            url: notFound,
          ),
        );
        expect(response.data['code'], 0);
      }
    });
  });
}
