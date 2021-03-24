part of 'loginCubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoadingState extends LoginState {}

//login failure
class FailureState extends LoginState {}

// success login
class SuccessState extends LoginState {}
