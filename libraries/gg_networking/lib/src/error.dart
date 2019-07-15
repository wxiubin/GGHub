import 'response.dart';

/// 网络请求错误code
class RequestErrorCode {
  static const ok = 0;
  static const network = -123;
}

/// 网络请求错误
class RequestError implements Exception {
  RequestError({this.code, this.message, this.response});

  final int code;

  final String message;

  final Response response;

  @override
  String toString() => message;
}
