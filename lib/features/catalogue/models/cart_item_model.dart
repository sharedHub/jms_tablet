import 'package:jms_tablet/features/catalogue/models/jewellery_stock_item_data.dart';

class CartItem {
  final JewelleryStockItemData item;
  int quantity;

  CartItem({required this.item, this.quantity = 1});

  CartItem copyWith({int? quantity}) {
    return CartItem(
      item: item,
      quantity: quantity ?? this.quantity,
    );
  }

  double get totalPrice => item.itemTPrice! * quantity;
}