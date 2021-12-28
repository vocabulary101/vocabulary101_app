import 'package:flutter/material.dart';
import 'package:blur/blur.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:soundpool/soundpool.dart';

import 'package:vocabulary101_app/app/core/icons/v101_icons.dart';
import 'package:vocabulary101_app/app/modules/home/controllers/home_controller.dart';
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
    final staticCard = HomeController.to.currentStaticCard.value!;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 5,
            decoration: BoxDecoration(
              color: const Color(0xFFE3E3E3),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 70,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFF4D8EDA),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'This card is hard for you',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
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

    // final word = data['a'];
    // final meaning = (data['b'] as String)
    //     .replaceAll('<i>', '*')
    //     .replaceAll('</i>', '*')
    //     .replaceAll('<b>', '**')
    //     .replaceAll('</b>', '**');
    // final example = (data['c'] as String)
    //     .replaceAll('<i>', '*')
    //     .replaceAll('</i>', '*')
    //     .replaceAll('<b>', '**')
    //     .replaceAll('</b>', '**');
    // // final ipa = data['d'];
    // final Uint8List wordAudioBytes = base64Decode(data['e'].toString());
    // final Uint8List meaningAudioBytes = base64Decode(data['f'].toString());
    // final Uint8List exampleAudioBytes = base64Decode(data['g'].toString());
    // final Uint8List photoBytes = base64Decode(data['h'].toString());

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      // padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      color: Colors.white,
      child: Column(
        children: [
          Stack(
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
                    Expanded(
                      child: Container(
                        height: 5,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3E3E3).withOpacity(.5),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: 70,
                            height: 5,
                            decoration: BoxDecoration(
                              color: const Color(0xFF4D8EDA).withOpacity(.6),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
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
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    staticCard.term,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(V101Icons.listen, size: 23),
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
                    constraints:
                        const BoxConstraints(minWidth: 1, minHeight: 1),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: Divider(height: 1),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
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
                          onPressed: () async {
                            Soundpool pool = Soundpool.fromOptions(
                              options: const SoundpoolOptions(
                                streamType: StreamType.music,
                              ),
                            );

                            int soundId = await pool.load(
                              staticCard.meaningAudioBytes.buffer.asByteData(),
                            );
                            await pool.play(soundId);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Theme(
                      data: ThemeData(
                        textTheme: TextTheme(
                          bodyText2: Get.textTheme.bodyText2!.copyWith(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      child: MarkdownBody(
                        data: staticCard.meaning,
                      ),
                    ),
                    const SizedBox(height: 15),
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
                          onPressed: () async {
                            Soundpool pool = Soundpool.fromOptions(
                              options: const SoundpoolOptions(
                                streamType: StreamType.music,
                              ),
                            );

                            int soundId = await pool.load(
                              staticCard.exampleAudioBytes.buffer.asByteData(),
                            );
                            await pool.play(soundId);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Theme(
                      data: ThemeData(
                        textTheme: TextTheme(
                          bodyText2: Get.textTheme.bodyText2!.copyWith(
                            fontSize: 15,
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
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  child: const Text(
                    'AGAIN',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFFFF0000),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    primary: const Color(0xFFFF0000),
                    backgroundColor: const Color(0xFFFF0000).withOpacity(.1),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.symmetric(
                      vertical: 27,
                      horizontal: 10,
                    ),
                    side: const BorderSide(
                      width: 1,
                      color: Color(0xFFFF0000),
                    ),
                    minimumSize: Size.zero,
                  ),
                  onPressed: () {
                    HomeController.to.currentCardIndex.value++;
                  },
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  child: const Text(
                    'HARD',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFFCB6E18),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    primary: const Color(0xFFF88A25),
                    backgroundColor: const Color(0xFFF88A25).withOpacity(.1),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.symmetric(
                      vertical: 27,
                      horizontal: 10,
                    ),
                    side: const BorderSide(
                      width: 1,
                      color: Color(0xFFF88A25),
                    ),
                  ),
                  onPressed: () {
                    HomeController.to.isCardBackSide.value = false;
                  },
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  child: const Text(
                    'GOOD',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF4D8EDA),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    primary: const Color(0xFF4D8EDA),
                    backgroundColor: const Color(0xFF4D8EDA).withOpacity(.1),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.symmetric(
                      vertical: 27,
                      horizontal: 10,
                    ),
                    side: const BorderSide(
                      width: 1,
                      color: Color(0xFF4D8EDA),
                    ),
                  ),
                  onPressed: () {
                    HomeController.to.isCardBackSide.value = false;
                  },
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  child: const Text(
                    'EASY',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF34A400),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    primary: const Color(0xFF34A400),
                    backgroundColor: const Color(0xFF34A400).withOpacity(.1),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.symmetric(
                      vertical: 27,
                      horizontal: 10,
                    ),
                    side: const BorderSide(
                      width: 1,
                      color: Color(0xFF34A400),
                    ),
                  ),
                  onPressed: () {
                    HomeController.to.isCardBackSide.value = false;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
