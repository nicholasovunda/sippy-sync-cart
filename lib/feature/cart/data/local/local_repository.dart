import 'package:sippy_cart_sharing/feature/cart/domain/cart.dart';

// abstract class for both local and remote repository
abstract class LocalCartRepository {
  Future<Cart> fetchCart();

  Future<Cart> streamCart();

  Future<void> setCart(Cart cart);
}
