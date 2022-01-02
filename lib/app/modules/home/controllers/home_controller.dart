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

  // StreamSubscription? _appUserSubscription;
  StreamSubscription? _learningSessionSubscription;
  StreamSubscription? _progressVocabularySubscription;

  final HomeRepository homeRepository = HomeRepository();

  //
  // General ui variables
  //

  var isVideoRecordingMode = false.obs;

  // var bottomNavigationBarIndex = 0.obs;

  //
  // Progress View variables
  //

  // Reactive user SessionCard list
  var userSessionCards = <SessionCard>[].obs;

  //
  // Learning View variables
  //

  // 'You have' section data variables
  var numNewCards = 0.obs;
  var numEasyCards = 0.obs;
  var numAgainCards = 0.obs;
  var numHardCards = 0.obs;
  var numGoodCards = 0.obs;

  // Reactive current LearningSession instance
  var currentLearningSession = Rxn<LearningSession>();

  var currentCardIndex = (-1).obs;
  var currentStaticCard = Rxn<StaticCard>();
  var isCardBackSide = false.obs;

  @override
  void onInit() async {
    super.onInit();

    // Init or re-init home repository providers (Ex.: local or remote db)
    await homeRepository.initProviders(isLocal: true);

    ever(currentCardIndex, _handleCardIndexChanges);

    // Load user session cards, that is, user progress (subscription)
    await _loadProgressVocabulary();

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
  Future<void> _loadProgressVocabulary() async {
    //
    await _progressVocabularySubscription?.cancel();

    _progressVocabularySubscription =
        homeRepository.watchUserSessionCards().listen(
      (sessionCards) async {
        // Set new value and refresh view
        userSessionCards.value = sessionCards;

        // Update 'You have' section data
        _updateYouHaveSectionData();
      },
    );
  }

  void _updateYouHaveSectionData() {
    // TEMP hardcoded value
    const numTotalStaticCards = 3600;

    // Reset values
    numEasyCards.value = 0;
    numAgainCards.value = 0;
    numHardCards.value = 0;
    numGoodCards.value = 0;

    for (SessionCard sc in userSessionCards) {
      if (sc.status == LearningStatus.easy) {
        numEasyCards.value++;
      } else if (sc.status == LearningStatus.good) {
        numGoodCards.value++;
      } else if (sc.status == LearningStatus.hard) {
        numHardCards.value++;
      } else if (sc.status == LearningStatus.again) {
        numAgainCards.value++;
      }
    }

    // Remaining new term cards
    numNewCards.value = numTotalStaticCards -
        numEasyCards.value -
        numAgainCards.value -
        numHardCards.value -
        numGoodCards.value;
  }

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
    var maxStaticCardId = -1;
    for (var sc in userSessionCards) {
      final sCardId = int.parse(sc.id.substring(2));
      if (sCardId > maxStaticCardId) {
        maxStaticCardId = sCardId;
      }
    }

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
          term: '',
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

  void setLearningSessionCardStatus(LearningStatus status) {
    for (int i = 0; i < currentLearningSession.value!.cards.length; i++) {
      var scard = currentLearningSession.value!.cards[i];
      if (scard.id == 'en' + currentStaticCard.value!.id) {
        currentLearningSession.value!.cards[i] = scard.copyWith(
          term: currentStaticCard.value!.term,
          status: status,
          lastUpdateAt: DateTime.now().toUtc(),
        );
      }
    }
  }

  Future<void> cancelLearningSession() async {
    // Delete current Learning Session
    await homeRepository.removeLearningSessionById('local');
  }

  Future<void> finishLearningSession() async {
    // Save session cards
    for (var sessionCard in currentLearningSession.value!.cards) {
      // If term is not empty, it has at least one user interaction
      if (sessionCard.term != '') {
        // Add or replace
        await homeRepository.addSessionCard(sessionCard);
      }
    }
    // Delete current Learning Session
    await homeRepository.removeLearningSessionById('local');
  }

  void _handleCardIndexChanges(index) async {
    // print('Index: $index');
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
