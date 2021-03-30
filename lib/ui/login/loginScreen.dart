import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruty_chamoy_flutter/models/loginModel.dart';
import 'package:fruty_chamoy_flutter/ui/home/homeScreen.dart';
import 'package:fruty_chamoy_flutter/ui/login/loginCubit.dart';
import 'package:fruty_chamoy_flutter/utils/utils.dart';
import 'package:fruty_chamoy_flutter/widgets/customTextField.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _loginCubit = context.read<LoginCubit>();
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is FailureState) {
          final snackBar = snackBarMessage(
              'Ha ocurrido un error Ó sus credenciales son incorrectas..',
              Colors.red,
              Colors.white);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          _loginCubit.emailController.text = '';
          _loginCubit.passwordController.text = '';
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case LoadingState:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
            break;
          case SuccessState:
            return HomeScreen();
          default:
            return Scaffold(
                body: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                const SizedBox(
                  height: 45,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'FRUTY CHAMOY APP',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                CustomTextField(
                  hintText: 'email@example.com',
                  icon: Icons.mail,
                  labelText: 'Email',
                  controller: _loginCubit.emailController,
                ),
                CustomTextField(
                  icon: Icons.lock_outline,
                  hintText: 'Password',
                  labelText: 'Password',
                  controller: _loginCubit.passwordController,
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red[800],
                        padding: const EdgeInsets.all(25),
                        textStyle: TextStyle(
                          fontSize: 16,
                        )),
                    onPressed: () {
                      if (_loginCubit.emailController.text.isEmpty ||
                          _loginCubit.passwordController.text.isEmpty) {
                        final snackBar = snackBarMessage(
                            'Ingrese toda la información',
                            Color.fromRGBO(255, 245, 200, 1),
                            Color.fromRGBO(114, 84, 0, 1));

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        _loginCubit.login(LoginModel(
                            email: _loginCubit.emailController.text,
                            password: _loginCubit.passwordController.text));
                      }
                    },
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ));
        }
      },
    );
  }
}
