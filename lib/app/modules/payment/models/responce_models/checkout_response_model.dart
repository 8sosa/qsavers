import 'package:quantity_savers/app/modules/payment/models/data_models/checkout_data_model.dart';

class CheckOutResponceModel {
  bool? success;
  String? message;
  List<CheckoutData>? data;

  CheckOutResponceModel({this.success, this.message, this.data});

  CheckOutResponceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CheckoutData>[];
      json['data'].forEach((v) {
        data!.add(new CheckoutData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}