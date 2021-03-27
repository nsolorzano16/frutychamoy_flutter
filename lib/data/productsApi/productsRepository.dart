import 'package:fruty_chamoy_flutter/models/productModel.dart';

abstract class ProductsRepository {
  Future<ProductModel> addProduct(ProductModel product);
  Future<ProductModel> editProduct(ProductModel product);
  Future<List<ProductModel>> getProducts(int page);
}
