import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruty_chamoy_flutter/data/auth/auth_repository.dart';
import 'package:fruty_chamoy_flutter/data/orders/ordersRepository.dart';
import 'package:fruty_chamoy_flutter/data/products/productsRepository.dart';

import 'package:fruty_chamoy_flutter/dependencies.dart';
import 'package:fruty_chamoy_flutter/theme/appTheme.dart';
import 'package:fruty_chamoy_flutter/ui/cart/cartCubit.dart';
import 'package:fruty_chamoy_flutter/ui/home/home_cubit.dart';
import 'package:fruty_chamoy_flutter/ui/login/loginCubit.dart';
import 'package:fruty_chamoy_flutter/ui/products/productsCubit.dart';
import 'package:fruty_chamoy_flutter/ui/splash/splashScreen.dart';
import 'package:fruty_chamoy_flutter/ui/splash/splash_cubit.dart';
import 'package:fruty_chamoy_flutter/utils/storageUtil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageUtil.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: buildRepositories(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SplashCubit()..existToken(),
          ),
          BlocProvider(
            create: (context) => LoginCubit(
              context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => HomeCubit(
              context.read<AuthRepository>(),
            )..renewToken(),
          ),
          BlocProvider(
            create: (context) => ProductsCubit(
              context.read<ProductsRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => CartCubit(
              context.read<OrdersRepository>(),
            ),
          )
        ],
        child: MaterialApp(
          theme: appTheme(),
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          home: SplashScreen(),
        ),
      ),
    );
  }
}
