import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocabulary101_app/app/modules/home/controllers/home_controller.dart';

class NoLearningSessionMsg extends StatelessWidget {
  const NoLearningSessionMsg({
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
              'No Learning Session',
              style: Get.textTheme.headline5,
            ),
            const SizedBox(height: 25),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Text(
                'That is, a set of 10 new word cards with their meanings and examples.',
                style: Get.textTheme.subtitle2,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            OutlinedButton(
              child: const Text('Start Learning Session'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 22,
                  horizontal: 25,
                ),
              ),
              onPressed: () async {
                await HomeController.to.startLearningSession();
              },
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}