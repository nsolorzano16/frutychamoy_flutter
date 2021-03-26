// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.name,
    this.description,
    this.salePrice,
    this.purchasePrice,
    this.units,
  });

  String name;
  String description;
  double salePrice;
  int purchasePrice;
  int units;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        name: json["name"],
        description: json["description"],
        salePrice: json["salePrice"].toDouble(),
        purchasePrice: json["purchasePrice"],
        units: json["units"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "salePrice": salePrice,
        "purchasePrice": purchasePrice,
        "units": units,
      };
}
