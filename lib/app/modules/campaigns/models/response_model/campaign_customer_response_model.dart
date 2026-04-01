import 'package:quantity_savers/app/modules/campaigns/models/data_model/campaign_customer_data_model.dart';

class CampaignCustomerResponseModel {
  bool? success;
  String? message;
  List<CampaignCustomerDataModel>? data;
  int? count;

  CampaignCustomerResponseModel(
      {this.success, this.message, this.data, this.count});

  CampaignCustomerResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CampaignCustomerDataModel>[];
      json['data'].forEach((v) {
        data!.add(new CampaignCustomerDataModel.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}
