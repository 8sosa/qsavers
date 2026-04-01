import 'package:quantity_savers/app/modules/Details/models/data_models/product_campaigns_data_model.dart';

class ProductCampaignsResponseModel {
  bool? success;
  String? message;
  List<ProductCampaignsDataModel>? data;
  int? count;

  ProductCampaignsResponseModel(
      {this.success, this.message, this.data, this.count});

  ProductCampaignsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ProductCampaignsDataModel>[];
      json['data'].forEach((v) {
        data!.add(new ProductCampaignsDataModel.fromJson(v));
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
