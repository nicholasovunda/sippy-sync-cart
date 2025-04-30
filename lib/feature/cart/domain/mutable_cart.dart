import 'package:sippy_cart_sharing/feature/cart/domain/cart.dart';
import 'package:sippy_cart_sharing/feature/cart/domain/item.dart';

extension MutableCart on Cart {
  // Replace or insert an item in the cart
  Cart setItem(Item item) {
    final copy = Map<String, Item>.from(items);
    copy[item.productId] = item;
    return Cart(copy);
  }

  // Add to existing quantity if the item exists, else insert it
  Cart addItem(Item item) {
    final copy = Map<String, Item>.from(items);
    copy.update(
      item.productId,
      (existing) =>
          existing.copyWith(quantity: existing.quantity + item.quantity),
      ifAbsent: () => item,
    );
    return Cart(copy);
  }

  // Add a list of items to the cart
  Cart addItems(List<Item> itemsList) {
    final copy = Map<String, Item>.from(items);
    for (var item in itemsList) {
      copy.update(
        item.productId,
        (existing) =>
            existing.copyWith(quantity: existing.quantity + item.quantity),
        ifAbsent: () => item,
      );
    }
    return Cart(copy);
  }

  // Remove an item by its productId
  Cart removeItemById(String productId) {
    final copy = Map<String, Item>.from(items);
    copy.remove(productId);
    return Cart(copy);
  }
}
