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
    this.user,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  String name;
  String description;
  double salePrice;
  double purchasePrice;
  int units;
  String user;
  DateTime createdAt;
  DateTime updatedAt;
  String id;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        name: json["name"],
        description: json["description"],
        salePrice: json["salePrice"].toDouble(),
        purchasePrice: json["purchasePrice"].toDouble(),
        units: json["units"],
        user: json["user"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "salePrice": salePrice,
        "purchasePrice": purchasePrice,
        "units": units,
        "user": user,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
      };
}
