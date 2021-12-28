import 'dart:async';

import 'package:get/get.dart';
import 'package:vocabulary101_app/app/data/models/learning_session.dart';
import 'package:vocabulary101_app/app/data/models/session_card.dart';
import 'package:vocabulary101_app/app/data/models/static_card.dart';
import 'package:vocabulary101_app/app/modules/home/repositories/home_repository.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  //
  // Subscriptions and repositories variables
  //

  StreamSubscription? _appUserSubscription;
  StreamSubscription? _learningSessionSubscription;

  final HomeRepository homeRepository = HomeRepository();

  //
  // General ui variables
  //

  var bottomNavigationBarIndex = 0.obs;

  //
  // Content variables
  //

  // Reactive current Library instance
  Rxn<LearningSession> currentLearningSession = Rxn<LearningSession>();

  var currentCardIndex = (-1).obs;
  var currentStaticCard = Rxn<StaticCard>();
  var isCardBackSide = false.obs;

  @override
  void onInit() async {
    super.onInit();

    // Init or re-init home repository providers (Ex.: local or remote db)
    await homeRepository.initProviders(isLocal: true);

    ever(currentCardIndex, _handleCardIndexChanges);

    // Load current learning session (subscription)
    await _loadLearningSession();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  //
  Future<void> _loadLearningSession() async {
    //
    await _learningSessionSubscription?.cancel();

    _learningSessionSubscription =
        homeRepository.watchUserLearningSession().listen(
      (learningSession) async {
        // Set new value and refresh view
        currentLearningSession.value = learningSession;
        currentLearningSession.refresh();

        if (learningSession != null) {
          //temp
          // Load the first card
          currentCardIndex.value = 0;
        }
      },
    );
  }

  Future<void> startLearningSession() async {
    const maxStaticCardId = -1;

    List<SessionCard> cards = [];

    // var counter = 1;
    // while (cards.length < 10 || counter == 100) {
    //   final staticCard = await homeRepository.getStaticCardById(
    //     (maxStaticCardId + counter).toString(),
    //   );

    //   if (staticCard != null) {
    //     cards.add(
    //       SessionCard(
    //         id: 'en' + staticCard.id,
    //         status: LearningStatus.undefined,
    //         lastUpdateAt: DateTime.now(),
    //       ),
    //     );
    //   }

    //   counter++;
    // }

    for (int i = 1; i <= 10; i++) {
      cards.add(
        SessionCard(
          id: 'en' + (maxStaticCardId + i).toString(),
          status: LearningStatus.undefined,
          lastUpdateAt: DateTime.now(),
        ),
      );
    }

    await homeRepository.addLearningSession(
      LearningSession(
        id: 'local',
        cards: cards,
      ),
    );

    // Load the first card
    currentCardIndex.value = 0;
  }

  Future<void> cancelLearningSession() async {
    await homeRepository.removeLearningSessionById('local');
  }

  Future<void> finishLearningSession() async {
    // Save session cards
    // ...

    await homeRepository.removeLearningSessionById('local');
  }

  void _handleCardIndexChanges(index) async {
    print('Index: $index');
    // If is a valid index
    if (index >= 0 && index < currentLearningSession.value!.cards.length) {
      // Reset card side
      isCardBackSide.value = false;

      // Show loading effect
      currentStaticCard.value = null;

      // Load remote or cached StaticCard
      currentStaticCard.value = await homeRepository.getStaticCardById(
        currentLearningSession.value!.cards[index].id.substring(2),
      );
    } else {
      // Finish learning session
      await finishLearningSession();
    }
  }
}
