import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fruty_chamoy_flutter/ui/home/home_cubit.dart';
import 'package:fruty_chamoy_flutter/ui/login/loginScreen.dart';
import 'package:fruty_chamoy_flutter/ui/products/productsScreen.dart';
import 'package:fruty_chamoy_flutter/utils/navigator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _homeCubit = context.read<HomeCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text('FRUTY CHAMOY'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _homeCubit.logout,
          ),
        ],
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is LogoutState) {
            popAllAndPush(context, LoginScreen());
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case RenewTokenState:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            default:
              return Column(
                children: [
                  _MenuItem(
                    leadingIcon: Icons.shopping_bag,
                    onTap: () => pushToPage(
                      context,
                      ProductsScreen(),
                    ),
                    text: 'Productos',
                  ),
                  _MenuItem(
                      text: 'Nueva Venta',
                      leadingIcon: Icons.shopping_cart,
                      onTap: () {}),
                  Expanded(
                    child: ListView(children: [
                      Container(
                        height: 100,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 100,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 100,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 100,
                        color: Colors.blue,
                      ),
                    ]),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String text;

  final IconData leadingIcon;
  final VoidCallback onTap;

  const _MenuItem({
    Key key,
    @required this.text,
    @required this.leadingIcon,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(15),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).primaryColor,
          ),
          leading: Icon(
            leadingIcon,
            size: 24,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(
            text,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
