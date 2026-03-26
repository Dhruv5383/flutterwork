// lib/models/service_provider.dart

class ServiceProvider {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final double rating;
  final String description;
  final String phone;
  final String address;
  final int reviews;

  ServiceProvider({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.rating,
    required this.description,
    required this.phone,
    required this.address,
    required this.reviews,
  });

  factory ServiceProvider.fromJson(Map<String, dynamic> json) {
    return ServiceProvider(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      imageUrl: json['imageUrl'] ?? json['avatar'] ?? '',
      rating: double.tryParse(json['rating']?.toString() ?? '4.0') ?? 4.0,
      description: json['description'] ?? 'Professional service provider in your city.',
      phone: json['phone'] ?? '+91 98765 43210',
      address: json['address'] ?? 'City Center, Your City',
      reviews: int.tryParse(json['reviews']?.toString() ?? '0') ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'imageUrl': imageUrl,
      'rating': rating,
      'description': description,
      'phone': phone,
      'address': address,
      'reviews': reviews,
    };
  }
}