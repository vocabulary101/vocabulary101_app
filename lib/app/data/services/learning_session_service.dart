import 'package:vocabulary101_app/app/data/models/learning_session.dart';

abstract class LearningSessionService {
  ///
  Future<void> initProvider();

  ///
  // Future<Library?> byId(String id);

  ///
  Stream<LearningSession?> watch();

  ///
  Future<String> add(LearningSession lsession);

  ///
  // Future<void> update(Library library);

  ///
  Future<void> removeById(String id);

  ///
  // Future<List<Library>> all();
}
