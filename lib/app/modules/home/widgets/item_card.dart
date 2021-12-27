import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:soundpool/soundpool.dart';
import 'package:vocabulary101_app/app/core/icons/v101_icons.dart';
import 'package:vocabulary101_app/app/modules/home/controllers/home_controller.dart';
import 'package:vocabulary101_app/app/widgets/circle_icon_button.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: tempCardData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Obx(
            () => !HomeController.to.isCardBackSide.value
                ? FrontCard(
                    data: snapshot.data!,
                  )
                : BackCard(
                    data: snapshot.data!,
                  ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Future<Map<String, dynamic>> tempCardData() async {
    var url = Uri.parse((GetPlatform.isWeb ? '' : 'https://vocabulary101.com') +
        '/json/en/cards/0.json');

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final gzipBytes = response.bodyBytes;

      var stringBytes = GZipDecoder().decodeBytes(gzipBytes);

      var jsonString = utf8.decode(stringBytes);

      return Map<String, dynamic>.from(
        json.decode(jsonString),
      );
    } else {
      // print('Request failed with status: ${response.statusCode}.');
      return {};
    }
  }
}

class FrontCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const FrontCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final word = data['a'];
    final ipa = data['d'];
    final Uint8List wordAudioBytes = base64Decode(data['e'].toString());

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
                onPressed: () {},
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
                    word,
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
                        wordAudioBytes.buffer.asByteData(),
                      );
                      await pool.play(soundId);
                    },
                  ),
                  const SizedBox(height: 60),
                  Text(
                    ipa,
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
  final Map<String, dynamic> data;

  const BackCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final word = data['a'];
    final meaning = (data['b'] as String)
        .replaceAll('<i>', '*')
        .replaceAll('</i>', '*')
        .replaceAll('<b>', '**')
        .replaceAll('</b>', '**');
    final example = (data['c'] as String)
        .replaceAll('<i>', '*')
        .replaceAll('</i>', '*')
        .replaceAll('<b>', '**')
        .replaceAll('</b>', '**');
    // final ipa = data['d'];
    final Uint8List wordAudioBytes = base64Decode(data['e'].toString());
    final Uint8List meaningAudioBytes = base64Decode(data['f'].toString());
    final Uint8List exampleAudioBytes = base64Decode(data['g'].toString());
    final Uint8List photoBytes = base64Decode(data['h'].toString());

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
                      photoBytes,
                      width: double.infinity,
                      height: 260,
                      fit: BoxFit.cover,
                    ), // Widget that is blurred
                  ),
                  Image.memory(
                    photoBytes,
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
                    word,
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
                      wordAudioBytes.buffer.asByteData(),
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
                              meaningAudioBytes.buffer.asByteData(),
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
                        data: meaning,
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
                              exampleAudioBytes.buffer.asByteData(),
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
                        data: example,
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
                    HomeController.to.isCardBackSide.value = false;
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
