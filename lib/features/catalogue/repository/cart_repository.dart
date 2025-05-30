// /features/catalogue/repository/cart_repository.dart
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:jms_tablet/features/catalogue/models/jewellery_stock_item_data.dart';

import '../models/cart_item_model.dart';

class CartRepository {
  static const String _cartKey = 'cart_items';

  Future<void> saveCart(List<CartItem> cartItems) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonList =
    cartItems.map((item) => itemToJson(item)).toList();
    await prefs.setStringList(_cartKey, jsonList);
  }

  Future<List<CartItem>> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList(_cartKey);
    if (jsonList == null || jsonList.isEmpty) return [];

    return jsonList.map((str) => jsonToCartItem(str)).toList();
  }

  String itemToJson(CartItem item) {
    final map = {
      'item': item.item.toJson(),
      'quantity': item.quantity,
    };
    return jsonEncode(map);
  }

  CartItem jsonToCartItem(String str) {
    final map = jsonDecode(str) as Map<String, dynamic>;
    final item = JewelleryStockItemData.fromJson(map['item']);
    final quantity = map['quantity'] as int;
    return CartItem(item: item, quantity: quantity);
  }
}