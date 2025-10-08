import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://coupino-dev.onrender.com/', //https://coupino-dev.onrender.com/
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _initInterceptors();
  }
  late final Dio _dio;

  // POST REQUEST
  Future<Response> post(
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );
      return response;
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  //GET REQUEST
  Future<Response> get(String endPoint, {Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.get(
        endPoint,
        options: Options(headers: headers),
      );
      return response;
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  // ERROR HANDLER
  String _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return 'Connection Timeout';
    }
    if (e.type == DioExceptionType.receiveTimeout) return 'Receive Timeout';
    if (e.type == DioExceptionType.badResponse) {
      return 'Server Error: ${e.response?.statusCode}';
    }
    return e.message ?? 'Unknown Error';
  }

  // PRIVATE: Initialize Interceptors
  void _initInterceptors() {
    // Logging Interceptor
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }

    // Custom Interceptor for debug prints
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint('API URL => ${options.uri}');
          debugPrint('API HEADER => ${options.headers}');
          debugPrint('API BODY => ${options.data}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint('RESPONSE => ${response.data}');
          handler.next(response);
        },
        onError: (e, handler) {
          debugPrint('🌐 Dio Error: ${e.message}');
          handler.next(e);
        },
      ),
    );
  }
}
