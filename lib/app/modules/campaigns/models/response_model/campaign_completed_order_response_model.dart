import 'package:quantity_savers/app/modules/campaigns/models/data_model/campaign_completed_order_data_model.dart';

class CampaignCompletedOrderResponseModel {
  bool? success;
  String? message;
  CampaignCompletedOrderDataModel? data;

  CampaignCompletedOrderResponseModel({this.success, this.message, this.data});

  CampaignCompletedOrderResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new CampaignCompletedOrderDataModel.fromJson(json['data']) : null;
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