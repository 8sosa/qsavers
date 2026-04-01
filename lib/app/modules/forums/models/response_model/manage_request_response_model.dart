import 'package:quantity_savers/app/modules/forums/models/data_model/manage_request_data_model.dart';

class ManageRequestResponseModel {
  ManageRequestDataModel? data;

  ManageRequestResponseModel({this.data});

  ManageRequestResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ManageRequestDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
