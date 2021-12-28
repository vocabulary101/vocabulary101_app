import 'dart:async';
import 'dart:convert';
import 'package:archive/archive.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:http/http.dart' as http;

import 'package:vocabulary101_app/app/data/models/static_card.dart';
import 'package:vocabulary101_app/app/data/services/static_card_service.dart';

class StaticCardHttpProvider extends StaticCardService {
  @override
  Future<void> initProvider() async {}

  ///
  @override
  Future<StaticCard?> byId(String id) async {
    var url = Uri.parse((GetPlatform.isWeb ? '' : 'https://vocabulary101.com') +
        '/json/en/cards/$id.json');

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final gzipBytes = response.bodyBytes;

      var stringBytes = GZipDecoder().decodeBytes(gzipBytes);

      var jsonString = utf8.decode(stringBytes);

      var jsonMap = Map<String, dynamic>.from(
        json.decode(jsonString),
      );

      jsonMap['id'] = id;

      // HTML to Markdown for 'meaning' property
      jsonMap['b'] = jsonMap['b']
          .replaceAll('<i>', '*')
          .replaceAll('</i>', '*')
          .replaceAll('<b>', '**')
          .replaceAll('</b>', '**');

      // HTML to Markdown for 'example' property
      jsonMap['c'] = jsonMap['c']
          .replaceAll('<i>', '*')
          .replaceAll('</i>', '*')
          .replaceAll('<b>', '**')
          .replaceAll('</b>', '**');

      return StaticCard.fromJson(jsonMap);
    } else {
      // print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }
}
