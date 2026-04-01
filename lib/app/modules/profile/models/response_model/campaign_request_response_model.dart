import 'package:quantity_savers/app/modules/profile/models/data_models/campaign_request_data_model.dart';

class CampaignRequestResponseModel {
  var success;
  var message;
  CampaignRequestDataModel? data;

  CampaignRequestResponseModel({this.success, this.message, this.data});

  CampaignRequestResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? new CampaignRequestDataModel.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
