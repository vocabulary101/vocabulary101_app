import 'package:vocabulary101_app/app/data/models/learning_session.dart';
import 'package:vocabulary101_app/app/data/models/session_card.dart';
import 'package:vocabulary101_app/app/data/models/static_card.dart';
import 'package:vocabulary101_app/app/data/providers/learning_session_hive_provider.dart';
import 'package:vocabulary101_app/app/data/providers/session_card_hive_provider.dart';
import 'package:vocabulary101_app/app/data/providers/static_card_http_provider.dart';
import 'package:vocabulary101_app/app/data/services/learning_session_service.dart';
import 'package:vocabulary101_app/app/data/services/session_card_service.dart';
import 'package:vocabulary101_app/app/data/services/static_card_service.dart';

class HomeRepository {
  late StaticCardService _staticCardService;
  late SessionCardService _sessionCardService;
  late LearningSessionService _learningSessionService;

  Future<void> initProviders({required bool isLocal}) async {
    //
    // Init StaticCard service
    //

    _staticCardService = StaticCardHttpProvider();
    await _staticCardService.initProvider();

    //
    // Init SessionCard service
    //

    _sessionCardService = SessionCardHiveProvider();
    await _sessionCardService.initProvider();

    //
    // Init LearningSession service
    //

    _learningSessionService = LearningSessionHiveProvider();
    await _learningSessionService.initProvider();
  }

  //
  // StaticCard methods
  //

  Future<StaticCard?> getStaticCardById(String id) async {
    return await _staticCardService.byId(id);
  }

  //
  // SessionCard methods
  //

  Stream<List<SessionCard>> watchUserSessionCards() {
    return _sessionCardService.watchAll();
  }

  Future<String> addSessionCard(SessionCard scard) async {
    return await _sessionCardService.add(scard);
  }

  Future<void> updateSessionCard(SessionCard scard) async {
    return await _sessionCardService.update(scard);
  }

  //
  // LearningSession methods
  //

  Stream<LearningSession?> watchUserLearningSession() {
    return _learningSessionService.watch();
  }

  Future<String> addLearningSession(LearningSession lsession) async {
    return await _learningSessionService.add(lsession);
  }

  // Future<void> updateLibrary(Library library) async {
  //   await _libraryService.update(library);
  // }

  Future<void> removeLearningSessionById(String id) async {
    await _learningSessionService.removeById(id);
  }

  // Future<List<Library>> getAllLibraries() async {
  //   return await _libraryService.all();
  // }

  //
  // Resource methods
  //

  // Future<String> addResource(
  //   Resource resource,
  // ) async {
  //   final String newUDDId = await _resourceService.add(
  //     resource,
  //   );

  //   return newUDDId;
  // }

  // Future<void> removeResourceById(String id) async {
  //   await _resourceService.removeById(id);
  // }
}
