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
        emit(ItemsUpdatedCartState(
            gain: gain,
            itemsCart: items,
            qtyProducts: productsQty,
            total: total));
      }
    } else {
      emit(ProductExistCartState('Producto no disponible'));
    }
  }

  void removeQuantityItemCart(int index) {
    if (items[index].product.units > 0) {
      items[index].product.units = items[index].product.units - 1;
      calculateTotals(true);
      emit(ItemsUpdatedCartState(
          gain: gain,
          itemsCart: items,
          qtyProducts: productsQty,
          total: total));
    }
  }

  void addQuantityItemCart(int index) {
    if (items[index].product.units < items[index].quantityLimit) {
      items[index].product.units = items[index].product.units + 1;
      calculateTotals(false);
      emit(ItemsUpdatedCartState(
          gain: gain,
          itemsCart: items,
          qtyProducts: productsQty,
          total: total));
    }
  }

  void removeItemFromCart(int index) {
    final pr = items[index].product;
    total = total - 1 * (pr.salePrice * pr.units);
    items.removeAt(index);
    emit(ItemsUpdatedCartState(
        gain: gain, itemsCart: items, qtyProducts: productsQty, total: total));
  }

  void resetCart() {
    items.clear();
    gain = 0;
    productsQty = 0;
    total = 0;
    emit(ItemsUpdatedCartState(
        gain: 0, itemsCart: [], qtyProducts: 0, total: 0));
  }

//TODO: no me convence
  void calculateTotals(bool substract) {
    total = 0;
    if (items.isNotEmpty) {
      items.forEach((element) {
        total = total + (element.product.salePrice * element.product.units);
      });
    } else {
      gain = 0;
      productsQty = 0;
      total = 0;
    }
  }
}
