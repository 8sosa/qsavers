import '../data_models/apply_coupon_data_model.dart';

class ApplyCouponResponseModel {
  bool? success;
  String? message;
  ApplyCouponDataModel? data;

  ApplyCouponResponseModel({this.success, this.message, this.data});

  ApplyCouponResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new ApplyCouponDataModel.fromJson(json['data']) : null;
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