part of 'cartCubit.dart';

@immutable
abstract class CartState {}

class ItemsUpdatedCartState extends CartState {
  final List<CartModel> itemsCart;
  final int qtyProducts;
  final double total;
  final double gain;
  final String message;

  ItemsUpdatedCartState(
      {@required this.message,
      @required this.itemsCart,
      @required this.qtyProducts,
      @required this.total,
      @required this.gain});
}
