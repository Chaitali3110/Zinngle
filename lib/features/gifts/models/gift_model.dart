import 'package:flutter/material.dart';

/// Gift model for the gift catalog
class Gift {
  final String id;
  final String name;
  final GiftCategory category;
  final int priceInr;
  final String imagePath;
  final String effectPath;
  final String soundPath;

  const Gift({
    required this.id,
    required this.name,
    required this.category,
    required this.priceInr,
    required this.imagePath,
    required this.effectPath,
    required this.soundPath,
  });

  factory Gift.fromJson(Map<String, dynamic> json) {
    return Gift(
      id: json['id'] as String,
      name: json['name'] as String,
      category: GiftCategory.fromString(json['category'] as String),
      priceInr: json['price_inr'] as int,
      imagePath: json['image_path'] as String,
      effectPath: json['effect_path'] as String,
      soundPath: json['sound_path'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category.id,
      'price_inr': priceInr,
      'image_path': imagePath,
      'effect_path': effectPath,
      'sound_path': soundPath,
    };
  }
}

/// Gift category with pricing and color
class GiftCategory {
  final String id;
  final String name;
  final int minPrice;
  final int maxPrice;
  final Color color;

  const GiftCategory({
    required this.id,
    required this.name,
    required this.minPrice,
    required this.maxPrice,
    required this.color,
  });

  factory GiftCategory.fromJson(Map<String, dynamic> json) {
    return GiftCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      minPrice: json['min_price'] as int,
      maxPrice: json['max_price'] as int,
      color: Color(int.parse(json['color'].toString().replaceFirst('#', '0xFF'))),
    );
  }

  factory GiftCategory.fromString(String categoryId) {
    switch (categoryId.toLowerCase()) {
      case 'common':
        return const GiftCategory(
          id: 'common',
          name: 'Common',
          minPrice: 9,
          maxPrice: 24,
          color: Color(0xFF4CAF50),
        );
      case 'hot':
        return const GiftCategory(
          id: 'hot',
          name: 'Hot',
          minPrice: 109,
          maxPrice: 199,
          color: Color(0xFFFF5722),
        );
      case 'expensive':
        return const GiftCategory(
          id: 'expensive',
          name: 'Expensive',
          minPrice: 799,
          maxPrice: 1500,
          color: Color(0xFF9C27B0),
        );
      case 'luxury':
        return const GiftCategory(
          id: 'luxury',
          name: 'Luxury',
          minPrice: 4000,
          maxPrice: 9999,
          color: Color(0xFFFFD700),
        );
      default:
        return const GiftCategory(
          id: 'common',
          name: 'Common',
          minPrice: 9,
          maxPrice: 24,
          color: Color(0xFF4CAF50),
        );
    }
  }
}

/// Gift catalog with all gifts and categories
class GiftCatalog {
  final List<Gift> gifts;
  final List<GiftCategory> categories;

  const GiftCatalog({
    required this.gifts,
    required this.categories,
  });

  factory GiftCatalog.fromJson(Map<String, dynamic> json) {
    return GiftCatalog(
      gifts: (json['gifts'] as List)
          .map((giftJson) => Gift.fromJson(giftJson as Map<String, dynamic>))
          .toList(),
      categories: (json['categories'] as List)
          .map((catJson) => GiftCategory.fromJson(catJson as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get gifts by category
  List<Gift> getGiftsByCategory(String categoryId) {
    return gifts.where((gift) => gift.category.id == categoryId).toList();
  }

  /// Get gift by ID
  Gift? getGiftById(String giftId) {
    try {
      return gifts.firstWhere((gift) => gift.id == giftId);
    } catch (e) {
      return null;
    }
  }
}
