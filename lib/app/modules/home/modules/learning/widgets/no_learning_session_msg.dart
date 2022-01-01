import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocabulary101_app/app/core/icons/v101_icons.dart';
import 'package:vocabulary101_app/app/modules/home/controllers/home_controller.dart';

class NoLearningSessionMsg extends StatelessWidget {
  const NoLearningSessionMsg({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      color: Colors.white,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 800,
            maxWidth: 800,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  'Start Learning Session',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Select one of the following options to start a new learning session:',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 30),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    // StartLearningSessionCardButton(
                    //   title: 'New words & reviews',
                    //   subtitle: '10 cards with all words',
                    //   onTap: () async {
                    //     // await HomeController.to.startLearningSession();
                    //   },
                    // ),
                    StartLearningSessionCardButton(
                      title: 'Only new words',
                      subtitle: '10 cards with only new words',
                      onTap: () async {
                        await HomeController.to.startLearningSession();
                      },
                    ),
                    // StartLearningSessionCardButton(
                    //   title: 'Review AGAIN cards',
                    //   subtitle: '10 of your AGAIN cards',
                    //   color: const Color(0xFFFFFBFC),
                    //   borderColor: const Color(0x33EF476F),
                    //   contentColor: const Color(0xFFEF476F),
                    //   shadowColor: const Color(0x1AAF3451),
                    //   onTap: () async {
                    //     // await HomeController.to.startLearningSession();
                    //   },
                    // ),
                    // StartLearningSessionCardButton(
                    //   title: 'Review HARD cards',
                    //   subtitle: '10 of your HARD cards',
                    //   color: const Color(0xFFFFFDFB),
                    //   borderColor: const Color(0x33F99F36),
                    //   contentColor: const Color(0xFFF99F36),
                    //   shadowColor: const Color(0x1AB7762B),
                    //   onTap: () async {
                    //     // await HomeController.to.startLearningSession();
                    //   },
                    // ),
                    // StartLearningSessionCardButton(
                    //   title: 'Review GOOD cards',
                    //   subtitle: '10 of your GOOD cards',
                    //   color: const Color(0xFFFAFDFD),
                    //   borderColor: const Color(0x331B9AAA),
                    //   contentColor: const Color(0xFF1B9AAA),
                    //   shadowColor: const Color(0x1A146E79),
                    //   onTap: () async {
                    //     // await HomeController.to.startLearningSession();
                    //   },
                    // ),
                    // StartLearningSessionCardButton(
                    //   title: 'Review EASY cards',
                    //   subtitle: '10 of your EASY cards',
                    //   color: const Color(0xFFFAFEFD),
                    //   borderColor: const Color(0x3306D6A0),
                    //   contentColor: const Color(0xFF05B889),
                    //   shadowColor: const Color(0x1A048463),
                    //   onTap: () async {
                    //     // await HomeController.to.startLearningSession();
                    //   },
                    // ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  '3600 words available in English.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StartLearningSessionCardButton extends StatelessWidget {
  final Color color;
  final Color borderColor;
  final Color contentColor;
  final Color shadowColor;
  final String title;
  final String subtitle;
  final Function()? onTap;

  const StartLearningSessionCardButton({
    Key? key,
    this.color = const Color(0xFFFBFAFD),
    this.borderColor = const Color(0x3D8462C1),
    this.contentColor = const Color(0xFF8462C1),
    this.shadowColor = const Color(0x1A5B4485),
    required this.title,
    required this.subtitle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 350,
        maxWidth: 350,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: borderColor,
        ),
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            offset: const Offset(0, 2),
            blurRadius: 7,
          ),
        ],
      ),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(7),
        elevation: 0,
        child: Ink(
          child: InkWell(
            hoverColor: contentColor.withOpacity(.05),
            highlightColor: Colors.transparent,
            splashColor: contentColor.withOpacity(.1),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    V101Icons.cards,
                    size: 42,
                    color: contentColor,
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: contentColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: contentColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
