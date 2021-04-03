part of 'cartCubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {
  final List<CartModel> itemsCart;

  CartInitial(this.itemsCart);
}

class ItemsUpdatedCartState extends CartState {
  final List<CartModel> itemsCart;
  final int qtyProducts;
  final double total;
  final double gain;

  ItemsUpdatedCartState(
      {@required this.itemsCart,
      @required this.qtyProducts,
      @required this.total,
      @required this.gain});
}

class ProductExistCartState extends CartState {
  final String message;

  ProductExistCartState(this.message);
}
