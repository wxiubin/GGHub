import 'package:gg_networking/gg_networking.dart';
import 'package:gg_networking/src/adapter.dart';

class MockAdapter extends HttpClientAdapter {
  static const String mockHost = 'mockserver';
  static const String mockBase = 'http://$mockHost';

  @override
  Future<Response<T>> dispatch<T>(Request<T> request) async {
    final uri = Uri.parse('${request.baseUrl}${request.url}');
    if (uri.host != mockHost) {
      return Response<T>(statusCode: 500, data: '服务器错误', request: request);
    }
    switch (uri.path) {
      case '/test':
        return Response<T>(
          statusCode: 200,
          data: {
            'code': 0,
            'data': request.data,
          },
          request: request,
        );
      default:
        return Response<T>(
            statusCode: 404,
            data: {
              'code': 0,
              'message': '你说啥？',
              'data': request.data,
            },
            request: request);
    }
  }
}
