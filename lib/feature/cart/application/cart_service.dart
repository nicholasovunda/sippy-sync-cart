import 'dart:math';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:sippy_cart_sharing/feature/cart/domain/cart.dart';
import 'package:sippy_cart_sharing/feature/cart/domain/item.dart';
import 'package:sippy_cart_sharing/feature/cart/domain/mutable_cart.dart';
import 'package:sippy_cart_sharing/feature/product/domain/product.dart';

import 'package:sippy_cart_sharing/feature/session/data/local/local_repository.dart';

class CartService with ChangeNotifier {
  final LocalSessionRepository localSessionRepository;

  CartService({required this.localSessionRepository});

  Future<Cart> _fetchCart() async {
    final session = await localSessionRepository.fetchSession();
    return session.cart;
  }

  Future<void> _setCart(Cart cart) async {
    final session = await localSessionRepository.fetchSession();
    final updatedSession = session.copyWith(cart: cart);
    await localSessionRepository.setSession(updatedSession);
    notifyListeners();
  }

  Future<void> setItem(Item item) async {
    final cart = await _fetchCart();
    final updated = cart.setItem(item);
    await _setCart(updated);
  }

  Future<void> addItem(Item item) async {
    final cart = await _fetchCart();
    final updated = cart.addItem(item);
    await _setCart(updated);
  }

  Future<void> removeItemById(String productId) async {
    final cart = await _fetchCart();
    final updated = cart.removeItemById(productId);
    await _setCart(updated);
  }

  Future<int> getCartItemsCount() async {
    final cart = await _fetchCart();
    return cart.items.length;
  }

  Future<double> getCartTotal(List<Product> productsList) async {
    final cart = await _fetchCart();
    if (cart.items.isEmpty || productsList.isEmpty) return 0.0;

    double total = 0.0;
    for (final entry in cart.items.entries) {
      final product = productsList.firstWhereOrNull((p) => p.id == entry.key);
      if (product != null) {
        total += product.price * entry.value.quantity;
      }
    }
    return total;
  }

  Future<int> getAvailableQuantity(Product product) async {
    final cart = await _fetchCart();
    final quantity = cart.items[product.id]?.quantity ?? 0;
    return max(0, product.availableQuantity - quantity);
  }
}
