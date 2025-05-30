import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/catalogue_bloc.dart';
import '../models/cart_item_model.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;

  const CartItemCard({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {

    void _removeFromCart() {
      // Access the context via the widget's context property
      BlocProvider.of<CatalogueBloc>(context).add(RemoveFromCart(item: cartItem.item));
    }

    void _increment() {
      BlocProvider.of<CatalogueBloc>(context).add(
        UpdateCartItemQuantity(
          item: cartItem.item,
          newQuantity: cartItem.quantity + 1,
        ),
      );
    }

    void _decrement() {
      if (cartItem.quantity > 1) {
        BlocProvider.of<CatalogueBloc>(context).add(
          UpdateCartItemQuantity(
            item: cartItem.item,
            newQuantity: cartItem.quantity - 1,
          ),
        );
      }
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.09,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFA7B5C4)),
      ),
      child: Row(
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 50,
              width: 50,
              color: Colors.grey.shade300,
              child: cartItem.item.imageBytes != null
                  ? Image.memory(
                cartItem.item.imageBytes!,
                fit: BoxFit.cover,
              )
                  : const Icon(Icons.image, color: Colors.grey),
            ),
          ),
          const SizedBox(width: 12),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Product Name and Close Icon
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        cartItem.item.itemDesignNo ?? "Jewellery Item",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: _removeFromCart,
                      child: const Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),

                // Product Code
                Text(
                  cartItem.item.itemBarcode ?? "N/A",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),

                // Price and Quantity
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "₹ ${cartItem.totalPrice.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    QuantityControl(
                      quantity: cartItem.quantity,
                      onIncrement: () => _increment(),
                      onDecrement: () => _decrement(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QuantityControl extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantityControl({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onDecrement,
            child: Container(
              padding: const EdgeInsets.all(4),
              child: const Icon(Icons.remove, size: 14, color: Colors.grey),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Text(
              "$quantity",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          GestureDetector(
            onTap: onIncrement,
            child: Container(
              padding: const EdgeInsets.all(4),
              child: const Icon(Icons.add, size: 14, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}