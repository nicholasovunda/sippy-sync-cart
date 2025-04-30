import 'package:sippy_cart_sharing/feature/cart/domain/item.dart';
import 'package:sippy_cart_sharing/feature/cart/domain/mutable_cart.dart';

import 'package:sippy_cart_sharing/feature/session/domain/session.dart';

extension MutableSession on Session {
  Session updateCart(Item item, GuestId addedBy) {
    final updatedCart = cart.setItem(item, addedBy);
    return Session(
      sessionId: sessionId,
      creatorId: creatorId,
      guestNames: guestNames,
      cart: updatedCart,
    );
  }

  Session addGuest(GuestId guestId, String guestName) {
    final newGuestNames = Map<GuestId, String>.from(guestNames);
    newGuestNames[guestId] = guestName;
    return Session(
      sessionId: sessionId,
      creatorId: creatorId,
      guestNames: newGuestNames,
      cart: cart,
    );
  }

  // Removes a guest from the session
  Session removeGuest(GuestId guestId) {
    final newGuestNames = Map<GuestId, String>.from(guestNames);
    newGuestNames.remove(guestId);

    return Session(
      sessionId: sessionId,
      creatorId: creatorId,
      guestNames: newGuestNames,
      cart: cart,
    );
  }

  // Delete item from a cart
  Session deleteFromCart(String productId) {
    final updatedCart = cart.removeItemById(productId);
    return Session(
      sessionId: sessionId,
      creatorId: creatorId,
      guestNames: guestNames,
      cart: updatedCart,
    );
  }

  // Clear all guests and reset cart
  Session endSession() {
    return Session(
      sessionId: sessionId,
      creatorId: creatorId,
      guestNames: {},
      cart: cart,
    );
  }
}
