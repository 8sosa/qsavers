import 'package:quantity_savers/app/modules/payment/models/data_models/add_payment_method_data_model.dart';

class AddPaymentMethodResponce {
  bool? success;
  String? message;
  AddPaymentMethodData? data;

  AddPaymentMethodResponce({this.success, this.message, this.data});

  AddPaymentMethodResponce.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new AddPaymentMethodData.fromJson(json['data']) : null;
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