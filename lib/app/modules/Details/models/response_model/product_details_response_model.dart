import 'package:quantity_savers/app/modules/Details/models/data_models/product_details_data_model.dart';

class ProductDetailsResponseModel {
  ProductDetailsDataModel? data;

  ProductDetailsResponseModel({this.data});

  ProductDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? ProductDetailsDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}