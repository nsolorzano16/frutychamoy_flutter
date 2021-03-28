import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fruty_chamoy_flutter/data/productsApi/productsRepository.dart';
import 'package:fruty_chamoy_flutter/models/productModel.dart';
import 'package:meta/meta.dart';

part 'productsState.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._productsRepository) : super(ProductsInitial([]));

  final ProductsRepository _productsRepository;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController salePriceController = TextEditingController();
  final TextEditingController purchasePriceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  void addEditProduct(ProductModel product, bool isAdding) async {
    //validate fields
    if (nameController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        salePriceController.text.isEmpty ||
        purchasePriceController.text.isEmpty ||
        quantityController.text.isEmpty) {
      emit(ValidateFormProductsState('Rellene todos los campos'));
    } else {
      ProductModel resp;
      if (isAdding) {
        product.name = nameController.text;
        product.description = descriptionController.text;
        product.salePrice = double.parse(salePriceController.text);
        product.purchasePrice = double.parse(purchasePriceController.text);
        product.units = int.parse(quantityController.text);
        product.createdAt = DateTime.now();
        product.updatedAt = DateTime.now();
        resp = await _productsRepository.addProduct(product);
        if (resp != null) {
          emit(SuccessProductsState('Producto agregado'));
        } else {
          emit(FailureProductsState('Ha ocurrido un error intente mas tarde'));
        }
      } else {
        product.name = nameController.text;
        product.description = descriptionController.text;
        product.salePrice = double.parse(salePriceController.text);
        product.purchasePrice = double.parse(purchasePriceController.text);
        product.units = int.parse(quantityController.text);
        resp = await _productsRepository.editProduct(product);

        if (resp != null) {
          emit(SuccessProductsState('Producto editado'));
        } else {
          emit(FailureProductsState('Ha ocurrido un error intente mas tarde'));
        }
      }
    }
  }

  void getProducts(int page) async {
    print('method getproducts ');
    emit(LoadingProductsState());
    final resp = await _productsRepository.getProducts(page);
    emit(ProductsInitial(resp));
  }

  void cleanForm() {
    nameController.text = '';
    descriptionController.text = '';
    salePriceController.text = '';
    purchasePriceController.text = '';
    quantityController.text = '';
  }
}
