import 'dart:io';

import 'request.dart';

/// Http Response
class Response<T> {
  Response(
      {this.statusCode,
      this.headers,
      this.data,
      this.transformedData,
      this.request});

  /// http 状态码
  final int statusCode;

  /// 响应头
  final HttpHeaders headers;

  /// 响应结果
  final dynamic data;

  /// 转换结果
  T transformedData;

  /// 请求配置
  final Request request;

  Response<T> copyWith(
      {int statusCode,
      HttpHeaders headers,
      data,
      T transformedData,
      Request request}) {
    return Response<T>(
      statusCode: statusCode ?? this.statusCode,
      headers: headers ?? this.headers,
      data: data ?? this.data,
      request: request ?? this.request,
      transformedData: transformedData ?? this.transformedData,
    );
  }
}
