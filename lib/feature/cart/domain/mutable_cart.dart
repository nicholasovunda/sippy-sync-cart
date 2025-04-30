import 'package:sippy_cart_sharing/feature/cart/domain/cart.dart';
import 'package:sippy_cart_sharing/feature/cart/domain/cart_item_details.dart';
import 'package:sippy_cart_sharing/feature/cart/domain/item.dart';
import 'package:sippy_cart_sharing/feature/session/domain/session.dart';

extension MutableCart on Cart {
  // add items to cart by updating quantity if it exist
  Cart setItem(Item item, GuestId addedBy) {
    final copy = Map<String, CartItemDetails>.from(items);
    copy[item.productId] = CartItemDetails(
      quantity: item.quantity,
      addedBy: addedBy,
    );
    return Cart(copy);
  }

  // Add item to existing cart by updating it
  Cart addItem(Item item, GuestId addedBy) {
    final copy = Map<String, CartItemDetails>.from(items);
    copy.update(
      item.productId,
      (details) => CartItemDetails(
        quantity: details.quantity + item.quantity,
        addedBy: addedBy,
      ),
      ifAbsent:
          () => CartItemDetails(quantity: item.quantity, addedBy: addedBy),
    );
    return Cart(copy);
  }

  // add list of items to cart
  Cart addItems(List<Item> itemsList, GuestId addedBy) {
    final copy = Map<String, CartItemDetails>.from(items);
    for (var item in itemsList) {
      copy.update(
        item.productId,

        (details) => CartItemDetails(
          quantity: details.quantity + item.quantity,
          addedBy: addedBy,
        ),

        ifAbsent:
            () => CartItemDetails(quantity: item.quantity, addedBy: addedBy),
      );
    }
    return Cart(copy);
  }

  // Remove item using ProductId
  Cart removeItemById(String productId) {
    final copy = Map<String, CartItemDetails>.from(items);
    copy.remove(productId);
    return Cart(copy);
  }
}
