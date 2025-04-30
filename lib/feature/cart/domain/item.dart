import 'package:equatable/equatable.dart';

// A product and the quantity to be added to cart
// class Item extends Equatable {
//   final String productId;
//   final int quantity;

//   const Item({required this.productId, required this.quantity});
//   @override
//   List<Object?> get props => [productId, quantity];

//   @override
//   bool? get stringify => true;
// }

class Item extends Equatable {
  final String productId;
  final int quantity;
  final String addedBy;

  const Item({
    required this.productId,
    required this.quantity,
    required this.addedBy,
  });

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      productId: map['productId'],
      quantity: map['quantity'],
      addedBy: map['addedBy'],
    );
  }

  Map<String, dynamic> toMap() => {
    'productId': productId,
    'quantity': quantity,
    'addedBy': addedBy,
  };

  Item copyWith({int? quantity, String? addedBy}) {
    return Item(
      productId: productId,
      quantity: quantity ?? this.quantity,
      addedBy: addedBy ?? this.addedBy,
    );
  }

  @override
  List<Object?> get props => [productId, quantity, addedBy];

  @override
  bool? get stringify => true;
}
