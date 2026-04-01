import 'package:quantity_savers/app/modules/Details/models/data_models/campaign_details_data_model.dart';

class CampaignDetailsResponseModel {
  var success;
  var message;
  CampaignDetailsDataModel? data;

  CampaignDetailsResponseModel({this.success, this.message, this.data});

  CampaignDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? new CampaignDetailsDataModel.fromJson(json['data'])
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
