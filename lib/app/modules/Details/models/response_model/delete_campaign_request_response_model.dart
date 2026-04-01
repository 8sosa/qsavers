import 'package:quantity_savers/app/modules/Details/models/data_models/delete_campaign_request_data_model.dart';

class DeleteCampaignRequestResponseModel {
  var success;
  var message;
  DeleteCampaignRequestDataModel? data;

  DeleteCampaignRequestResponseModel({this.success, this.message, this.data});

  DeleteCampaignRequestResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? new DeleteCampaignRequestDataModel.fromJson(json['data'])
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
