import 'package:dio/dio.dart';
import 'preference_service.dart';

class ApiService {
  static const String baseUrl = 'https://absensib1.mobileprojp.com';

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Accept': 'application/json',
      },
    ),
  );

  static Options _getOptions() {
    final token = PreferenceService.getToken();
    return Options(
      headers: {
        'Accept': 'application/json',
        if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      },
      validateStatus: (status) => true,
    );
  }

  static Map<String, dynamic> _formatResponse(Response response) {
    dynamic body = response.data;
    if (body is Map) {
      final map = Map<String, dynamic>.from(body);
      final statusCode = response.statusCode ?? 200;
      final isSuccess = statusCode >= 200 && statusCode < 300;

      String message = map['message']?.toString() ?? (isSuccess ? 'Berhasil' : 'Terjadi kesalahan');
      
      if (map['errors'] is Map) {
        final errors = map['errors'] as Map;
        if (errors.isNotEmpty && (message.isEmpty || message == 'Terjadi kesalahan')) {
          final firstError = errors.values.first;
          if (firstError is List && firstError.isNotEmpty) {
            message = firstError.first.toString();
          }
        }
      }

      return {
        'success': isSuccess,
        'statusCode': statusCode,
        'message': message,
        'data': map['data'],
        'errors': map['errors'],
      };
    } else if (body is List) {
      return {
        'success': true,
        'statusCode': response.statusCode ?? 200,
        'message': 'Berhasil',
        'data': body,
      };
    }

    return {
      'success': (response.statusCode ?? 500) < 300,
      'statusCode': response.statusCode ?? 500,
      'message': 'Format respons tidak dikenali',
      'data': body,
    };
  }

  static Map<String, dynamic> _handleDioError(dynamic error) {
    if (error is DioException) {
      if (error.response != null) {
        return _formatResponse(error.response!);
      }
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        return {
          'success': false,
          'statusCode': 408,
          'message': 'Koneksi timeout, periksa jaringan Anda',
          'data': null,
        };
      }
      return {
        'success': false,
        'statusCode': 0,
        'message': 'Gagal terhubung ke server: ${error.message}',
        'data': null,
      };
    }
    return {
      'success': false,
      'statusCode': 500,
      'message': 'Terjadi kesalahan: $error',
      'data': null,
    };
  }

  static Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await dio.post(
        endpoint,
        data: data,
        options: _getOptions(),
      );
      return _formatResponse(response);
    } catch (e) {
      return _handleDioError(e);
    }
  }

  static Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: _getOptions(),
      );
      return _formatResponse(response);
    } catch (e) {
      return _handleDioError(e);
    }
  }

  static Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await dio.put(
        endpoint,
        data: data,
        options: _getOptions(),
      );
      return _formatResponse(response);
    } catch (e) {
      return _handleDioError(e);
    }
  }

  static Future<Map<String, dynamic>> delete(
    String endpoint, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await dio.delete(
        endpoint,
        data: data,
        options: _getOptions(),
      );
      return _formatResponse(response);
    } catch (e) {
      return _handleDioError(e);
    }
  }
}
