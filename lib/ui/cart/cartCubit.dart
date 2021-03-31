import 'package:bloc/bloc.dart';
import 'package:fruty_chamoy_flutter/models/productModel.dart';
import 'package:meta/meta.dart';

part 'cartState.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial([]));

  final List<ProductModel> items = [];

  void addProductToCart(ProductModel product) {
    if (items.contains(product)) {
      emit(ProductExistCartState('Producto ya ha sido agregado'));
    } else {
      items.add(product);
      emit(ProductsAddedCartState(items));
    }
  }

  void resetCart() {
    items.clear();
    emit(CartInitial([]));
  }
}
