part of 'catalogue_bloc.dart';

abstract class CatalogueState {}

class CatalogueInitial extends CatalogueState {}

class CatalogueLoading extends CatalogueState {}

class CatalogueLoaded extends CatalogueState {
  final List<JewelleryStockItemData> items;
  final bool hasReachedMax;
  final List<CartItem> cartItems; // 👈 Added cart list

  CatalogueLoaded({
    required this.items,
    required this.hasReachedMax,
    this.cartItems = const [],
  });

  // ✅ Add this copyWith method
  CatalogueLoaded copyWith({
    List<JewelleryStockItemData>? items,
    bool? hasReachedMax,
    List<CartItem>? cartItems,
  }) {
    return CatalogueLoaded(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      cartItems: cartItems ?? this.cartItems,
    );
  }
}

class CatalogueError extends CatalogueState {
  final String message;

  CatalogueError(this.message);
}