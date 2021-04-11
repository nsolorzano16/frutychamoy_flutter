import 'package:bloc/bloc.dart';
import 'package:fruty_chamoy_flutter/data/orders/ordersRepository.dart';
import 'package:fruty_chamoy_flutter/models/cartModel.dart';
import 'package:fruty_chamoy_flutter/models/orderModel.dart';

import 'package:meta/meta.dart';

part 'cartState.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this._ordersRepository)
      : super(ItemsUpdatedCartState(
            message: '', itemsCart: [], qtyProducts: 0, total: 0, gain: 0));

  final OrdersRepository _ordersRepository;
  final List<CartModel> items = [];

  double gain = 0;
  int productsQty = 0;
  double total = 0;

  void addProductToCart(CartModel item) {
    if (item.product.units > 0) {
      bool itemExist =
          items.any((element) => item.product.id == element.product.id);

      if (itemExist) {
        emit(ItemsUpdatedCartState(
            message: 'Producto ya ha sido agregado',
            gain: gain,
            itemsCart: items,
            qtyProducts: productsQty,
            total: total));
      } else {
        items.add(item);
        calculateTotals();
        emit(ItemsUpdatedCartState(
            message: '',
            gain: gain,
            itemsCart: items,
            qtyProducts: productsQty,
            total: total));
      }
    } else {
      emit(ItemsUpdatedCartState(
          message: 'Producto no disponible',
          gain: gain,
          itemsCart: items,
          qtyProducts: productsQty,
          total: total));
    }
  }

  void removeQuantityItemCart(int index) {
    if (items[index].product.units > 0) {
      items[index].product.units = items[index].product.units - 1;
      calculateTotals();
      emit(ItemsUpdatedCartState(
          message: '',
          gain: gain,
          itemsCart: items,
          qtyProducts: productsQty,
          total: total));
    }
  }

  void addQuantityItemCart(int index) {
    if (items[index].product.units < items[index].quantityLimit) {
      items[index].product.units = items[index].product.units + 1;
      calculateTotals();
      emit(ItemsUpdatedCartState(
          message: '',
          gain: gain,
          itemsCart: items,
          qtyProducts: productsQty,
          total: total));
    }
  }

  void removeItemFromCart(int index) {
    items.removeAt(index);
    calculateTotals();
    emit(ItemsUpdatedCartState(
        message: '',
        gain: gain,
        itemsCart: items,
        qtyProducts: productsQty,
        total: total));
  }

  void resetCart() {
    items.clear();
    gain = 0;
    productsQty = 0;
    total = 0;
    emit(ItemsUpdatedCartState(
        message: '', gain: 0, itemsCart: [], qtyProducts: 0, total: 0));
  }

  void calculateTotals() {
    total = 0;
    gain = 0;
    productsQty = 0;
    double totalPurchasePrice = 0;
    if (items.isNotEmpty) {
      items.forEach((element) {
        total = total + (element.product.salePrice * element.product.units);
        totalPurchasePrice = totalPurchasePrice +
            (element.product.purchasePrice * element.product.units);
        productsQty = productsQty + element.product.units;
        gain = total - totalPurchasePrice;
      });
    } else {
      gain = 0;
      productsQty = 0;
      total = 0;
    }
  }

  void processOrder() async {
    final order = new OrderModel();
    order.gain = gain;
    order.quantityProducts = productsQty;
    order.realTotal = total;
    order.products = [];
    order.createdAt = DateTime.now();
    order.updatedAt = DateTime.now();
    emit(LoadingCartState());
    items.forEach((element) {
      order.products.add(element.product);
    });
    print(orderModelToJson(order));

    final resp = await _ordersRepository.addProduct(order);

    if (resp != null) {
      resetCart();
      emit(OrderSucceededCartState());
    } else {
      emit(OrderFailureCartState());
    }
  }
}
