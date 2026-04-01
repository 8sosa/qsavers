import 'package:quantity_savers/app/modules/Details/models/data_models/joined_campaign_data_model.dart';

class JoinedCampaignDetailResponseModel {
  bool? success;
  String? message;
  JoinedCampaignData? data;

  JoinedCampaignDetailResponseModel({this.success, this.message, this.data});

  JoinedCampaignDetailResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new JoinedCampaignData.fromJson(json['data']) : null;
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
