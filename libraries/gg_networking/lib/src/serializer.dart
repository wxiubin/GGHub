import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'request.dart';
import 'response.dart';

/// 序列化 eg. Response data to json
typedef ResponseSerializer<T> = Future<Response<T>> Function(
    Response<T> response);

class Serializer {
  static Future<Response<T>> defaultsResponseSerializer<T>(
      Response<T> response) async {
    dynamic data;
    if (response.data is String &&
        (response.request.forceJsonDecode ||
            response.headers.contentType.mimeType == 'text/json')) {
      final String jsonString = response.data;
      data = await compute(decodeJson, jsonString);
    } else {
      if (response.data is String &&
          response.request.responseType != ResponseType.protobuf) {
        data = jsonDecode(response.data);
      } else {
        data = response.data;
      }
    }

    return response.copyWith(data: data);
  }

  static dynamic decodeJson(String string) => jsonDecode(string);

  static dynamic decodeJsonInBackground(String string) =>
      compute(decodeJson, string);
}
