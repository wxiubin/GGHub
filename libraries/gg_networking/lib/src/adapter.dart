import 'dart:async';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';

import 'error.dart';
import 'request.dart';
import 'response.dart';
import 'serializer.dart';
import 'utils.dart';

abstract class HttpClientAdapter {
  static HttpClientAdapter adapter({Options options}) =>
      _DioHttpClientAdapter(options); // 使用 Dio

  Future<Response<T>> dispatch<T>(Request<T> request);
}

class _DioHttpClientAdapter extends HttpClientAdapter {
  _DioHttpClientAdapter(this._options) {
    _client = dio.Dio(DioHelper.baseOptions(_options));
    final dio.DefaultHttpClientAdapter adapter = _client.httpClientAdapter;
    adapter.onHttpClientCreate = (client) {
      client.maxConnectionsPerHost = 10;
      if (!kReleaseMode) {
        client.badCertificateCallback = (cert, host, port) => true;
      }
    };

    final dio.DefaultTransformer transformer = _client.transformer;
    transformer.jsonDecodeCallback = Serializer.decodeJsonInBackground;
  }

  final Options _options;

  dio.Dio _client;
  @override
  Future<Response<T>> dispatch<T>(Request<T> request) async {
    try {
      final dioResponse = await _client.request(request.url,
          data: request.data,
          queryParameters: request.queryParameters,
          options: DioHelper.options(request));

      return Response<T>(
          request: request,
          statusCode: dioResponse.statusCode,
          data: dioResponse.data,
          headers: dioResponse.headers);
    } on dio.DioError catch (e) {
      throw RequestError(
          message: e.message,
          code: RequestErrorCode.network,
          response: Response(
              request: request,
              statusCode: e.response?.statusCode,
              data: e.response?.data,
              headers: e.response?.headers));
    }
  }
}

class DioHelper {
  /// 返回与[responseType]相对应的[dio.ResponseType]
  static dio.ResponseType responseType(ResponseType responseType) {
    switch (responseType) {
      case ResponseType.json:
        return dio.ResponseType.json;
      case ResponseType.plain:
        return dio.ResponseType.plain;
      case ResponseType.stream:
        return dio.ResponseType.stream;
      case ResponseType.bytes:
        return dio.ResponseType.bytes;
      case ResponseType.protobuf:
        return dio.ResponseType.bytes;
    }
    return dio.ResponseType.json;
  }

  /// 将[options]转成[dio.BaseOptions]
  static dio.BaseOptions baseOptions(Options options) {
    if (options == null) return null;
    return dio.BaseOptions(
      baseUrl: options.baseUrl,
      method: httpMethodString(options.method),
      responseType: responseType(options.responseType),
      connectTimeout: options.timeout,
      receiveTimeout: options.timeout,
      contentType: options.contentType,
    );
  }

  /// 将[request]转成[dio.RequestOptions]
  static dio.RequestOptions options(Request request) {
    if (request == null) return null;
    return dio.RequestOptions(
      method: httpMethodString(request.method),
      connectTimeout: request.timeout,
      receiveTimeout: request.timeout,
      headers: request.headers,
      responseType: responseType(request.responseType),
      contentType: request.contentType,
    );
  }
}
