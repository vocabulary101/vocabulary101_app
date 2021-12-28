import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:vocabulary101_app/app/controllers/auth_controller.dart';
import 'package:vocabulary101_app/app/core/utils/helpers/theme.dart';
import 'package:vocabulary101_app/app/data/models/app_user.dart';
import 'package:vocabulary101_app/app/data/repositories/app_user_repository.dart';

class AppUserController extends GetxService {
  static AppUserController get to => Get.find(tag: 'user');

  // Repository that connects AppUser to the db (local or remote)
  final _appUserRepository = AppUserRepository();

  // For listen to changes of AppUser on the db (remote), apply
  // corresponding changes, and update [appUser] value.
  StreamSubscription? _appUserSubscription;

  // Flag to stop loading the app until after
  // the first _handleAppUserChanges with data from Firestore.
  // bool isFirstAppUserChangesRunned = false;

  // Reactive AppUser instance
  Rxn<AppUser> appUser = Rxn<AppUser>();

  Future<AppUserController> init() async {
    // First of all, after an auth state change, close all subscriptions
    await _appUserSubscription?.cancel();

    // Init local (hive) or remote (Firestore) user provider
    await _appUserRepository.initProviders(isLocal: true);

    // Listen from the new subscription for AppUser
    _appUserSubscription =
        _appUserRepository.watchById('local').listen(_handleAppUserChanges);

    return this;
  }

  // @override
  // void onInit() async {
  //   super.onInit();
  // }

  // @override
  // void onReady() async {
  //   super.onReady();
  // }

  @override
  void onClose() async {
    await _appUserSubscription?.cancel();
    super.onClose();
  }

  void _handleAppUserChanges(AppUser? _appUser) async {
    // Create app user if not exists
    if (_appUser == null) {
      // Note: This runs locally the first time the user enters the app

      // Create the app user object
      AppUser _newUser = AppUser.minimum(id: 'local');

      // Create the app user in the db (local or remote)
      await _appUserRepository.add(_newUser);

      // Set value to the above code
      _appUser = _newUser;
    }

    // If user change default language (including initial load)
    // Note: appUser.value == null on app init
    if (appUser.value == null || _appUser.lang != appUser.value!.lang) {
      // At app init, this need a bit time
      if (appUser.value == null) {
        await Future.delayed(const Duration(milliseconds: 200));
      }
      // If is not language from device preferences
      if (_appUser.lang == 'en' || _appUser.lang == 'es') {
        Get.updateLocale(Locale(_appUser.lang));
      } else {
        Get.updateLocale(Get.deviceLocale ?? const Locale('en'));
      }
    }

    // If user select Dark mode (including initial load)
    // Note: appUser.value == null on app init
    if (appUser.value == null || _appUser.theme != appUser.value!.theme) {
      if (_appUser.theme == 'sys') {
        Get.changeThemeMode(ThemeMode.system);
      } else if (_appUser.theme == 'dark') {
        Get.changeThemeMode(ThemeMode.dark);
      } else {
        Get.changeThemeMode(ThemeMode.light);
      }

      bool? isDarkMode;
      // Wait after theme change
      Future.delayed(const Duration(milliseconds: 1000)).then((value) {
        isDarkMode = Get.isDarkMode;
        // Specifies the style to use for the system overlays that are visible
        ThemeHelper.setSystemUIOverlayStyle(isDarkMode!);
      });

      // Wait after theme change
      // Repeat for slow devices
      Future.delayed(const Duration(seconds: 5)).then((value) {
        if (isDarkMode != Get.isDarkMode) {
          // Specifies the style to use for the system overlays that are visible
          ThemeHelper.setSystemUIOverlayStyle(Get.isDarkMode);
        }
      });
    }

    // Set new value and refresh view
    appUser.value = _appUser;
    appUser.refresh();

    // isFirstAppUserChangesRunned = true;
  }

  /// Toggle app theme between 'System', 'Light' and 'Dark'
  void toggleTheme() {
    late String newThemeName;

    if (appUser.value!.theme == 'sys') {
      newThemeName = 'light';
    } else if (appUser.value!.theme == 'light') {
      newThemeName = 'dark';
    } else if (appUser.value!.theme == 'dark') {
      newThemeName = 'sys';
    }

    _appUserRepository.update(
      appUser.value!.copyWith(
        theme: newThemeName,
      ),
    );
  }

  /// Change app language
  void changeLanguage(String key) {
    _appUserRepository.update(
      appUser.value!.copyWith(
        lang: key,
      ),
    );
  }

  /// Update AppUser in the db (local or remote)
  Future<void> updateAppUser(AppUser appUser) async {
    await _appUserRepository.update(appUser);
  }
}
