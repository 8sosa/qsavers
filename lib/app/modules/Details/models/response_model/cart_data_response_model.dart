import 'package:quantity_savers/app/modules/Details/models/data_models/cartdata_data_model.dart';

class CartDataResponseModel {
  bool? success;
  String? message;
  CartData? data;

  CartDataResponseModel({this.success, this.message, this.data});

  CartDataResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new CartData.fromJson(json['data']) : null;
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

class PriceDetailsResponseModel {
  var success;
  var message;
  PriceDetailsData? data;

  PriceDetailsResponseModel({this.success, this.message, this.data});

  PriceDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data =
        json['data'] != null ? PriceDetailsData.fromJson(json['data']) : null;
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
