import 'package:quantity_savers/app/modules/profile/models/data_models/campaign_request_list_data_model.dart';

class CampaignRequestListResponseModel {
  var success;
  var message;
  List<CampaignRequestListDataModel>? data;

  CampaignRequestListResponseModel({this.success, this.message, this.data});

  CampaignRequestListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CampaignRequestListDataModel>[];
      json['data'].forEach((v) {
        data!.add(new CampaignRequestListDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
