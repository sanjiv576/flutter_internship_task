import 'package:equatable/equatable.dart';

// ProductEntity is child class  of Equatable to create a single instance for lowering memory consumption
class ProductEntity extends Equatable {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double rating;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

// convert JSON to ProductEntity model entity
  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: json['rating']['rate'].toDouble(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        image,
        description,
        category,
        price,
        rating,
      ];

  @override
  String toString() {
    return 'id: $id, title: $title, price: $price, description: $description, image: $image, rating: $rating';
  }
}
