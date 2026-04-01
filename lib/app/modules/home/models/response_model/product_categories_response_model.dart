import 'package:quantity_savers/app/modules/home/models/data_model/product_categories_data_model.dart';

class ProductCategoriesResponseModel {
  ProductCategoriesDataModel? data;

  ProductCategoriesResponseModel({this.data});

  ProductCategoriesResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? ProductCategoriesDataModel.fromJson(json['data'])
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
