import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/cart_item.dart';
import '../data/models/product.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  void addProduct(Product product) {
    final items = List<CartItem>.from(state.items);
    final index = items.indexWhere((i) => i.product.id == product.id);
    if (index >= 0) {
      items[index] = CartItem(
        product: items[index].product,
        quantity: items[index].quantity + 1,
      );
    } else {
      items.add(CartItem(product: product));
    }
    emit(state.copyWith(items: items));
  }

  void increment(int productId) {
    final items = List<CartItem>.from(state.items);
    final index = items.indexWhere((i) => i.product.id == productId);
    if (index >= 0) {
      items[index] = CartItem(
        product: items[index].product,
        quantity: items[index].quantity + 1,
      );
      emit(state.copyWith(items: items));
    }
  }

  void decrement(int productId) {
    final items = List<CartItem>.from(state.items);
    final index = items.indexWhere((i) => i.product.id == productId);
    if (index >= 0) {
      if (items[index].quantity > 1) {
        items[index] = CartItem(
          product: items[index].product,
          quantity: items[index].quantity - 1,
        );
      } else {
        items.removeAt(index);
      }
      emit(state.copyWith(items: items));
    }
  }

  void remove(int productId) {
    final items = List<CartItem>.from(state.items)
      ..removeWhere((i) => i.product.id == productId);
    emit(state.copyWith(items: items));
  }

  void clear() => emit(const CartState());
}
