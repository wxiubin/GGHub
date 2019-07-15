import 'request.dart';

/// 返回[method]对应的http method字符串
String httpMethodString(HttpMethod method) {
  switch (method) {
    case HttpMethod.get:
      return 'get';
    case HttpMethod.head:
      return 'head';
    case HttpMethod.post:
      return 'post';
    case HttpMethod.put:
      return 'put';
    case HttpMethod.delete:
      return 'delete';
    case HttpMethod.connect:
      return 'connect';
    case HttpMethod.options:
      return 'options';
    case HttpMethod.trace:
      return 'trace';
    case HttpMethod.patch:
      return 'patch';
    default:
      return '';
  }
}
