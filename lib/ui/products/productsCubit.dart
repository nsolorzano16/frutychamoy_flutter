import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fruty_chamoy_flutter/data/productsApi/productsRepository.dart';
import 'package:fruty_chamoy_flutter/models/productModel.dart';
import 'package:meta/meta.dart';

part 'productsState.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._productsRepository) : super(ProductsInitial());

  final ProductsRepository _productsRepository;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController salePriceController = TextEditingController();
  final TextEditingController purchasePriceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  void addProduct(ProductModel product) async {
    //validate fields
    if (nameController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        salePriceController.text.isEmpty ||
        purchasePriceController.text.isEmpty ||
        quantityController.text.isEmpty) {
      emit(FailureProductsState('Rellene todos los campos'));
    } else {
      emit(LoadingProductsState());
      product.name = nameController.text;
      product.description = descriptionController.text;
      product.salePrice = double.parse(salePriceController.text);
      product.purchasePrice = double.parse(purchasePriceController.text);
      product.units = int.parse(quantityController.text);
      product.createdAt = DateTime.now();
      product.updatedAt = DateTime.now();
      product.id = 'as400';
      product.user = 'sa';
      final resp = await _productsRepository.addProduct(product);

      if (resp != null) {
        print('entro as succes');
        emit(SuccessProductsState());
      } else {
        emit(FailureProductsState('Ha ocurrido un error intente mas tarde'));
      }
    }
  }

  void cleanForm() {
    nameController.text = '';
    descriptionController.text = '';
    salePriceController.text = '';
    purchasePriceController.text = '';
    quantityController.text = '';
  }
}
