import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vocabulary101_app/app/core/icons/v101_icons.dart';
import 'package:vocabulary101_app/app/modules/home/widgets/session_card_view.dart';
import 'package:vocabulary101_app/app/modules/home/widgets/no_learning_session_msg.dart';
import 'package:vocabulary101_app/app/widgets/circle_icon_button.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        leadingWidth: 50,
        leading: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(2),
          child: Image.asset('assets/images/lang_flags/en-us.png'),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: const Color(0xFFECECEC), width: 1),
          ),
        ),
        title: const Text(
          'Learning Session',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            child: CircleIconButton(
              icon: const Icon(V101Icons.cloud_sync),
              border: Border.all(
                color: const Color(0xFFECECEC),
              ),
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              backgroundColor: Colors.transparent,
              hoverColor: const Color(0xFF4D8EDA).withOpacity(.11),
              highlightColor: const Color(0xFF4D8EDA).withOpacity(.11),
              splashColor: const Color(0xFF4D8EDA).withOpacity(.14),
              focusColor: const Color(0xFF4D8EDA).withOpacity(.2),
              onPressed: () async {},
            ),
          ),
        ],
      ),
      body: Obx(
        () => HomeController.to.currentLearningSession.value == null
            ? const NoLearningSessionMsg()
            : const SessionCardView(),
      ),
    );
  }
}
