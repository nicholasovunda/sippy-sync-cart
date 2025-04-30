import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String imageUrl;
  final String title;
  final String description;
  final double price;
  final int availableQuantity;

  const Product({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.availableQuantity,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      imageUrl: map['imageUrl'] as String,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      availableQuantity: map['availableQuantity']?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'imageUrl': imageUrl,
    'title': title,
    'description': description,
    'price': price,
    'availableQuantity': availableQuantity,
  };

  Product copyWith({
    String? id,
    String? imageUrl,
    String? title,
    String? description,
    double? price,
    int? availableQuantity,
  }) {
    return Product(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      availableQuantity: availableQuantity ?? this.availableQuantity,
    );
  }

  @override
  List<Object?> get props => [
    id,
    imageUrl,
    title,
    description,
    price,
    availableQuantity,
  ];

  @override
  bool? get stringify => true;
}
