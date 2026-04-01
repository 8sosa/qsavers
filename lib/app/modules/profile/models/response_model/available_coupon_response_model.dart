import 'package:quantity_savers/app/modules/profile/models/data_models/available_coupon_data_model.dart';

class AvailableCouponResponseModel {
  bool? success;
  String? message;
  int? totalCount;
  List<AvailableCouponDataModel>? data;

  AvailableCouponResponseModel(
      {this.success, this.message, this.totalCount, this.data});

  AvailableCouponResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    totalCount = json['total_count'];
    if (json['data'] != null) {
      data = <AvailableCouponDataModel>[];
      json['data'].forEach((v) {
        data!.add(new AvailableCouponDataModel.fromJson(v));
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