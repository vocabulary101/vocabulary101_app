import 'dart:async';

import 'package:hive/hive.dart';
import 'package:vocabulary101_app/app/data/models/learning_session.dart';
import 'package:vocabulary101_app/app/data/services/learning_session_service.dart';

class LearningSessionHiveProvider extends LearningSessionService {
  // Hive box instance
  late Box _hiveBox;

  @override
  Future<void> initProvider() async {
    // Get Hive box instance
    _hiveBox = Hive.box('learningSessions');
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
  Stream<LearningSession?> watch() async* {
    // temp
    String id = 'local';

    var firstValue = _hiveBox.get(id);

    if (firstValue != null) {
      //
      yield LearningSession.fromJson(
        Map<String, dynamic>.from(
          firstValue,
        ),
      );
    } else {
      yield null;
    }
    //
    yield* _hiveBox.watch(key: id).map((event) {
      return event.value != null
          ? LearningSession.fromJson(Map<String, dynamic>.from(event.value))
          : null;
    });
  }

  ///
  @override
  Future<String> add(LearningSession lsession) async {
    if (lsession.id == '') {
      lsession = lsession.copyWith(
        // id: ModelHelpers.generateFirestoreID(),
        id: 'local',
      );
    }
    await _hiveBox.put(lsession.id, lsession.toJson());
    return lsession.id;
  }

  ///
  // Future<void> update(Library library) async {
  //   await _hiveBox.put(library.id, library.toJson());
  // }

  ///
  @override
  Future<void> removeById(String id) async {
    await _hiveBox.delete(id);
  }

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
