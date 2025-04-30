import 'package:sippy_cart_sharing/feature/cart/domain/item.dart';
import 'package:sippy_cart_sharing/feature/session/domain/session.dart';

abstract class LocalSessionRepository {
  // Get the current session
  Future<Session> fetchSession();

  // Create a new session
  Future<void> startSession({required String creatorId});

  // Add a guest
  Future<void> addGuest({required GuestId guestId, required String guestName});

  // Remove a guest
  Future<void> removeGuest({required GuestId guestId});

  // Add an item to the cart
  Future<void> addItemToCart({required Item item});

  // Remove an item from the cart
  Future<void> removeItemFromCart({required String productId});

  Future<void> setSession(Session session);

  // End the session
  Future<void> endSession();
}
