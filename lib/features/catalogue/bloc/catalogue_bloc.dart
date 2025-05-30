import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_item_model.dart';
import '../models/jewellery_stock_item_data.dart';
import '../repository/cart_repository.dart';
import '../repository/category_repository.dart';

part 'catalogue_event.dart';
part 'catalogue_state.dart';

class CatalogueBloc extends Bloc<CatalogueEvent, CatalogueState> {
  final CatalogueRepository repository;
  final CartRepository cartRepository;

  CatalogueBloc({
    required this.repository,
    required this.cartRepository,
  }) : super(CatalogueInitial()) {
    on<LoadCatalogueItems>(_onLoadCatalogueItems);
    on<AddToCart>(_onAddToCart);
    on<UpdateCartItemQuantity>(_onUpdateCartItemQuantity);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<LoadCart>(_onLoadCart);
  }

  Future<void> _onLoadCatalogueItems(
      LoadCatalogueItems event, Emitter<CatalogueState> emit) async {
    try {
      if (state is CatalogueInitial || event.page == 0) {
        emit(CatalogueLoading());
        final items = await repository.getItemListData(event.page, event.itemsPerPage);
        final savedCart = await cartRepository.loadCart();

        if (items.isEmpty) {
          emit(CatalogueLoaded(items: [], hasReachedMax: true, cartItems: savedCart));
        } else {
          emit(CatalogueLoaded(
            items: items,
            hasReachedMax: items.length < event.itemsPerPage,
            cartItems: savedCart,
          ));
        }
      } else if (state is CatalogueLoaded) {
        final currentState = state as CatalogueLoaded;
        final newItems = await repository.getItemListData(event.page, event.itemsPerPage);

        if (newItems.isEmpty) {
          emit(currentState.copyWith(hasReachedMax: true));
        } else {
          emit(currentState.copyWith(
            items: [...currentState.items, ...newItems],
            hasReachedMax: newItems.length < event.itemsPerPage,
          ));
        }
      }
    } catch (e) {
      emit(CatalogueError(e.toString()));
    }
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<CatalogueState> emit) async {
    final state = this.state;
    if (state is CatalogueLoaded) {
      // Always add a new item, no grouping
      final updatedCart = List<CartItem>.from(state.cartItems)
        ..add(CartItem(item: event.item));

      await cartRepository.saveCart(updatedCart);
      emit(state.copyWith(cartItems: updatedCart));
    }
  }

  Future<void> _onUpdateCartItemQuantity(
      UpdateCartItemQuantity event, Emitter<CatalogueState> emit) async {
    final state = this.state;
    if (state is CatalogueLoaded) {
      final existingIndex = state.cartItems.indexWhere(
              (cartItem) => identical(cartItem.item, event.item));

      if (existingIndex >= 0 && event.newQuantity > 0) {
        final updatedCart = List<CartItem>.from(state.cartItems)
          ..[existingIndex] =
          state.cartItems[existingIndex].copyWith(quantity: event.newQuantity);

        await cartRepository.saveCart(updatedCart);
        emit(state.copyWith(cartItems: updatedCart));
      }
    }
  }

  Future<void> _onRemoveFromCart(
      RemoveFromCart event, Emitter<CatalogueState> emit) async {
    final state = this.state;
    if (state is CatalogueLoaded) {
      final updatedCart = state.cartItems
          .where((item) => !identical(item.item, event.item))
          .toList();

      await cartRepository.saveCart(updatedCart);
      emit(state.copyWith(cartItems: updatedCart));
    }
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CatalogueState> emit) async {
    final savedCart = await cartRepository.loadCart();
    if (state is CatalogueLoaded) {
      emit((state as CatalogueLoaded).copyWith(cartItems: savedCart));
    }
  }
}