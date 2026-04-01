import 'package:quantity_savers/app/modules/Details/models/data_models/start_campaign_data_model.dart';

class StartCampaignResponseModel {
  bool? success;
  String? message;
  StartCampaignDataModel? data;

  StartCampaignResponseModel({this.success, this.message, this.data});

  StartCampaignResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? new StartCampaignDataModel.fromJson(json['data'])
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


class UserGroupListResponceModel {
  List<UserGroupListData>? data;

  UserGroupListResponceModel({this.data});

  UserGroupListResponceModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <UserGroupListData>[];
      json['data'].forEach((v) {
        data!.add(new UserGroupListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}