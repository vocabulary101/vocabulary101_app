import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

// import 'package:cloud_firestore/cloud_firestore.dart';

class ModelHelpers {
  static Color? colorFromJson(int? colorAsInt) {
    return colorAsInt == null ? null : Color(colorAsInt);
  }

  static int? colorToJson(Color? color) {
    return color?.value;
  }

  static Uint8List uint8ListFromJson(String valueAsString) {
    return base64Decode(valueAsString);
  }

  static String uint8ListToJson(Uint8List value) {
    return base64Encode(value);
  }

  /// Get a Firestore document format ID like: TNdNfX4uxNkqNvU92ZNE
  // static String generateFirestoreID() {
  //   DocumentReference doc = FirebaseFirestore.instance.collection('gen').doc();
  //   return doc.id;
  // }
}
