import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruty_chamoy_flutter/data/auth/auth_repository.dart';
import 'package:fruty_chamoy_flutter/data/auth/auth_local_impl.dart';
import 'package:fruty_chamoy_flutter/data/storage/persistentStorageImpl.dart';
import 'package:fruty_chamoy_flutter/data/storage/persistent_storage_repository.dart';

List<RepositoryProvider> buildRepositories() => [
      RepositoryProvider<AuthRepository>(create: (_) => AuthLocalImpl()),
      RepositoryProvider<PersistentStorageRepository>(
          create: (_) => PersistentStorageImpl()),
    ];
