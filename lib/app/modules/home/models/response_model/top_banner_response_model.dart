


import '../data_model/top_banner_data_model.dart';

class TopBannerResponseModel {
  var success;
  var message;
  Data? data;

  TopBannerResponseModel({this.success, this.message, this.data});

  TopBannerResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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