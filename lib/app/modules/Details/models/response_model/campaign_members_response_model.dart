import 'package:quantity_savers/app/modules/Details/models/data_models/campaign_members_group_data_model.dart';

class CampaignGroupMembersResponseModel {
  var success;
  var message;
  List<CampaignGroupMemberDataModel>? data;

  CampaignGroupMembersResponseModel({this.success, this.message, this.data});

  CampaignGroupMembersResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CampaignGroupMemberDataModel>[];
      json['data'].forEach((v) {
        data!.add(new CampaignGroupMemberDataModel.fromJson(v));
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
