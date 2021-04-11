import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruty_chamoy_flutter/ui/cart/cartCubit.dart';
import 'package:fruty_chamoy_flutter/ui/home/homeScreen.dart';
import 'package:fruty_chamoy_flutter/ui/products/productsCubit.dart';
import 'package:fruty_chamoy_flutter/ui/products/productsScreen.dart';
import 'package:fruty_chamoy_flutter/utils/navigator.dart';
import 'package:fruty_chamoy_flutter/utils/utils.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _cartCubit = context.read<CartCubit>();
    final _productsCubit = context.read<ProductsCubit>();
    const _style = TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.backspace_outlined),
            onPressed: () {
              _productsCubit.getProducts(1);
              Navigator.pop(context);
            },
          ),
          title: Text('Orden'),
        ),
        body: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state is OrderFailureCartState) {
              final _snackBar = snackBarMessage(
                  'Ha ocurrido un error al procesar la orden',
                  Colors.red,
                  Colors.white);
              ScaffoldMessenger.of(context).showSnackBar(_snackBar);
              _cartCubit.resetCart();
              pushAndReplaceToPage(context, ProductsScreen());
            } else if (state is OrderSucceededCartState) {
              pushAndReplaceToPage(context, HomeScreen());
            }
          },
          builder: (context, state) {
            if (state is ItemsUpdatedCartState) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: _cartCubit.items.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = state.itemsCart[index];
                        return Card(
                          elevation: 3,
                          margin: EdgeInsets.all(7),
                          child: ListTile(
                            title: Text(
                              item.product.name.toUpperCase(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              children: [
                                Row(
                                  children: [
                                    Text('Precio:'),
                                    Text(
                                      ' ${item.product.salePrice}',
                                      style: _style,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Cantidad disponible:'),
                                    Text(
                                      ' ${item.quantityLimit}',
                                      style: _style,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: Container(
                              width: 180,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    radius: 20,
                                    child: IconButton(
                                      splashRadius: 30,
                                      color: Colors.white,
                                      icon: Icon(Icons.remove),
                                      onPressed: () => _cartCubit
                                          .removeQuantityItemCart(index),
                                    ),
                                  ),
                                  Text(
                                    item.product.units.toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    radius: 20,
                                    child: IconButton(
                                      splashRadius: 30,
                                      color: Colors.white,
                                      icon: Icon(Icons.add),
                                      onPressed: () =>
                                          _cartCubit.addQuantityItemCart(index),
                                    ),
                                  ),
                                  IconButton(
                                      splashRadius: 25,
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () =>
                                          _cartCubit.removeItemFromCart(index))
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    height: 250,
                    child: Column(
                      children: [
                        _SummaryText(
                          title: 'Cantidad de Productos',
                          amount: '${state.qtyProducts}',
                        ),
                        _SummaryText(
                          title: 'Ganancia',
                          amount: '${state.gain}',
                        ),
                        _SummaryText(
                          title: 'TOTAL',
                          amount: '${state.total}',
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            width: 200,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Theme.of(context).primaryColor),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(20),
                                ),
                              ),
                              onPressed: state.itemsCart.isEmpty
                                  ? null
                                  : () => _cartCubit.processOrder(),
                              child: Text(
                                'Guardar',
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else if (state is LoadingCartState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class _SummaryText extends StatelessWidget {
  final String title;
  final String amount;
  const _SummaryText({
    Key key,
    @required this.title,
    @required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              amount,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
