part of 'productsCubit.dart';

@immutable
abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class LoadingProductsState extends ProductsState {}

class SuccessProductsState extends ProductsState {}

class FailureProductsState extends ProductsState {
  final String errorMessage;

  FailureProductsState(this.errorMessage);
}
