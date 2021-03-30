import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruty_chamoy_flutter/ui/home/homeScreen.dart';
import 'package:fruty_chamoy_flutter/ui/login/loginScreen.dart';
import 'package:fruty_chamoy_flutter/ui/splash/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<SplashCubit, SplashState>(
      builder: (context, state) {
        if (state is SplashInitialState) {
          return LoginScreen();
        } else if (state is LoggedState) {
          return HomeScreen();
        }
        return LoginScreen();
      },
    ));
  }
}
