import 'package:flutter/material.dart';
import 'package:fruty_chamoy_flutter/models/productModel.dart';
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
    return SafeArea(
      child: Scaffold(
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
              controller: TextEditingController(),
            ),
            CustomTextField(
              icon: Icons.file_download_done,
              hintText: 'Descripción',
              labelText: 'Descripción',
              controller: TextEditingController(),
            ),
            CustomTextField(
              icon: Icons.file_download_done,
              hintText: '0.0',
              labelText: 'Precio de Compra',
              controller: TextEditingController(),
            ),
            CustomTextField(
              icon: Icons.file_download_done,
              hintText: '0.0',
              labelText: 'Precio de Venta',
              controller: TextEditingController(),
            ),
            CustomTextField(
              icon: Icons.file_download_done,
              hintText: '0',
              labelText: 'Cantidad',
              controller: TextEditingController(),
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
                onPressed: () {},
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
      ),
    );
  }
}
