import 'package:quantity_savers/app/modules/Details/models/data_models/edit_campaign_data_model.dart';

class EditCampaignResponseModel {
  var success;
  var message;
  EditCampaignDataModel? data;

  EditCampaignResponseModel({this.success, this.message, this.data});

  EditCampaignResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? new EditCampaignDataModel.fromJson(json['data'])
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
