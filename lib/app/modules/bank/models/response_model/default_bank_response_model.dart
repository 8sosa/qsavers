import 'package:quantity_savers/app/modules/bank/models/data_model/default_bank_data_model.dart';

class DefaultBankResponseModel {
  bool? success;
  String? message;
  DefaultBankDataModel? data;

  DefaultBankResponseModel({this.success, this.message, this.data});

  DefaultBankResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? DefaultBankDataModel.fromJson(json['data']) : null;
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