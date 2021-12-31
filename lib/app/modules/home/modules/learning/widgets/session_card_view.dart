import 'package:flutter/material.dart';
import 'package:blur/blur.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:soundpool/soundpool.dart';

import 'package:vocabulary101_app/app/core/icons/v101_icons.dart';
import 'package:vocabulary101_app/app/data/models/session_card.dart';
import 'package:vocabulary101_app/app/data/models/static_card.dart';
import 'package:vocabulary101_app/app/modules/home/controllers/home_controller.dart';
import 'package:vocabulary101_app/app/modules/home/modules/learning/widgets/session_progress_linear_indicator.dart';
import 'package:vocabulary101_app/app/widgets/circle_icon_button.dart';

class SessionCardView extends StatelessWidget {
  const SessionCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => HomeController.to.currentStaticCard.value == null
          ? const LoadingCard()
          : !HomeController.to.isCardBackSide.value
              ? const FrontCard()
              : const BackCard(),
    );
  }
}

class LoadingCard extends StatelessWidget {
  const LoadingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 30,
          ),
          Text('Loading Card'),
        ],
      ),
    );
  }
}

class FrontCard extends StatelessWidget {
  const FrontCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeCtrl = HomeController.to;

    final staticCard = homeCtrl.currentStaticCard.value!;
    final currentSessionCard = homeCtrl
        .currentLearningSession.value!.cards[homeCtrl.currentCardIndex.value];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 10),
            child: SessionProgressLinearIndicator(),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'This card is ',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    '"${currentSessionCard.getStatusAsString()}"',
                    style: TextStyle(
                      color: currentSessionCard.getStatusColor(),
                      fontSize: 15,
                    ),
                  ),
                  const Text(
                    ' for you',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(V101Icons.more_vert),
                onPressed: () async {
                  await HomeController.to.cancelLearningSession();
                },
              )
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: double.infinity,
                    height: 80,
                  ),
                  Text(
                    staticCard.term,
                    style: const TextStyle(fontSize: 48),
                  ),
                  const SizedBox(height: 30),
                  CircleIconButton(
                    icon: const Icon(V101Icons.listen),
                    border: Border.all(
                      color: const Color(0xFFABABAB),
                    ),
                    padding: const EdgeInsets.fromLTRB(10, 9, 10, 11),
                    backgroundColor: Colors.transparent,
                    hoverColor: const Color(0xFF4D8EDA).withOpacity(.11),
                    highlightColor: const Color(0xFF4D8EDA).withOpacity(.11),
                    splashColor: const Color(0xFF4D8EDA).withOpacity(.14),
                    focusColor: const Color(0xFF4D8EDA).withOpacity(.2),
                    onPressed: () async {
                      Soundpool pool = Soundpool.fromOptions(
                        options: const SoundpoolOptions(
                          streamType: StreamType.music,
                        ),
                      );

                      int soundId = await pool.load(
                        staticCard.termAudioBytes.buffer.asByteData(),
                      );
                      await pool.play(soundId);
                    },
                  ),
                  const SizedBox(height: 60),
                  Text(
                    staticCard.ipa,
                    style: const TextStyle(
                      fontSize: 28,
                      fontFamily: 'NotoSansMono',
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.center,
            child: CircleIconButton(
              icon: const Icon(V101Icons.flip_card),
              border: Border.all(
                color: const Color(0xFF4D8EDA),
              ),
              padding: const EdgeInsets.fromLTRB(14, 13, 14, 15),
              iconSize: 32,
              backgroundColor: const Color(0xFF4D8EDA).withOpacity(.1),
              hoverColor: const Color(0xFF4D8EDA).withOpacity(.11),
              highlightColor: const Color(0xFF4D8EDA).withOpacity(.11),
              splashColor: const Color(0xFF4D8EDA).withOpacity(.14),
              focusColor: const Color(0xFF4D8EDA).withOpacity(.2),
              onPressed: () {
                HomeController.to.isCardBackSide.value = true;
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BackCard extends StatelessWidget {
  const BackCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final staticCard = HomeController.to.currentStaticCard.value!;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: Scrollbar(
              isAlwaysShown: true,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const BackCardImageHeader(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              staticCard.term,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(V101Icons.listen, size: 23),
                            color: const Color(0xFF3869A3),
                            onPressed: () async {
                              Soundpool pool = Soundpool.fromOptions(
                                options: const SoundpoolOptions(
                                  streamType: StreamType.music,
                                ),
                              );

                              int soundId = await pool.load(
                                staticCard.termAudioBytes.buffer.asByteData(),
                              );
                              await pool.play(soundId);
                            },
                          ),
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            child: IconButton(
                              icon: const Icon(V101Icons.help),
                              padding: const EdgeInsets.all(3),
                              iconSize: 16,
                              constraints: const BoxConstraints(
                                  minWidth: 1, minHeight: 1),
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                      child: Divider(height: 1),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Meaning',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF848484),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(V101Icons.listen, size: 21),
                                color: const Color(0xFF3869A3),
                                onPressed: () async {
                                  Soundpool pool = Soundpool.fromOptions(
                                    options: const SoundpoolOptions(
                                      streamType: StreamType.music,
                                    ),
                                  );

                                  int soundId = await pool.load(
                                    staticCard.meaningAudioBytes.buffer
                                        .asByteData(),
                                  );
                                  await pool.play(soundId);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Theme(
                            data: ThemeData(
                              textTheme: TextTheme(
                                bodyText2: Get.textTheme.bodyText2!.copyWith(
                                  fontSize: 20,
                                  height: 1.5,
                                ),
                              ),
                            ),
                            child: MarkdownBody(
                              data: staticCard.meaning,
                            ),
                          ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Example',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF848484),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(V101Icons.listen, size: 21),
                                color: const Color(0xFF3869A3),
                                onPressed: () async {
                                  Soundpool pool = Soundpool.fromOptions(
                                    options: const SoundpoolOptions(
                                      streamType: StreamType.music,
                                    ),
                                  );

                                  int soundId = await pool.load(
                                    staticCard.exampleAudioBytes.buffer
                                        .asByteData(),
                                  );
                                  await pool.play(soundId);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Theme(
                            data: ThemeData(
                              textTheme: TextTheme(
                                bodyText2: Get.textTheme.bodyText2!.copyWith(
                                  fontSize: 20,
                                  height: 1.5,
                                ),
                              ),
                            ),
                            child: MarkdownBody(
                              data: staticCard.example,
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            child: const TermStatusButtons(),
          ),
        ],
      ),
    );
  }
}

class BackCardImageHeader extends StatelessWidget {
  const BackCardImageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final staticCard = HomeController.to.currentStaticCard.value!;

    return Stack(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Blur(
              blur: 5,
              blurColor: Colors.black,
              child: Image.memory(
                staticCard.photoBytes,
                width: double.infinity,
                height: 260,
                fit: BoxFit.cover,
              ), // Widget that is blurred
            ),
            Image.memory(
              staticCard.photoBytes,
              height: 260,
              fit: BoxFit.fitHeight,
              repeat: ImageRepeat.repeatX,
            ),
          ],
        ),
        Positioned(
          top: 10,
          left: 10,
          right: 5,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: SessionProgressLinearIndicator(opacity: .5),
                ),
              ),
              IconButton(
                icon: const Icon(V101Icons.more_vert),
                onPressed: () {},
              )
            ],
          ),
        ),
      ],
    );
  }
}

class TermStatusButtons extends StatelessWidget {
  const TermStatusButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          child: const Text(
            'AGAIN',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: const Color(0xFFFF0000),
            // backgroundColor: const Color(0xFFFF0000).withOpacity(.1),
            // shape: const CircleBorder(),
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 14,
            ),
            side: const BorderSide(
              width: 1,
              color: Color(0xFFFF0000),
            ),
            minimumSize: Size.zero,
          ),
          onPressed: () {
            final homeCtrl = HomeController.to;

            // Change SessionCard status
            homeCtrl.setLearningSessionCardStatus(LearningStatus.again);

            // Go to the next card
            homeCtrl.currentCardIndex.value++;
          },
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          child: const Text(
            'HARD',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: const Color(0xFFF88A25),
            // backgroundColor: const Color(0xFFF88A25).withOpacity(.1),
            // shape: const CircleBorder(),
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 14,
            ),
            side: const BorderSide(
              width: 1,
              color: Color(0xFFF88A25),
            ),
          ),
          onPressed: () {
            final homeCtrl = HomeController.to;

            // Change SessionCard status
            homeCtrl.setLearningSessionCardStatus(LearningStatus.hard);

            // Go to the next card
            homeCtrl.currentCardIndex.value++;
          },
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          child: const Text(
            'GOOD',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: const Color(0xFF4D8EDA),
            // backgroundColor: const Color(0xFF4D8EDA).withOpacity(.1),
            // shape: const CircleBorder(),
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 14,
            ),
            side: const BorderSide(
              width: 1,
              color: Color(0xFF4D8EDA),
            ),
          ),
          onPressed: () {
            final homeCtrl = HomeController.to;

            // Change SessionCard status
            homeCtrl.setLearningSessionCardStatus(LearningStatus.good);

            // Go to the next card
            homeCtrl.currentCardIndex.value++;
          },
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          child: const Text(
            'EASY',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: const Color(0xFF34A400),
            // backgroundColor: const Color(0xFF34A400).withOpacity(.1),
            // shape: const CircleBorder(),
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 14,
            ),
            side: const BorderSide(
              width: 1,
              color: Color(0xFF34A400),
            ),
          ),
          onPressed: () {
            final homeCtrl = HomeController.to;

            // Change SessionCard status
            homeCtrl.setLearningSessionCardStatus(LearningStatus.easy);

            // Go to the next card
            homeCtrl.currentCardIndex.value++;
          },
        ),
      ],
    );
  }
}
