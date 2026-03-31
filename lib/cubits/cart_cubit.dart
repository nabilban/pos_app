import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/cart_item.dart';
import '../data/models/product.dart';
import '../data/models/variant.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  void addProduct(Product product, {List<VariantOption> selectedOptions = const []}) {
    final items = List<CartItem>.from(state.items);
    
    // Check if item with same product AND same options exists
    final newItem = CartItem(
      product: product,
      selectedOptions: selectedOptions,
      quantity: 1,
    );

    final index = items.indexWhere((i) {
      if (i.product.id != product.id) return false;
      if (i.selectedOptions.length != selectedOptions.length) return false;
      
      // Compare option IDs
      final existingIds = i.selectedOptions.map((o) => o.id).toSet();
      final newIds = selectedOptions.map((o) => o.id).toSet();
      return existingIds.containsAll(newIds);
    });

    if (index >= 0) {
      items[index] = items[index].copyWith(
        quantity: items[index].quantity + 1,
      );
    } else {
      items.add(newItem);
    }
    emit(state.copyWith(items: items));
  }

  void increment(CartItem item) {
    final items = List<CartItem>.from(state.items);
    final index = items.indexOf(item);
    if (index >= 0) {
      items[index] = items[index].copyWith(
        quantity: items[index].quantity + 1,
      );
      emit(state.copyWith(items: items));
    }
  }

  void decrement(CartItem item) {
    final items = List<CartItem>.from(state.items);
    final index = items.indexOf(item);
    if (index >= 0) {
      if (items[index].quantity > 1) {
        items[index] = items[index].copyWith(
          quantity: items[index].quantity - 1,
        );
      } else {
        items.removeAt(index);
      }
      emit(state.copyWith(items: items));
    }
  }

  void remove(CartItem item) {
    final items = List<CartItem>.from(state.items)..remove(item);
    emit(state.copyWith(items: items));
  }

  void clear() => emit(const CartState());
}
