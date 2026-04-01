import 'package:quantity_savers/app/modules/home/models/data_model/corresponding_products_data_model.dart';

class VendorsProductsResponseModel {
  VendorsProductsDataModel? data;

  VendorsProductsResponseModel({this.data});

  VendorsProductsResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? VendorsProductsDataModel.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
