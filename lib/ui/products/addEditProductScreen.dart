import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruty_chamoy_flutter/models/productModel.dart';

import 'package:fruty_chamoy_flutter/ui/products/productsCubit.dart';

import 'package:fruty_chamoy_flutter/utils/utils.dart';
import 'package:fruty_chamoy_flutter/widgets/customTextField.dart';

class AddEditProductScreen extends StatelessWidget {
  final bool isAdding;
  final ProductModel product;

  const AddEditProductScreen(
      {Key key, @required this.isAdding, @required this.product})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _textStyle = TextStyle(fontSize: 22);
    final _productsCubit = context.read<ProductsCubit>();
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case FailureProductsState:
            final _snackBar = snackBarMessage(
                (state as FailureProductsState).errorMessage,
                Colors.red,
                Colors.white);
            ScaffoldMessenger.of(context).showSnackBar(_snackBar);
            _productsCubit.cleanForm();
            break;
          case ValidateFormProductsState:
            final _snackBar = snackBarMessage(
                (state as ValidateFormProductsState).message,
                Colors.red,
                Colors.white);
            ScaffoldMessenger.of(context).showSnackBar(_snackBar);

            break;
          case SuccessProductsState:
            final msg = (state as SuccessProductsState);
            final snackBar = snackBarMessage(
                '${msg.successMessage}', Colors.green, Colors.white);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            _productsCubit.cleanForm();
            _productsCubit.getProducts(1);
            Navigator.pop(context);

            break;
        }
      },
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: isAdding ? Text('Agregar') : Text('Editar'),
          ),
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              CustomTextField(
                icon: Icons.file_download_done,
                hintText: 'Nombre',
                labelText: 'Nombre',
                controller: _productsCubit.nameController,
              ),
              CustomTextField(
                maxLines: 2,
                icon: Icons.file_download_done,
                hintText: 'Descripción',
                labelText: 'Descripción',
                controller: _productsCubit.descriptionController,
              ),
              CustomTextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                icon: Icons.file_download_done,
                hintText: '0.0',
                labelText: 'Precio de Compra',
                controller: _productsCubit.purchasePriceController,
              ),
              CustomTextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                icon: Icons.file_download_done,
                hintText: '0.0',
                labelText: 'Precio de Venta',
                controller: _productsCubit.salePriceController,
              ),
              CustomTextField(
                icon: Icons.file_download_done,
                hintText: '0',
                labelText: 'Cantidad',
                controller: _productsCubit.quantityController,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).primaryColor),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.all(20),
                    ),
                  ),
                  onPressed: () =>
                      _productsCubit.addEditProduct(product, isAdding),
                  child: isAdding
                      ? Text(
                          'Guardar',
                          style: _textStyle,
                        )
                      : Text(
                          'Editar',
                          style: _textStyle,
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
