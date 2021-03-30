import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruty_chamoy_flutter/models/productModel.dart';

import 'package:fruty_chamoy_flutter/ui/products/addEditProductScreen.dart';
import 'package:fruty_chamoy_flutter/ui/products/productsCubit.dart';
import 'package:fruty_chamoy_flutter/utils/navigator.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _productsCubit = context.read<ProductsCubit>()..getProducts(1);
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        actions: [
          IconButton(icon: Icon(Icons.shopping_cart_outlined), onPressed: () {})
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
                                    _productsCubit.descriptionController.text =
                                        product.description;
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
                                    //TODO: add to cart
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
                                  style: TextStyle(fontSize: 16),
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
    );
  }
}
