import 'dart:convert';

import 'package:fruty_chamoy_flutter/models/productModel.dart';

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  final ProductModel product;
  final int quantityLimit;

  CartModel(this.product, this.quantityLimit);

  Map<String, dynamic> toJson() => {
        "name": product.name,
        "description": product.description,
        "salePrice": product.salePrice,
        "purchasePrice": product.purchasePrice,
        "units": product.units,
        "user": product.user,
        "createdAt": product.createdAt.toIso8601String(),
        "updatedAt": product.updatedAt.toIso8601String(),
        "id": product.id,
        "quantityLimit": quantityLimit
      };
}
