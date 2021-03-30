part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class LogoutState extends HomeState {}

class RenewTokenState extends HomeState {}
