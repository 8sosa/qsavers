import 'package:quantity_savers/app/export.dart';
// import 'package:quantity_savers/app/modules/authentication/models/dataModel/social_login_data_model.dart';

class SocialLogInResponseModel {
  LoginDataModel? data;

  SocialLogInResponseModel({this.data});

  SocialLogInResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new LoginDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}