import 'package:sippy_cart_sharing/feature/cart/data/local/local_repository.dart';
import 'package:sippy_cart_sharing/feature/cart/domain/cart.dart';

class FakeLocalRepository implements LocalCartRepository {
  @override
  Future<Cart> streamCart() {
    // TODO: implement addGuest
    throw UnimplementedError();
  }

  @override
  Future<Cart> fetchCart() {
    // TODO: implement fetchCart
    throw UnimplementedError();
  }

  @override
  Future<void> setCart(Cart cart) {
    // TODO: implement setCart
    throw UnimplementedError();
  }
}
