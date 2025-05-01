import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sippy_cart_sharing/common_widgets/animated_loader.dart';
import 'package:sippy_cart_sharing/feature/cart/application/cart_service.dart';
import 'package:sippy_cart_sharing/feature/product/data/local/test_products.dart';

import 'package:sippy_cart_sharing/feature/session/data/local/local_session_repository.dart';
import 'package:sippy_cart_sharing/feature/session/domain/session.dart';

@RoutePage()
class CartSummaryScreen extends StatelessWidget {
  const CartSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartService = Provider.of<CartService>(context, listen: false);
    final sessionRepo = Provider.of<LocalSessionRepositoryImpl>(
      context,
      listen: false,
    );

    return FutureBuilder(
      future: Future.wait([
        sessionRepo.fetchSession(),
        cartService.getCartTotal(testProducts),
      ]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CustomLoadingIndicator());
        }

        final session = snapshot.data![0] as Session;
        final cart = session.cart;
        final total = snapshot.data![1] as double;

        return Scaffold(
          appBar: AppBar(title: const Text('Cart Summary')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ...cart.items.entries.map((entry) {
                final product = testProducts.firstWhere(
                  (p) => p.id == entry.key,
                );
                final item = entry.value;
                final addedByName =
                    item.addedBy == session.creatorId
                        ? session.creatorId
                        : session.guestNames[item.addedBy] ?? 'Unknown';

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Image.asset(product.imageUrl, width: 50),
                    title: Text(product.title),
                    subtitle: Text(
                      '${item.quantity} × ${product.price.toStringAsFixed(0)} NGN\nAdded by: $addedByName',
                      style: TextStyle(
                        color:
                            addedByName == session.creatorId
                                ? Colors.purple
                                : Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    isThreeLine: true,
                    trailing: Text(
                      '${(item.quantity * product.price).toStringAsFixed(0)} NGN',
                    ),
                  ),
                );
              }),
              const Divider(height: 32),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Total: ${total.toStringAsFixed(0)} NGN',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
