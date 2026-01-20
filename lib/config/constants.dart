/// API Configuration
class ApiConfig {
  // Base URL - cambiar a tu URL de producción o ngrok para desarrollo
  static const String baseUrl = 'http://localhost:3000/api';
  
  // Endpoints
  static const String auth = '/auth';
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String dashboard = '/dashboard';
  static const String events = '/events';
  static const String spaces = '/spaces';
  static const String guests = '/guests';
  static const String sales = '/sales';
  static const String payments = '/payments';
  static const String business = '/business';
  
  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}

/// App Constants
class AppConstants {
  static const String appName = 'Tikipal';
  static const String appVersion = '1.0.0';
  
  // Storage keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String businessKey = 'business_data';
  
  // Event status
  static const String statusDraft = 'draft';
  static const String statusPublished = 'published';
  static const String statusCancelled = 'cancelled';
  
  // Guest status
  static const String guestPending = 'pending';
  static const String guestApproved = 'approved';
  static const String guestRejected = 'rejected';
  static const String guestAttended = 'attended';
  
  // Space status
  static const String spaceActive = 'active';
  static const String spaceMaintenance = 'maintenance';
  static const String spaceInactive = 'inactive';
}
