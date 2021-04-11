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
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  double gain;
  double realTotal;
  int quantityProducts;
  List<ProductModel> products;
  DateTime createdAt;
  DateTime updatedAt;
  String id;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        gain: json["gain"].toDouble(),
        realTotal: json["realTotal"].toDouble(),
        quantityProducts: json["quantityProducts"],
        products: List<ProductModel>.from(
            json["products"].map((x) => ProductModel.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "gain": gain,
        "realTotal": realTotal,
        "quantityProducts": quantityProducts,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
      };
}
