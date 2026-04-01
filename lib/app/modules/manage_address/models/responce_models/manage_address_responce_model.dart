import 'package:quantity_savers/app/modules/manage_address/models/data_models/manage_address_data_model.dart';

class ManageAddressResponseModel {
  ManageAddressData? data;

  ManageAddressResponseModel({this.data});

  ManageAddressResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ManageAddressData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
