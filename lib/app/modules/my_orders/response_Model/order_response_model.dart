import 'package:quantity_savers/app/modules/my_orders/data_model/order_data_model.dart';

class OrderResponseModel {
  bool? success;
  String? message;
  int? totalCount;
  int? confirmCount;
  int? deliveredCount;
  int? cancelCount;
  List<OrderDataModel>? data;

  OrderResponseModel({this.success, this.message, this.totalCount, this.data});

  OrderResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    totalCount = json['total_count'];
    confirmCount=json['confirm_count'];
    deliveredCount=json['deliverd_count'];
    cancelCount=json['cancel_count'];

    if (json['data'] != null) {
      data = <OrderDataModel>[];
      json['data'].forEach((v) {
        data!.add(new OrderDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['total_count'] = this.totalCount;
    data['confirm_count'] = this.confirmCount;
    data['deliverd_count'] = this.deliveredCount;
    data['cancel_count'] = this.cancelCount;

    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}