import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vocabulary101_app/app/controllers/app_user_controller.dart';
import 'package:vocabulary101_app/app/core/services/translation_service.dart';
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
    await Hive.openBox('staticCardsCache');
    await Hive.openBox('learningSessions');
    await Hive.openBox('viewedSessionCards');
  } else {
    // Directory appDocDir = await getApplicationDocumentsDirectory();
    Directory appDocDir = await getApplicationSupportDirectory();
    String appDocPath = appDocDir.path;

    await Hive.openBox('users', path: appDocPath);
    await Hive.openBox('staticCardsCache', path: appDocPath);
    await Hive.openBox('learningSessions', path: appDocPath);
    await Hive.openBox('viewedSessionCards', path: appDocPath);
  }

  // await Firebase.initializeApp();

  // await Get.putAsync(
  //   () async => await AuthController().init(),
  //   tag: 'auth',
  //   permanent: true,
  // );
  await Get.putAsync(
    () async => await AppUserController().init(),
    tag: 'user',
    permanent: true,
  );

  // Init Google Analytics
  // FirebaseAnalytics analytics = FirebaseAnalytics();

  // runApp(App());
  runApp(
    GetMaterialApp.router(
      title: GetPlatform.isWeb
          ? 'English Vocabulary - Vocabulary 101'
          : 'Vocabulary 101',
      getPages: AppPages.routes,
      unknownRoute: AppPages.routes.firstWhere(
        (p) => p.name == Routes.NOT_FOUND,
      ),
      theme: LightTheme.data,
      // darkTheme: DarkTheme.data,
      color: Colors.black,
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),
      debugShowCheckedModeBanner: false,
      // navigatorObservers: [
      //   FirebaseAnalyticsObserver(analytics: analytics),
      // ],
    ),
  );
}
