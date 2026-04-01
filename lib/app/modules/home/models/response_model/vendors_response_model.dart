import 'package:quantity_savers/app/modules/home/models/data_model/vendors_data_model.dart';

class VendorsResponseModel {
  var success;
  var message;
  VendorsDataModel? data;

  VendorsResponseModel({this.success, this.message, this.data});

  VendorsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data =
        json['data'] != null ? VendorsDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
