import 'package:quantity_savers/app/modules/bank/models/data_model/delete_bank_data_model.dart';

class DeleteBankResponseModel {
  bool? success;
  String? message;
  List<DeleteBankDataModel>? data;

  DeleteBankResponseModel({this.success, this.message, this.data});

  DeleteBankResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DeleteBankDataModel>[];
      json['data'].forEach((v) {
        data!.add(DeleteBankDataModel.fromJson(v));
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