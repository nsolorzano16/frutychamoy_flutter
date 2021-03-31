part of 'cartCubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {
  final List<ProductModel> itemsCart;

  CartInitial(this.itemsCart);
}

class ProductsAddedCartState extends CartState {
  final List<ProductModel> itemsCart;

  ProductsAddedCartState(this.itemsCart);
}

class ProductExistCartState extends CartState {
  final String message;

  ProductExistCartState(this.message);
}
