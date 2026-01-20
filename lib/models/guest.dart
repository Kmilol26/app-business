import 'package:equatable/equatable.dart';

class Guest extends Equatable {
  final String id;
  final String name;
  final String email;
  final String status; // pending, approved, rejected, attended
  final String? qrCode;
  final String eventId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Guest({
    required this.id,
    required this.name,
    required this.email,
    this.status = 'pending',
    this.qrCode,
    required this.eventId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Guest.fromJson(Map<String, dynamic> json) {
    return Guest(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      status: json['status'] as String? ?? 'pending',
      qrCode: json['qrCode'] as String?,
      eventId: json['eventId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'status': status,
      'qrCode': qrCode,
      'eventId': eventId,
    };
  }

  bool get isPending => status == 'pending';
  bool get isApproved => status == 'approved';
  bool get isRejected => status == 'rejected';
  bool get hasAttended => status == 'attended';

  @override
  List<Object?> get props => [id, name, email, status, qrCode, eventId, createdAt, updatedAt];
}

class Sale extends Equatable {
  final String id;
  final double amount;
  final String status; // completed, refunded
  final String buyerName;
  final String buyerEmail;
  final String eventId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Sale({
    required this.id,
    required this.amount,
    this.status = 'completed',
    required this.buyerName,
    required this.buyerEmail,
    required this.eventId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      status: json['status'] as String? ?? 'completed',
      buyerName: json['buyerName'] as String,
      buyerEmail: json['buyerEmail'] as String,
      eventId: json['eventId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'status': status,
      'buyerName': buyerName,
      'buyerEmail': buyerEmail,
      'eventId': eventId,
    };
  }

  bool get isCompleted => status == 'completed';
  bool get isRefunded => status == 'refunded';

  @override
  List<Object?> get props => [id, amount, status, buyerName, buyerEmail, eventId, createdAt, updatedAt];
}
