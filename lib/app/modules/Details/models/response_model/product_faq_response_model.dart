import 'package:quantity_savers/app/modules/Details/models/data_models/product_faq_data_model.dart';

class ProductFaqResponseModel {
  var success;
  var message;
  var totalCount;
  List<ProductFaqDataModel>? data;

  ProductFaqResponseModel(
      {this.success, this.message, this.totalCount, this.data});

  ProductFaqResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    totalCount = json['total_count'];
    if (json['data'] != null) {
      data = <ProductFaqDataModel>[];
      json['data'].forEach((v) {
        data!.add(new ProductFaqDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['total_count'] = this.totalCount;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
