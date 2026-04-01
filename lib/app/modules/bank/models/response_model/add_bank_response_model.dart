import 'package:quantity_savers/app/modules/bank/models/data_model/add_bank_data_model.dart';

class AddBankResponseModel {
  bool? success;
  String? message;
  AddBankDataModel? data;

  AddBankResponseModel({this.success, this.message, this.data});

  AddBankResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? new AddBankDataModel.fromJson(json['data'])
        : null;
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
