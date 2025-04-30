import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:sippy_cart_sharing/feature/cart/domain/item.dart';

// Model class for Cart
class Cart extends Equatable {
  final Map<String, Item> items;

  const Cart([this.items = const {}]);

  // Convert from Map for deserialization
  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      Map<String, Item>.fromEntries(
        (map['items'] as Map<String, dynamic>).entries.map(
          (entry) => MapEntry(entry.key, Item.fromMap(entry.value)),
        ),
      ),
    );
  }

  // Convert to Map for serialization
  Map<String, dynamic> toMap() {
    return {'items': items.map((key, value) => MapEntry(key, value.toMap()))};
  }

  // Convert from JSON
  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));

  // Convert to JSON
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [items];

  @override
  bool? get stringify => true;
}

// Getting all items in cart as a List of Items
extension CartItems on Cart {
  List<Item> toItemList() {
    return items.values.toList();
  }
}
