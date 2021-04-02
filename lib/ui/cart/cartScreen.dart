import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruty_chamoy_flutter/ui/cart/cartCubit.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _cartCubit = context.read<CartCubit>();
    const _style = TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black);
    return Scaffold(
      appBar: AppBar(
        title: Text('Orden'),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: _cartCubit.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = _cartCubit.items[index];
                    return Card(
                      elevation: 3,
                      margin: EdgeInsets.all(7),
                      child: ListTile(
                        title: Text(
                          item.product.name.toUpperCase(),
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Table(
                          children: [
                            TableRow(
                              children: [
                                Text('Cantidad disponible:'),
                                Text(
                                  ' ${item.quantityLimit}',
                                  style: _style,
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Text('Precio:'),
                                Text(
                                  ' ${item.product.salePrice}',
                                  style: _style,
                                ),
                              ],
                            )
                          ],
                        ),
                        trailing: Container(
                          width: 180,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                radius: 20,
                                child: IconButton(
                                  splashRadius: 30,
                                  color: Colors.white,
                                  icon: Icon(Icons.remove),
                                  onPressed: () =>
                                      _cartCubit.removeQuantityItemCart(index),
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
                                backgroundColor: Theme.of(context).primaryColor,
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
                        amount: '${_cartCubit.productsQty}',
                      ),
                      _SummaryText(
                        title: 'Ganancia',
                        amount: '--',
                      ),
                      _SummaryText(
                        title: 'TOTAL',
                        amount: '${_cartCubit.total}',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          width: 200,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context).primaryColor),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(20),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              'Guardar',
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          );
        },
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
