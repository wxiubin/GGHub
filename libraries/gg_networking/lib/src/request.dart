import 'dart:io';

/// 请求方法
enum HttpMethod { get, head, post, put, delete, connect, options, trace, patch }

/// [json]响应转换为json
/// [stream]原始数据
/// [plain]转换为字符串，使用utf8编码
/// [bytes]字节码，返回data为List<int>
enum ResponseType {
  json,
  stream,
  plain,
  bytes,
  protobuf,
}

/// 请求选项基础类，自定义请求使用子类
class Options {
  Options({
    this.baseUrl,
    this.method,
    this.timeout,
    this.sign = true,
    this.signKey,
    this.headers = const {},
    this.extra = const {},
    this.contentType,
    this.cookies,
    this.responseType,
  });

  String baseUrl;

  Map<String, dynamic> headers;

  /// 请求方法
  HttpMethod method;

  bool sign;

  String signKey;

  int timeout;

  /// The default value is [ContentType.json]
  ContentType contentType;

  ResponseType responseType;

  Map<String, dynamic> extra;

  List<Cookie> cookies;

  void merge(Options options) {
    baseUrl ??= options.baseUrl;
    method ??= options.method;
    timeout ??= options.timeout;
    sign ??= options.sign;
    signKey ??= options.signKey;
    headers ??= options.headers;
    extra ??= options.extra;
    contentType ??= options.contentType;
    responseType ??= options.responseType;
    cookies ??= options.cookies;
  }
}

class ContentTypes {
  static final protobuf = ContentType('application', 'x-protobuf');
  static final form =
      ContentType('application', 'x-www-form-urlencoded', charset: 'utf-8');
}

/// 响应数据转换
typedef ResponseTransformer<T> = T Function(dynamic);

/// 请求封装类，真实发送请求配置
class Request<T> extends Options {
  Request({
    this.url,
    String baseUrl,
    HttpMethod method,
    Map<String, String> headers,
    ResponseType responseType,
    int timeout,
    ContentType contentType,
    bool sign,
    String signKey,
    this.queryParameters,
    this.data,
    this.responseTransformer,
    this.transformInBackground = false,
    this.transformationKey,
    this.copiesDataToQuery = false,
    this.forceJsonDecode = false,
  }) : super(
          baseUrl: baseUrl,
          method: method ?? HttpMethod.get,
          headers: headers ??
              (ResponseType.protobuf == responseType
                  ?  {
                      HttpHeaders.acceptHeader: ContentTypes.protobuf.value,
                    }
                  : const {}),
          responseType: responseType ?? ResponseType.json,
          timeout: timeout,
          sign: sign,
          signKey: signKey,
          contentType: contentType ?? ContentTypes.form,
        );
  String url;

  Map<String, dynamic> queryParameters;
  dynamic data;

  /// 响应数据转换
  ResponseTransformer<T> responseTransformer;

  /// 如果是返回结果是json，会获取其[transformationKey]对应的值，并将值传入[responseTransformer]
  /// 默认为`null`，可以用`.`分隔来获取更深层的值，例如 'data.info'
  String transformationKey;

  /// 是否启用后台转换，如果为`true`则会使用Isolate来进行转换，[responseTransformer]必须是全局函数或者静态函数
  /// 默认为`false`
  bool transformInBackground;

  /// 是否强制使用json解析
  bool forceJsonDecode;

  bool copiesDataToQuery;
}
