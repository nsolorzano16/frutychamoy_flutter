import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruty_chamoy_flutter/data/auth/auth_repository.dart';
import 'package:fruty_chamoy_flutter/data/auth/auth_local_impl.dart';
import 'package:fruty_chamoy_flutter/data/productsApi/productsRepoImpl.dart';
import 'package:fruty_chamoy_flutter/data/productsApi/productsRepository.dart';

List<RepositoryProvider> buildRepositories() => [
      RepositoryProvider<AuthRepository>(
        create: (_) => AuthLocalImpl(),
      ),
      RepositoryProvider<ProductsRepository>(
        create: (_) => ProductsRepositoryImpl(),
      ),
    ];
