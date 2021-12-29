import 'dart:async';

import 'package:hive/hive.dart';
import 'package:vocabulary101_app/app/data/models/session_card.dart';
import 'package:vocabulary101_app/app/data/services/session_card_service.dart';

class SessionCardHiveProvider extends SessionCardService {
  // Hive box instance
  late Box _hiveBox;

  @override
  Future<void> initProvider() async {
    // Get Hive box instance
    _hiveBox = Hive.box('viewedSessionCards');
  }

  ///
  // Future<Library?> byId(String id) async {
  //   final boxValue = _hiveBox.get(id);
  //   return boxValue != null
  //       ? Library.fromJson(Map<String, dynamic>.from(boxValue))
  //       : null;
  // }

  ///
  @override
  Stream<List<SessionCard>> watchAll() async* {
    final firstValues = _hiveBox.toMap();

    if (firstValues.isNotEmpty) {
      yield firstValues.values
          .map(
            (value) => SessionCard.fromJson(
              Map<String, dynamic>.from(value),
            ),
          )
          .toList();
    } else {
      yield [];
    }

    yield* _hiveBox.watch().map((event) {
      final values = _hiveBox.toMap();
      return values.values
          .map(
            (value) => SessionCard.fromJson(
              Map<String, dynamic>.from(value),
            ),
          )
          .toList();
    });
  }

  ///
  @override
  Future<String> add(SessionCard scard) async {
    await _hiveBox.put(scard.id, scard.toJson());
    return scard.id;
  }

  ///
  @override
  Future<void> update(SessionCard scard) async {
    await _hiveBox.put(scard.id, scard.toJson());
  }

  ///
  // @override
  // Future<void> removeById(String id) async {
  //   await _hiveBox.delete(id);
  // }

  ///
  // Future<List<Library>> all() async {
  //   List<Library> libraries = [];
  //   final keys = List<String>.from(_hiveBox.keys);
  //   for (String key in keys) {
  //     var value = await _hiveBox.get(key);
  //     libraries.add(
  //       Library.fromJson(Map<String, dynamic>.from(value)),
  //     );
  //   }
  //   return libraries;
  // }
}
