import 'package:quantity_savers/app/modules/Details/models/data_models/join_campaign_data_model.dart';

class JoinCampaignResponseModel {
  bool? success;
  String? message;
  JoinCampaignDataModel? data;

  JoinCampaignResponseModel({this.success, this.message, this.data});

  JoinCampaignResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? new JoinCampaignDataModel.fromJson(json['data'])
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
