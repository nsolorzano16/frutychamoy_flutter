import 'package:bloc/bloc.dart';
import 'package:fruty_chamoy_flutter/models/cartModel.dart';
//TODO: revisar totales y calcularlos bien

import 'package:meta/meta.dart';

part 'cartState.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial([]));

  final List<CartModel> items = [];
  double gain = 0;
  int productsQty = 0;
  double total = 0;

  void addProductToCart(CartModel item) {
    if (item.product.units > 0) {
      bool itemExist =
          items.any((element) => item.product.id == element.product.id);

      if (itemExist) {
        emit(ProductExistCartState('Producto ya ha sido agregado'));
      } else {
        items.add(item);
        calculateTotals(false);
        emit(ProductsAddedCartState(items));
      }
    } else {
      emit(ProductExistCartState('Producto no disponible'));
    }
  }

  void removeQuantityItemCart(int index) {
    if (items[index].product.units > 0) {
      items[index].product.units = items[index].product.units - 1;
      calculateTotals(true);
      emit(ItemQuantityUpdatedCartState());
    }
  }

  void addQuantityItemCart(int index) {
    if (items[index].product.units < items[index].quantityLimit) {
      items[index].product.units = items[index].product.units + 1;
      emit(ItemQuantityUpdatedCartState());
    }
  }

  void removeItemFromCart(int index) {
    items.removeAt(index);
    calculateTotals(true);
    emit(ItemQuantityUpdatedCartState());
  }

  void resetCart() {
    items.clear();
    emit(CartInitial([]));
  }

  void calculateTotals(bool substract) {
    if (items.isNotEmpty) {
      if (!substract) {
        //calaculate totals
        items.forEach((element) {
          total = total + element.product.salePrice;
          productsQty = productsQty + element.product.units;
        });
      } else {
        //calaculate totals
        items.forEach((element) {
          total = total - element.product.salePrice.round();
          productsQty = productsQty - element.product.units;
        });
      }
    } else {
      gain = 0;
      productsQty = 0;
      total = 0;
    }
  }
}
