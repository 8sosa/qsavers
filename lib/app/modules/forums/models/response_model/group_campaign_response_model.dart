import 'package:quantity_savers/app/modules/forums/models/data_model/group_campaign_data_model.dart';

class GroupCampaignResponseModel {
  GroupCampaignDataModel? data;

  GroupCampaignResponseModel({this.data});

  GroupCampaignResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new GroupCampaignDataModel.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
