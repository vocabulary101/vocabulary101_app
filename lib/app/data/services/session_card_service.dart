import 'package:vocabulary101_app/app/data/models/session_card.dart';

abstract class SessionCardService {
  ///
  Future<void> initProvider();

  ///
  // Future<Library?> byId(String id);

  ///
  Stream<List<SessionCard>> watchAll();

  ///
  Future<String> add(SessionCard scard);

  ///
  Future<void> update(SessionCard scard);

  ///
  // Future<void> removeById(String id);

  ///
  // Future<List<Library>> all();
}
