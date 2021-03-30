import 'package:fruty_chamoy_flutter/utils/storageUtil.dart';
import 'package:http/http.dart' as http;
import 'package:fruty_chamoy_flutter/data/productsApi/productsRepository.dart';
import 'package:fruty_chamoy_flutter/env/enviroment.dart';
import 'package:fruty_chamoy_flutter/models/productModel.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  @override
  Future<ProductModel> addProduct(ProductModel product) async {
    try {
      final apiUrl = Uri.https(apiURL, '/api/products/new');
      final token = StorageUtil.getString('token');
      final resp = await http.post(
        apiUrl,
        body: productModelToJson(product),
        headers: {
          'Content-Type': 'application/json',
          'x-token': '$token',
        },
      );

      if (resp.statusCode == 200) {
        return productModelFromJson(resp.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<ProductModel> editProduct(ProductModel product) async {
    try {
      final apiUrl = Uri.https(apiURL, '/api/products/edit/id/${product.id}');
      final token = StorageUtil.getString('token');
      final resp = await http.put(
        apiUrl,
        body: productModelToJson(product),
        headers: {
          'Content-Type': 'application/json',
          'x-token': '$token',
        },
      );

      if (resp.statusCode == 200) {
        return productModelFromJson(resp.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<ProductModel>> getProducts(int page) async {
    try {
      final apiUrl = Uri.https(apiURL, '/api/products/limit/200/page/$page');
      final token = StorageUtil.getString('token');
      final resp = await http.get(
        apiUrl,
        headers: {
          'Content-Type': 'application/json',
          'x-token': token,
        },
      );
      if (resp.statusCode == 200) {
        return productModelListFromJson(resp.body);
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
