import 'package:quantity_savers/app/modules/Details/models/data_models/related_product_data_model.dart';

class RelatedProductResponseModel {
  RelatedProductDataModel? data;

  RelatedProductResponseModel({this.data});

  RelatedProductResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? RelatedProductDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
