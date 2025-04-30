import 'package:equatable/equatable.dart';

// A product and the quantity to be added to cart
class Item extends Equatable {
  final String productId;
  final int quantity;

  const Item({required this.productId, required this.quantity});
  @override
  List<Object?> get props => [productId, quantity];

  @override
  bool? get stringify => true;
}
