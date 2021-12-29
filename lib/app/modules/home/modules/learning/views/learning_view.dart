import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vocabulary101_app/app/modules/home/controllers/home_controller.dart';
import 'package:vocabulary101_app/app/modules/home/modules/learning/controllers/learning_controller.dart';
import 'package:vocabulary101_app/app/modules/home/modules/learning/widgets/no_learning_session_msg.dart';
import 'package:vocabulary101_app/app/modules/home/modules/learning/widgets/session_card_view.dart';

class LearningView extends GetView<LearningController> {
  const LearningView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => HomeController.to.currentLearningSession.value == null
          ? const NoLearningSessionMsg()
          : const SessionCardView(),
    );
  }
}
