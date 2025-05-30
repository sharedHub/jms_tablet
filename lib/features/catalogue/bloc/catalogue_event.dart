// catalogue_event.dart
part of 'catalogue_bloc.dart';

abstract class CatalogueEvent {}

class LoadCatalogueItems extends CatalogueEvent {
  final int page;
  final int itemsPerPage;

  LoadCatalogueItems({this.page = 0, this.itemsPerPage = 10});
}

class AddToCart extends CatalogueEvent {
  final JewelleryStockItemData item;

  AddToCart({required this.item});
}

class UpdateCartItemQuantity extends CatalogueEvent {
  final JewelleryStockItemData item;
  final int newQuantity;

  UpdateCartItemQuantity({required this.item, required this.newQuantity});
}

class RemoveFromCart extends CatalogueEvent {
  final JewelleryStockItemData item;

  RemoveFromCart({required this.item});
}

// 👇 NEW EVENT
class LoadCart extends CatalogueEvent {}