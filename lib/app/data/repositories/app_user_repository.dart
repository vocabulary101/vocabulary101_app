import 'package:vocabulary101_app/app/data/models/app_user.dart';
import 'package:vocabulary101_app/app/data/services/app_user_service.dart';
import 'package:vocabulary101_app/app/data/providers/app_user_hive_provider.dart';

class AppUserRepository {
  late AppUserService _appUserService;

  Future<void> initProviders({required bool isLocal}) async {
    _appUserService = AppUserHiveProvider();
    await _appUserService.initProvider();
  }

  Stream<AppUser?> watchById(String id) {
    return _appUserService.watchById(id);
  }

  Future<void> add(AppUser user) async {
    await _appUserService.add(user);
  }

  Future<void> update(AppUser user) async {
    await _appUserService.update(user);
  }
}
