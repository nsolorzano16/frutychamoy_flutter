import 'package:fruty_chamoy_flutter/data/storage/persistent_storage_repository.dart';
import 'package:fruty_chamoy_flutter/utils/storageUtil.dart';

class PersistentStorageImpl extends PersistentStorageRepository {
  @override
  String getToken() {
    return StorageUtil.getString('token');
  }

  @override
  Future setToken(String token) {
    return StorageUtil.putString('token', token);
  }
}
