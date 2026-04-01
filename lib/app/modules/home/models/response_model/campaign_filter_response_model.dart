import 'package:quantity_savers/app/modules/home/models/data_model/campaign_filter_data_model.dart';

class CampaignFilterResponseModel {
  bool? success;
  String? message;
  CampaignFilterDataModel? data;

  CampaignFilterResponseModel({this.success, this.message, this.data});

  CampaignFilterResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new CampaignFilterDataModel.fromJson(json['data']) : null;
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