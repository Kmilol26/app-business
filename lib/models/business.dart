import 'package:equatable/equatable.dart';

class Business extends Equatable {
  final String id;
  final String name;
  final String? contact;
  final String? phone;
  final String? website;
  final String? instagram;
  final String? address;
  final String? logo;
  final String? banner;
  final String? categoryMessage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? planId;

  const Business({
    required this.id,
    required this.name,
    this.contact,
    this.phone,
    this.website,
    this.instagram,
    this.address,
    this.logo,
    this.banner,
    this.categoryMessage,
    required this.createdAt,
    required this.updatedAt,
    this.planId,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'] as String,
      name: json['name'] as String,
      contact: json['contact'] as String?,
      phone: json['phone'] as String?,
      website: json['website'] as String?,
      instagram: json['instagram'] as String?,
      address: json['address'] as String?,
      logo: json['logo'] as String?,
      banner: json['banner'] as String?,
      categoryMessage: json['categoryMessage'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      planId: json['planId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'contact': contact,
      'phone': phone,
      'website': website,
      'instagram': instagram,
      'address': address,
      'logo': logo,
      'banner': banner,
      'categoryMessage': categoryMessage,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'planId': planId,
    };
  }

  @override
  List<Object?> get props => [id, name, contact, phone, website, instagram, address, logo, banner, categoryMessage, createdAt, updatedAt, planId];
}
