import 'package:quantity_savers/app/modules/profile/models/data_models/profile_faq_data_model.dart';

class ProfileFaqResponseModel {
  ProfileFaqDataModel? data;

  ProfileFaqResponseModel({this.data});

  ProfileFaqResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new ProfileFaqDataModel.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
