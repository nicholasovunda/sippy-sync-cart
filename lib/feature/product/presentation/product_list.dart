import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sippy_cart_sharing/common_widgets/animated_loader.dart';
import 'package:sippy_cart_sharing/feature/cart/application/cart_service.dart';
import 'package:sippy_cart_sharing/feature/cart/domain/item.dart';
import 'package:sippy_cart_sharing/feature/cart/presentation/item_counter.dart';
import 'package:sippy_cart_sharing/feature/cart/presentation/shopping_cart_display.dart';
import 'package:sippy_cart_sharing/feature/product/data/local/test_products.dart';

import 'package:sippy_cart_sharing/feature/session/data/local/local_session_repository.dart';
import 'package:sippy_cart_sharing/feature/session/domain/session.dart';

@RoutePage()
class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Future<Session> _sessionFuture;
  String? _activeUserId;
  final Map<String, int> _selectedQuantities = {};

  @override
  void initState() {
    super.initState();
    _sessionFuture =
        Provider.of<LocalSessionRepositoryImpl>(
          context,
          listen: false,
        ).fetchSession();
  }

  @override
  Widget build(BuildContext context) {
    final cartService = Provider.of<CartService>(context, listen: false);
    Provider.of<LocalSessionRepositoryImpl>(context, listen: false);

    return FutureBuilder<Session>(
      future: _sessionFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CustomLoadingIndicator());
        }

        final session = snapshot.data!;
        final String creatorId = session.creatorId;
        final guestIds = session.guestNames.keys.toList();
        _activeUserId ??= creatorId;

        final bool isCreator = _activeUserId == creatorId;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Products'),
            actions: [
              if (isCreator && guestIds.isNotEmpty)
                DropdownButton<String>(
                  value: _activeUserId,
                  icon: const Icon(Icons.arrow_drop_down),
                  onChanged: (value) {
                    setState(() => _activeUserId = value);
                  },
                  items: [
                    DropdownMenuItem(
                      value: creatorId,
                      child: const Text('Creator'),
                    ),
                    ...guestIds.map(
                      (id) => DropdownMenuItem(
                        value: id,
                        child: Text(session.guestNames[id] ?? 'Guest $id'),
                      ),
                    ),
                  ],
                ),
              const Padding(
                padding: EdgeInsets.only(right: 12),
                child: ShoppingCartIcon(),
              ),
            ],
          ),
          body: GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: testProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final product = testProducts[index];
              final int quantity = _selectedQuantities[product.id] ?? 1;

              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          product.imageUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('${product.price.toStringAsFixed(0)} NGN'),
                      const SizedBox(height: 6),
                      ItemQuantitySelector(
                        quantity: quantity,
                        maxQuantity: product.availableQuantity,
                        onChanged: (newQty) {
                          setState(() {
                            _selectedQuantities[product.id] = newQty;
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () async {
                          final item = Item(
                            productId: product.id,
                            quantity: quantity,
                            addedBy: _activeUserId ?? creatorId,
                          );
                          await cartService.addItem(item);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Added to cart')),
                          );
                        },
                        child: const Text('Add to Cart'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
