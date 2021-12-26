import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vocabulary101_app/app/core/themes/light_theme.dart';
import 'package:vocabulary101_app/app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // AdMob
  // if (GetPlatform.isAndroid || GetPlatform.isIOS) {
  //   MobileAds.instance.initialize();
  // }

  if (kIsWeb) {
    await Hive.openBox('users');
    await Hive.openBox('libraries');
    await Hive.openBox('resources');
    // await Hive.openBox('userActivityLog');
  } else {
    // Directory appDocDir = await getApplicationDocumentsDirectory();
    Directory appDocDir = await getApplicationSupportDirectory();
    String appDocPath = appDocDir.path;

    await Hive.openBox('users', path: appDocPath);
    await Hive.openBox('libraries', path: appDocPath);
    await Hive.openBox('resources', path: appDocPath);
    // await Hive.openBox('userActivityLog', path: appDocPath);
  }

  // await Firebase.initializeApp();

  // await Get.putAsync(
  //   () async => await AuthController().init(),
  //   tag: 'auth',
  //   permanent: true,
  // );
  // await Get.putAsync(
  //   () async => await AppUserController().init(),
  //   tag: 'user',
  //   permanent: true,
  // );

  // Init Google Analytics
  // FirebaseAnalytics analytics = FirebaseAnalytics();

  // runApp(App());
  runApp(
    GetMaterialApp.router(
      title: GetPlatform.isWeb ? 'Video Notes and Bookmarks - Uolia' : 'Uolia',
      getPages: AppPages.routes,
      unknownRoute: AppPages.routes.firstWhere(
        (p) => p.name == Routes.NOT_FOUND,
      ),
      theme: LightTheme.data,
      // darkTheme: DarkTheme.data,
      color: Colors.black,
      // locale: TranslationService.locale,
      // fallbackLocale: TranslationService.fallbackLocale,
      // translations: TranslationService(),
      debugShowCheckedModeBanner: false,
      // navigatorObservers: [
      //   FirebaseAnalyticsObserver(analytics: analytics),
      // ],
    ),
  );
}
