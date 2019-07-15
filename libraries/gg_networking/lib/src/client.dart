import 'dart:core';

import 'package:flutter/foundation.dart';

import 'adapter.dart';
import 'interceptor.dart';
import 'request.dart';
import 'response.dart';
import 'serializer.dart';

/// 网络请求真实实现类
class HttpClient {
  HttpClient({
    HttpClientAdapter adapter,
    this.defaultOptions,
    this.requestInterceptor,
    this.responseInterceptors,
    this.responseSerializer = Serializer.defaultsResponseSerializer}) {
    _adapter = adapter ?? HttpClientAdapter.adapter(options: defaultOptions);
  }

  ResponseSerializer responseSerializer;

  final Options defaultOptions;
  final List<Interceptor<Request>> requestInterceptor;
  final List<Interceptor<Response>> responseInterceptors;

  HttpClientAdapter _adapter;

  Future<Response<T>> dispatch<T>(Request<T> request) =>
      _dispatch(request: request);

  Future<Response<T>> _dispatch<T>({Request<T> request}) async {
    if (null != defaultOptions) request.merge(defaultOptions);

    assert(request.data == null ||
        request.data is Map<String, String> ||
        request.data is String);

    final res = await _executeIntercept<Request>(requestInterceptor, request);
    var response = await _adapter.dispatch<T>(res);
    response = await responseSerializer(response);
    response =
        await _executeIntercept<Response>(responseInterceptors, response);

    response.transformedData = await _transformedData(response.data, res);

    return response;
  }

  // 拦截器
  Future<T> _executeIntercept<T>(List<Interceptor<T>> interceptors, T t) async {
    if (null == interceptors || interceptors.isEmpty) return t;
    Future _assureFuture(e) {
      if (e is Future) return e;
      return Future.value(e);
    }

    var result = t;
    for (final interceptor in interceptors) {
      result = await _assureFuture(interceptor(result));
    }
    return result;
  }

  // 模型转换
  Future<T> _transformedData<T>(data, Request<T> request) async {
    if (null == data || null == request.responseTransformer) return null;

    dynamic dataToTransform;
    if (null != request.transformationKey && data is Map<String, dynamic>) {
      dataToTransform =
          request.transformationKey.split('.').fold(data, (data, key) {
        if (data is Map<String, dynamic>) return data[key];
        return null;
      });
    } else {
      dataToTransform = data;
    }
    if (null == dataToTransform) return null;

    if (request.transformInBackground) {
      return compute(request.responseTransformer, dataToTransform);
    } else {
      return request.responseTransformer(dataToTransform);
    }
  }
}
