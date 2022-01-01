import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocabulary101_app/app/modules/home/controllers/home_controller.dart';

class SessionProgressLinearIndicator extends StatelessWidget {
  final double opacity;

  const SessionProgressLinearIndicator({
    Key? key,
    this.opacity = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 5,
      decoration: BoxDecoration(
        color: const Color(0xFFE3E3E3).withOpacity(opacity),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Obx(
        () {
          final homeCtrl = HomeController.to;
          final numCards = homeCtrl.currentLearningSession.value!.cards.length;
          final progressFlex = homeCtrl.currentCardIndex.value + 1;
          return Row(
            children: [
              Flexible(
                flex: progressFlex,
                child: Container(
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4D8EDA),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              Flexible(
                flex: numCards - progressFlex,
                child: Container(),
              ),
            ],
          );
        },
      ),
    );
  }
}
