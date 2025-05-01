import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sippy_cart_sharing/feature/cart/application/cart_service.dart';

class ShoppingCartIcon extends StatelessWidget {
  const ShoppingCartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final cartService = context.read<CartService>();

    return FutureBuilder<int>(
      future: cartService.getCartItemsCount(),
      builder: (context, snapshot) {
        final cartItemsCount = snapshot.data ?? 0;

        return Stack(
          children: [
            Center(
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  // TODO: Navigate to cart page
                },
              ),
            ),
            if (cartItemsCount > 0)
              Positioned(
                top: 4,
                right: 4,
                child: ShoppingCartIconBadge(itemsCount: cartItemsCount),
              ),
          ],
        );
      },
    );
  }
}

/// Icon badge showing the items count
class ShoppingCartIconBadge extends StatelessWidget {
  const ShoppingCartIconBadge({super.key, required this.itemsCount});
  final int itemsCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
      height: 16,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: Text(
          '$itemsCount',
          textAlign: TextAlign.center,
          textScaler: const TextScaler.linear(1.0),
          style: Theme.of(
            context,
          ).textTheme.bodySmall!.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
