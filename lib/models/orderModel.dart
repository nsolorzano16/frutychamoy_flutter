// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

import 'package:fruty_chamoy_flutter/models/productModel.dart';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  OrderModel({
    this.gain,
    this.realTotal,
    this.quantityProducts,
    this.products,
  });

  int gain;
  int realTotal;
  int quantityProducts;
  List<ProductModel> products;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        gain: json["gain"],
        realTotal: json["realTotal"],
        quantityProducts: json["quantityProducts"],
        products: List<ProductModel>.from(
            json["products"].map((x) => ProductModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "gain": gain,
        "realTotal": realTotal,
        "quantityProducts": quantityProducts,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}
