import 'package:equatable/equatable.dart';
import 'package:sippy_cart_sharing/feature/session/domain/session.dart';

class CartItemDetails extends Equatable {
  final int quantity;
  final GuestId addedBy;

  const CartItemDetails({required this.quantity, required this.addedBy});

  factory CartItemDetails.fromMap(Map<String, dynamic> map) {
    return CartItemDetails(
      quantity: map['quantity'] ?? 0,
      addedBy: map['addedBy'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {'quantity': quantity, 'addedBy': addedBy};

  @override
  List<Object?> get props => [quantity, addedBy];
}
