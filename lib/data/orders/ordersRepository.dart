import 'package:fruty_chamoy_flutter/models/orderModel.dart';

abstract class OrdersRepository {
  Future<OrderModel> addProduct(OrderModel model);
}
