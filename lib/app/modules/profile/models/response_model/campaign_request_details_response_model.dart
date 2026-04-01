import 'package:quantity_savers/app/modules/profile/models/data_models/campaign_request_details_data_model.dart';

class CampaignRequestDetailsResponseModel {
  var success;
  var message;
  CampaignRequestDetailsDataModel? data;

  CampaignRequestDetailsResponseModel({this.success, this.message, this.data});

  CampaignRequestDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? new CampaignRequestDetailsDataModel.fromJson(json['data'])
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
