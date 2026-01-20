import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String? name;
  final String? businessId;

  const User({
    required this.id,
    required this.email,
    this.name,
    this.businessId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      businessId: json['businessId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'businessId': businessId,
    };
  }

  @override
  List<Object?> get props => [id, email, name, businessId];
}

class DashboardMetrics extends Equatable {
  final double revenue;
  final int tickets;
  final int activeEvents;
  final int totalGuests;
  final List<Sale> recentSales;

  const DashboardMetrics({
    required this.revenue,
    required this.tickets,
    required this.activeEvents,
    required this.totalGuests,
    this.recentSales = const [],
  });

  factory DashboardMetrics.fromJson(Map<String, dynamic> json) {
    return DashboardMetrics(
      revenue: (json['revenue'] as num?)?.toDouble() ?? 0,
      tickets: json['tickets'] as int? ?? 0,
      activeEvents: json['activeEvents'] as int? ?? 0,
      totalGuests: json['totalGuests'] as int? ?? 0,
      recentSales: (json['recentSales'] as List<dynamic>?)
          ?.map((e) => Sale.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
    );
  }

  @override
  List<Object?> get props => [revenue, tickets, activeEvents, totalGuests, recentSales];
}

class Sale extends Equatable {
  final String id;
  final double amount;
  final DateTime createdAt;

  const Sale({
    required this.id,
    required this.amount,
    required this.createdAt,
  });

  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  @override
  List<Object?> get props => [id, amount, createdAt];
}
