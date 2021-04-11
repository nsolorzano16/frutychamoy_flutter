import 'package:http/http.dart' as http;
import 'package:fruty_chamoy_flutter/data/orders/ordersRepository.dart';
import 'package:fruty_chamoy_flutter/env/enviroment.dart';
import 'package:fruty_chamoy_flutter/models/orderModel.dart';
import 'package:fruty_chamoy_flutter/utils/storageUtil.dart';

class OrdersRepositoryImpl extends OrdersRepository {
  @override
  Future<OrderModel> addProduct(OrderModel model) async {
    try {
      final apiUrl = Uri.https(apiURL, '/api/orders/new');
      final token = StorageUtil.getString('token');
      final resp = await http.post(
        apiUrl,
        body: orderModelToJson(model),
        headers: {
          'Content-Type': 'application/json',
          'x-token': '$token',
        },
      );

      if (resp.statusCode == 200) {
        return orderModelFromJson(resp.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
