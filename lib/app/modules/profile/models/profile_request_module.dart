import 'package:quantity_savers/app/core/values/app_strings.dart';

class ProfileRequestModel {
  static Future editProfileRequestModel({
    String? email,
    required String? name,
    required String? countryCode,
    required int? phoneNo,
    var profile_pic,
    required String? about,
    required String? language,
  }) async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["email"] = email;
    data["name"] = name;
    data["profile_pic"] = profile_pic;
    data["country_code"] = countryCode;
    data["phone_no"] = phoneNo;
    data["language"] = language;
    data["about"] = about;
    return data;
  }

  static Map<String, dynamic> termsConditionsPrivacyRequestModel(
      {required String? type}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["type"] = type;
    return data;
  }

  /*=================================================== Campaign Details Request Model==============================================*/

  static campaignDetailsRequestModel({
    String? id,
    String? language,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["language"] = strLanguageEnglish;
    return data;
  }

  /*=================================================== Campaign Earning Request Model==============================================*/

  static campaignEarningRequestModel({
    String? language,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["language"] = strLanguageEnglish;
    return data;
  }

}
