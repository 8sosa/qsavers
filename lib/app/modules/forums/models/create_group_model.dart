import 'package:quantity_savers/app/core/values/app_strings.dart';

class CreateGroupModel {
  List<Map<String, dynamic>> groupPrivacy = [
    {"value": 0, "privacy": strPublicAnyone, "payload": "PUBLIC"},
    {"value": 1, "privacy": strPrivateSpecific, "payload": "PRIVATE"},
  ];
}
