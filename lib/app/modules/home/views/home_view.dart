import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vocabulary101_app/app/modules/home/widgets/app_bar.dart';
import 'package:vocabulary101_app/app/modules/home/widgets/bottom_navigation_bar.dart';
import 'package:vocabulary101_app/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(builder: (context, delegate, currentRoute) {
      // This router outlet handles the appbar and the bottom navigation bar
      final currentLocation = currentRoute?.location;

      // Default view
      var currentIndex = 1;
      if (currentLocation?.startsWith(Routes.PROGRESS) == true) {
        currentIndex = 0;
      } else if (currentLocation?.startsWith(Routes.PROFILE) == true) {
        currentIndex = 2;
      }

      return Scaffold(
        appBar: HomeAppBar(index: currentIndex),
        body: GetRouterOutlet(
          initialRoute: Routes.LEARNING,
          key: Get.nestedKey(Routes.HOME),
        ),
        bottomNavigationBar: HomeBottomNavigationBar(
          index: currentIndex,
        ),
      );
    });
  }
}
