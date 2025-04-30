// import 'package:sippy_cart_sharing/feature/cart/domain/item.dart';
// import 'package:sippy_cart_sharing/feature/cart/domain/mutable_cart.dart';
// import 'package:sippy_cart_sharing/feature/session/domain/session.dart';

// class SessionService {
//   /// Adds an item to the session's cart
//   Session addItemToCart({
//     required Session session,
//     required Item item,
//     required GuestId guestId,
//   }) {
//     final updatedCart = session.cart.addItem(item, guestId);
//     return session.updateCart(updatedCart);
//   }

//   /// Adds a guest to the session
//   Session addGuest({
//     required Session session,
//     required GuestId guestId,
//     required String guestName,
//   }) {
//     return session.addGuest(guestId, guestName);
//   }

//   /// Removes an item from the cart by productId
//   Session removeItemFromCart({
//     required Session session,
//     required String productId,
//   }) {
//     final updatedCart = session.cart.removeItemById(productId);
//     return session.updateCart(updatedCart);
//   }
// }
