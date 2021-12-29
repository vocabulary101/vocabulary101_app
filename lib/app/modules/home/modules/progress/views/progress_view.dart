import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vocabulary101_app/app/modules/home/controllers/home_controller.dart';
import 'package:vocabulary101_app/app/modules/home/modules/progress/widgets/empty_list_msg.dart';
import 'package:vocabulary101_app/app/modules/home/modules/progress/widgets/term_list.dart';

import '../controllers/progress_controller.dart';

class ProgressView extends GetView<ProgressController> {
  const ProgressView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => HomeController.to.userSessionCards.isEmpty
          ? const ProgressEmptyListMsg()
          : const ProgressTermList(),
    );
  }
}
