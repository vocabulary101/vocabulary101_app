import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/modules/learning/bindings/learning_binding.dart';
import '../modules/home/modules/learning/views/learning_view.dart';
import '../modules/not_found/bindings/not_found_binding.dart';
import '../modules/not_found/views/not_found_view.dart';
import '../modules/home/modules/profile/bindings/profile_binding.dart';
import '../modules/home/modules/profile/views/profile_view.dart';
import '../modules/home/modules/progress/bindings/progress_binding.dart';
import '../modules/home/modules/progress/views/progress_view.dart';
import '../modules/root/bindings/root_binding.dart';
import '../modules/root/views/root_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/stats/bindings/stats_binding.dart';
import '../modules/stats/views/stats_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.ROOT,
      page: () => const RootView(),
      binding: RootBinding(),
      participatesInRootNavigator: true,
      preventDuplicates: true,
      children: [
        GetPage(
          name: _Paths.HOME,
          page: () => const HomeView(),
          binding: HomeBinding(),
          preventDuplicates: true,
          children: [
            GetPage(
              name: _Paths.PROGRESS,
              page: () => const ProgressView(),
              binding: ProgressBinding(),
              preventDuplicates: true,
            ),
            GetPage(
              name: _Paths.LEARNING,
              page: () => const LearningView(),
              binding: LearningBinding(),
              preventDuplicates: true,
            ),
            GetPage(
              name: _Paths.PROFILE,
              page: () => const ProfileView(),
              binding: ProfileBinding(),
              preventDuplicates: true,
            ),
          ],
        ),
        GetPage(
          name: _Paths.SETTINGS,
          page: () => const SettingsView(),
          binding: SettingsBinding(),
          preventDuplicates: true,
        ),
        GetPage(
          name: _Paths.STATS,
          page: () => const StatsView(),
          binding: StatsBinding(),
          preventDuplicates: true,
        ),
      ],
    ),
    GetPage(
      name: _Paths.NOT_FOUND,
      page: () => const NotFoundView(),
      binding: NotFoundBinding(),
    ),
  ];
}
