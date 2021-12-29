import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocabulary101_app/app/modules/home/controllers/home_controller.dart';
import 'package:vocabulary101_app/app/routes/app_pages.dart';

class ProgressEmptyListMsg extends StatelessWidget {
  const ProgressEmptyListMsg({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your vocabulary is empty',
              style: Get.textTheme.headline5,
            ),
            const SizedBox(height: 25),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Text(
                'After each Learning Session, new words will be added right here',
                style: Get.textTheme.subtitle2,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            TextButton(
              child: const Text('Start Learning Session'),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 22,
                  horizontal: 25,
                ),
              ),
              onPressed: () async {
                await HomeController.to.startLearningSession();
                await Get.rootDelegate.toNamed(Routes.LEARNING);
              },
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
