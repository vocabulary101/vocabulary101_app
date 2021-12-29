import 'package:vocabulary101_app/app/core/icons/v101_icons.dart';
import 'package:vocabulary101_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  final int index;

  const HomeBottomNavigationBar({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 47,
      decoration: BoxDecoration(
        color: Get.theme.bottomNavigationBarTheme.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 2,
            offset: const Offset(0, -1),
          )
        ],
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: CustomBottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const Icon(V101Icons.card_list),
                label: 'Vocabulary'.tr, //'home.progress'.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(V101Icons.cards),
                label: 'Learning'.tr, //'home.learning'.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(V101Icons.profile),
                label: 'Profile'.tr, //'home.profile'.tr,
              ),
            ],
            currentIndex: index,
            onTap: (index) {
              switch (index) {
                case 0:
                  Get.rootDelegate.toNamed(Routes.PROGRESS);
                  break;
                case 1:
                  Get.rootDelegate.toNamed(Routes.LEARNING);
                  break;
                case 2:
                  Get.rootDelegate.toNamed(Routes.PROFILE);
                  break;
                default:
              }
            },
          ),
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (constraints.maxWidth <= 750)
            for (final item in items)
              Tooltip(
                message: item.label ?? '',
                child: IconButton(
                  icon: IconTheme(
                    data: IconThemeData(
                      color: currentIndex == items.indexOf(item)
                          ? Get.theme.bottomNavigationBarTheme.selectedItemColor
                          : Get.theme.bottomNavigationBarTheme
                              .unselectedItemColor,
                    ),
                    child: item.icon,
                  ),
                  onPressed: () {
                    onTap(items.indexOf(item));
                  },
                ),
              ),
          if (constraints.maxWidth > 750)
            for (final item in items)
              OutlinedButton.icon(
                icon: IconTheme(
                  data: IconThemeData(
                    color: currentIndex == items.indexOf(item)
                        ? Get.theme.bottomNavigationBarTheme.selectedItemColor
                        : Get
                            .theme.bottomNavigationBarTheme.unselectedItemColor,
                  ),
                  child: item.icon,
                ),
                label: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(item.label ?? ''),
                ),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(160, 41),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  primary: currentIndex == items.indexOf(item)
                      ? Get.theme.bottomNavigationBarTheme.selectedItemColor
                      : Get.theme.bottomNavigationBarTheme.unselectedItemColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  onTap(items.indexOf(item));
                },
              ),
        ],
      );
    });
  }
}
