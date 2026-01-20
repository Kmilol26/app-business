import 'package:dio/dio.dart';
import '../config/constants.dart';

/// API Service - Maneja todas las llamadas HTTP al backend
class ApiService {
  late final Dio _dio;
  String? _authToken;

  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: ApiConfig.connectTimeout,
      receiveTimeout: ApiConfig.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Interceptor para logs y auth
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (_authToken != null) {
          options.headers['Authorization'] = 'Bearer $_authToken';
        }
        print('REQUEST[${options.method}] => PATH: ${options.path}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
        return handler.next(response);
      },
      onError: (error, handler) {
        print('ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}');
        return handler.next(error);
      },
    ));
  }

  void setAuthToken(String token) {
    _authToken = token;
  }

  void clearAuthToken() {
    _authToken = null;
  }

  // ==================== Dashboard ====================
  Future<Map<String, dynamic>> getDashboardMetrics() async {
    final response = await _dio.get(ApiConfig.dashboard);
    return response.data;
  }

  // ==================== Events ====================
  Future<List<dynamic>> getEvents({String? query}) async {
    final response = await _dio.get(
      ApiConfig.events,
      queryParameters: query != null ? {'query': query} : null,
    );
    return response.data;
  }

  Future<Map<String, dynamic>> getEvent(String id) async {
    final response = await _dio.get('${ApiConfig.events}/$id');
    return response.data;
  }

  Future<Map<String, dynamic>> createEvent(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiConfig.events, data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> updateEvent(String id, Map<String, dynamic> data) async {
    final response = await _dio.put('${ApiConfig.events}/$id', data: data);
    return response.data;
  }

  Future<void> deleteEvent(String id) async {
    await _dio.delete('${ApiConfig.events}/$id');
  }

  // ==================== Spaces ====================
  Future<List<dynamic>> getSpaces({String? query}) async {
    final response = await _dio.get(
      ApiConfig.spaces,
      queryParameters: query != null ? {'query': query} : null,
    );
    return response.data;
  }

  Future<Map<String, dynamic>> createSpace(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiConfig.spaces, data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> updateSpace(String id, Map<String, dynamic> data) async {
    final response = await _dio.put('${ApiConfig.spaces}/$id', data: data);
    return response.data;
  }

  // ==================== Guests ====================
  Future<List<dynamic>> getGuests({String? eventId}) async {
    final response = await _dio.get(
      ApiConfig.guests,
      queryParameters: eventId != null ? {'eventId': eventId} : null,
    );
    return response.data;
  }

  Future<Map<String, dynamic>> updateGuestStatus(String id, String status) async {
    final response = await _dio.patch(
      '${ApiConfig.guests}/$id/status',
      data: {'status': status},
    );
    return response.data;
  }

  // ==================== Sales ====================
  Future<Map<String, dynamic>> getSalesMetrics({String? eventId}) async {
    final response = await _dio.get(
      ApiConfig.sales,
      queryParameters: eventId != null ? {'eventId': eventId} : null,
    );
    return response.data;
  }

  // ==================== Payments ====================
  Future<List<dynamic>> getPaymentMethods() async {
    final response = await _dio.get(ApiConfig.payments);
    return response.data;
  }

  Future<Map<String, dynamic>> createPaymentMethod(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiConfig.payments, data: data);
    return response.data;
  }

  // ==================== Business ====================
  Future<Map<String, dynamic>> getBusiness() async {
    final response = await _dio.get(ApiConfig.business);
    return response.data;
  }

  Future<Map<String, dynamic>> updateBusiness(Map<String, dynamic> data) async {
    final response = await _dio.put(ApiConfig.business, data: data);
    return response.data;
  }
}

// Singleton instance
final apiService = ApiService();
