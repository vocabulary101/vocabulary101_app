import 'dart:async';

import 'package:hive/hive.dart';
import 'package:vocabulary101_app/app/data/models/app_user.dart';
import 'package:vocabulary101_app/app/data/services/app_user_service.dart';

class AppUserHiveProvider extends AppUserService {
  // Hive box instance
  late Box _hiveBox;

  @override
  Future<void> initProvider() async {
    // Get Hive box instance
    _hiveBox = Hive.box('users');
  }

  ///
  @override
  Future<AppUser?> byId(String id) async {
    final boxValue = _hiveBox.get(id);
    return boxValue != null
        ? AppUser.fromJson(Map<String, dynamic>.from(boxValue))
        : null;
  }

  ///
  @override
  Stream<AppUser?> watchById(String id) async* {
    // Get value to the first yield from the storage
    var firstYieldValue = _hiveBox.get(id);
    // Send initial yield
    yield firstYieldValue != null
        ? AppUser.fromJson(
            Map<String, dynamic>.from(
              firstYieldValue,
            ),
          )
        : null;

    // Send yield for changes
    yield* _hiveBox.watch(key: id).map((event) {
      return event.value != null
          ? AppUser.fromJson(Map<String, dynamic>.from(event.value))
          : null;
    });
  }

  ///
  @override
  Future<void> add(AppUser user) async {
    await _hiveBox.put(user.id, user.toJson());
  }

  ///
  @override
  Future<void> update(AppUser user) async {
    await _hiveBox.put(user.id, user.toJson());
  }

  ///
  @override
  Future<void> removeById(String id) async {
    await _hiveBox.delete(id);
  }
}
