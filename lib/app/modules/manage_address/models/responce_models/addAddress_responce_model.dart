import 'package:quantity_savers/app/modules/manage_address/models/data_models/addAddress_data_model.dart';

class AddAddressResponceModel {
  AddAddressData? data;

  AddAddressResponceModel({this.data});

  AddAddressResponceModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new AddAddressData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}