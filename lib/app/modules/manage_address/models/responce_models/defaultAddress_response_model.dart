import 'package:quantity_savers/app/modules/manage_address/models/data_models/defaultAddress_data_model.dart';

class DefaultAddressResponseModel {
  DefaultAddressDataModel? data;

  DefaultAddressResponseModel({this.data});

 DefaultAddressResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DefaultAddressDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}