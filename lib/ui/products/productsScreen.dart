import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruty_chamoy_flutter/models/cartModel.dart';
import 'package:fruty_chamoy_flutter/models/productModel.dart';
import 'package:fruty_chamoy_flutter/ui/cart/cartCubit.dart';
import 'package:fruty_chamoy_flutter/ui/cart/cartScreen.dart';

import 'package:fruty_chamoy_flutter/ui/products/addEditProductScreen.dart';
import 'package:fruty_chamoy_flutter/ui/products/productsCubit.dart';
import 'package:fruty_chamoy_flutter/utils/navigator.dart';
import 'package:fruty_chamoy_flutter/utils/utils.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _productsCubit = context.read<ProductsCubit>()..getProducts(1);
    final _cartCubit = context.read<CartCubit>();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.backspace_outlined),
            onPressed: () {
              _cartCubit.resetCart();
              Navigator.pop(context);
            },
          ),
          title: Text('Productos'),
          actions: [
            BlocConsumer<CartCubit, CartState>(
              listener: (context, state) {
                switch (state.runtimeType) {
                  case ProductExistCartState:
                    final _snackBar = snackBarMessage(
                        (state as ProductExistCartState).message,
                        Colors.red,
                        Colors.white);
                    ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                    break;
                }
              },
              builder: (context, state) {
                switch (state.runtimeType) {
                  case ItemsUpdatedCartState:
                    return _CartQuantityAppBar(
                      itemsCart:
                          (state as ItemsUpdatedCartState).itemsCart.length,
                    );
                    break;
                  default:
                    return _CartQuantityAppBar(
                      itemsCart: _cartCubit.items.length,
                    );
                }
              },
            )
          ],
        ),
        body: BlocConsumer<ProductsCubit, ProductsState>(
          listener: (context, state) {
            if (state is ValidateFormProductsState) {
              _productsCubit.getProducts(1);
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case ProductsInitial:
                return ListView(
                  physics: BouncingScrollPhysics(),
                  children: (state as ProductsInitial)
                      .productsList
                      .map(
                        (product) => Card(
                          elevation: 4,
                          child: ListTile(
                              leading: IconButton(
                                icon: Icon(
                                  Icons.delete_forever_outlined,
                                  color: Colors.red,
                                ),
                                onPressed: () {},
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.edit_outlined,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      _productsCubit.nameController.text =
                                          product.name;
                                      _productsCubit.descriptionController
                                          .text = product.description;
                                      _productsCubit.salePriceController.text =
                                          product.salePrice.toString();
                                      _productsCubit
                                              .purchasePriceController.text =
                                          product.purchasePrice.toString();
                                      _productsCubit.quantityController.text =
                                          product.units.toString();
                                      pushToPage(
                                        context,
                                        AddEditProductScreen(
                                          isAdding: false,
                                          product: product,
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.add_shopping_cart,
                                      color: Colors.deepPurple[700],
                                    ),
                                    onPressed: () {
                                      _cartCubit.addProductToCart(
                                          CartModel(product, product.units));
                                    },
                                  ),
                                ],
                              ),
                              title: Text(
                                '${product.name}',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Descripcion: ${product.description}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    'Precio de Compra: ${product.purchasePrice}',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    'Precio de Venta: ${product.salePrice}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    'Cantidad Disponible: ${product.units}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      )
                      .toList(),
                );
              case LoadingProductsState:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;

              default:
                return Center(
                  child: Text('No hay registros'),
                );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _productsCubit.cleanForm();
            pushToPage(
              context,
              AddEditProductScreen(
                isAdding: true,
                product: ProductModel(),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class _CartQuantityAppBar extends StatelessWidget {
  final int itemsCart;

  const _CartQuantityAppBar({
    Key key,
    @required this.itemsCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Badge(
      position: BadgePosition.topStart(start: 0, top: -3),
      animationDuration: const Duration(milliseconds: 300),
      animationType: BadgeAnimationType.slide,
      badgeContent: Text(
        '$itemsCart',
        style: TextStyle(color: Colors.white),
      ),
      child: IconButton(
        icon: Icon(Icons.shopping_cart),
        onPressed: () => pushToPage(context, CartScreen()),
      ),
    );
  }
}
