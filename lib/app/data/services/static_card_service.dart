import 'package:vocabulary101_app/app/data/models/static_card.dart';

abstract class StaticCardService {
  ///
  Future<void> initProvider();

  ///
  Future<StaticCard?> byId(String id);
}
