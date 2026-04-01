import 'package:quantity_savers/app/modules/Details/models/data_models/order_place_data_model.dart';

class OrderDetailsResponceModel {
  bool? success;
  String? message;
  OrderPlaceData? data;

  OrderDetailsResponceModel({this.success, this.message, this.data});

  OrderDetailsResponceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new OrderPlaceData.fromJson(json['data']) : null;
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