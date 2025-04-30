import 'package:flutter/material.dart';

/// Item quantity selector with +/- buttons and a text value in the middle
class ItemQuantitySelector extends StatelessWidget {
  const ItemQuantitySelector({
    super.key,
    required this.quantity,
    this.maxQuantity = 10,
    this.itemIndex,
    this.onChanged,
  });
  final int quantity;
  final int maxQuantity;
  final int? itemIndex;
  final ValueChanged<int>? onChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(24)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.remove, weight: 12),
            onPressed:
                onChanged != null && quantity > 1
                    ? () => onChanged!.call(quantity - 1)
                    : null,
          ),
          SizedBox(
            width: 30.0,
            child: Text(
              '$quantity',

              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, weight: 12),
            onPressed:
                onChanged != null && quantity < maxQuantity
                    ? () => onChanged!.call(quantity + 1)
                    : null,
          ),
        ],
      ),
    );
  }
}
