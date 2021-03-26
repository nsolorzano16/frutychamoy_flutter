import 'package:flutter/material.dart';
import 'package:fruty_chamoy_flutter/models/productModel.dart';
import 'package:fruty_chamoy_flutter/ui/products/addEditProductScreen.dart';
import 'package:fruty_chamoy_flutter/utils/navigator.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Productos'),
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ListTile(
              title: Text('fake data'),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => pushToPage(
                  context,
                  AddEditProductScreen(
                    isAdding: false,
                    product: ProductModel(),
                  ),
                ),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => pushToPage(
              context,
              AddEditProductScreen(
                isAdding: true,
                product: ProductModel(),
              )),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
