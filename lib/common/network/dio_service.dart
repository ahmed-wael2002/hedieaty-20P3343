import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioService {
  static final DioService _instance = DioService._internal();
  factory DioService() => _instance;

  late Dio _dio;

  DioService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: '', // Set dynamically at runtime
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    // Add interceptors for logging and error handling
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Log request data
        debugPrint('Request: ${options.method} ${options.uri}');
        debugPrint('Headers: ${options.headers}');
        debugPrint('Body: ${options.data}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Log response data
        debugPrint('Response: ${response.statusCode} ${response.data}');
        return handler.next(response);
      },
      onError: (DioException error, handler) {
        // Log errors
        debugPrint('Error: ${error.response?.statusCode} ${error.message}');
        return handler.next(error);
      },
    ));
  }

  void setBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  void setHeaders(Map<String, String> headers) {
    _dio.options.headers.addAll(headers);
  }

  Future<Response?> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } catch (e) {
      debugPrint('GET request error: $e');
      return null;
    }
  }

  Future<Response?> post(String path, {dynamic data, Map<String, String>? headers}) async {
    try {
      return await _dio.post(
        path,
        data: data,
        options: Options(headers: headers),
      );
    } catch (e) {
      debugPrint('POST request error: $e');
      return null;
    }
  }


  Future<Response?> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } catch (e) {
      debugPrint('PUT request error: $e');
      return null;
    }
  }

  Future<Response?> delete(String path, {dynamic data}) async {
    try {
      return await _dio.delete(path, data: data);
    } catch (e) {
      debugPrint('DELETE request error: $e');
      return null;
    }
  }
}

// Usage example:
// final dioService = DioService();
// dioService.setBaseUrl('https://your-api-url.com');
// dioService.setHeaders({'Authorization': 'Bearer your-token'});
// dioService.get('/endpoint');
