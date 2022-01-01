// Place fonts/V101Icons.ttf in your fonts/ directory and
// add the following to your pubspec.yaml
// flutter:
//   fonts:
//    - family: V101Icons
//      fonts:
//       - asset: fonts/V101Icons.ttf
// ignore_for_file: constant_identifier_names

import 'package:flutter/widgets.dart';

class V101Icons {
  V101Icons._();

  static const String _fontFamily = 'V101Icons';

  static const IconData close = IconData(0xe908, fontFamily: _fontFamily);
  static const IconData viewed_card = IconData(0xe909, fontFamily: _fontFamily);
  static const IconData more_vert = IconData(0xe904, fontFamily: _fontFamily);
  static const IconData help = IconData(0xe900, fontFamily: _fontFamily);
  static const IconData profile = IconData(0xe901, fontFamily: _fontFamily);
  static const IconData cards = IconData(0xe902, fontFamily: _fontFamily);
  static const IconData card_list = IconData(0xe903, fontFamily: _fontFamily);
  static const IconData flip_card = IconData(0xe905, fontFamily: _fontFamily);
  static const IconData listen = IconData(0xe906, fontFamily: _fontFamily);
  static const IconData cloud_sync = IconData(0xe907, fontFamily: _fontFamily);
}
