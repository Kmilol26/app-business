import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String id;
  final String title;
  final String? description;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final int capacity;
  final double price;
  final String status; // draft, published, cancelled
  final List<String> images;
  final String spaceId;
  final Space? space;
  final int? guestsCount;
  final int? salesCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Event({
    required this.id,
    required this.title,
    this.description,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.capacity,
    this.price = 0,
    this.status = 'draft',
    this.images = const [],
    required this.spaceId,
    this.space,
    this.guestsCount,
    this.salesCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    List<String> parseImages(dynamic imagesData) {
      if (imagesData == null) return [];
      if (imagesData is List) {
        return imagesData.cast<String>();
      }
      if (imagesData is String) {
        try {
          final parsed = List<String>.from(
            (imagesData.isNotEmpty ? List.from(Uri.decodeComponent(imagesData) as Iterable) : [])
          );
          return parsed;
        } catch (_) {
          return [];
        }
      }
      return [];
    }

    return Event(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      date: DateTime.parse(json['date'] as String),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      capacity: json['capacity'] as int,
      price: (json['price'] as num?)?.toDouble() ?? 0,
      status: json['status'] as String? ?? 'draft',
      images: parseImages(json['images']),
      spaceId: json['spaceId'] as String,
      space: json['space'] != null ? Space.fromJson(json['space']) : null,
      guestsCount: json['_count']?['guests'] as int?,
      salesCount: json['_count']?['sales'] as int?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'capacity': capacity,
      'price': price,
      'status': status,
      'images': images,
      'spaceId': spaceId,
    };
  }

  bool get isDraft => status == 'draft';
  bool get isPublished => status == 'published';
  bool get isCancelled => status == 'cancelled';

  @override
  List<Object?> get props => [id, title, description, date, startTime, endTime, capacity, price, status, images, spaceId, space, guestsCount, salesCount, createdAt, updatedAt];
}

class Space extends Equatable {
  final String id;
  final String name;
  final String? description;
  final int capacity;
  final List<String> images;
  final String? category;
  final String status; // active, maintenance, inactive
  final DateTime createdAt;
  final DateTime updatedAt;

  const Space({
    required this.id,
    required this.name,
    this.description,
    required this.capacity,
    this.images = const [],
    this.category,
    this.status = 'active',
    required this.createdAt,
    required this.updatedAt,
  });

  factory Space.fromJson(Map<String, dynamic> json) {
    List<String> parseImages(dynamic imagesData) {
      if (imagesData == null) return [];
      if (imagesData is List) return imagesData.cast<String>();
      return [];
    }

    return Space(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      capacity: json['capacity'] as int,
      images: parseImages(json['images']),
      category: json['category'] as String?,
      status: json['status'] as String? ?? 'active',
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'capacity': capacity,
      'images': images,
      'category': category,
      'status': status,
    };
  }

  bool get isActive => status == 'active';

  @override
  List<Object?> get props => [id, name, description, capacity, images, category, status, createdAt, updatedAt];
}
