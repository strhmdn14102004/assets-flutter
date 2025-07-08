import "dart:convert";

import "package:dio/dio.dart";
import "package:flutter/foundation.dart";

class BaseLogInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (kDebugMode) {
      debugPrint("[LogInterceptor] Uri: ${options.uri}", wrapWidth: 1024);
    }

    try {
      if (kDebugMode) {
        String? body;

        if (options.data != null) {
          if (options.data is Map) {
            body = json.encode(options.data);
          } else if (options.data is String) {
            body = options.data;
          } else if (options.data is! FormData) {
            body = json.encode(options.data.toJson());
          }

          debugPrint("[LogInterceptor] Request body: $body", wrapWidth: 1024);
        }
      }
    } finally {}

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    return handler.next(err);
  }
}