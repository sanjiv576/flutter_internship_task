import 'package:equatable/equatable.dart';

// product is child class  of Equatable to create a single instance for lowering memory consumption
class Product extends Equatable {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double rating;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

// convert JSON to product model entity
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
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
