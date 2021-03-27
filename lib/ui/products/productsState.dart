part of 'productsCubit.dart';

@immutable
abstract class ProductsState {}

class ProductsInitial extends ProductsState {
  final List<ProductModel> productsList;

  ProductsInitial(this.productsList);
}

class LoadingProductsState extends ProductsState {}

class SuccessProductsState extends ProductsState {
  final String successMessage;

  SuccessProductsState(this.successMessage);
}

class FailureProductsState extends ProductsState {
  final String errorMessage;

  FailureProductsState(this.errorMessage);
}
