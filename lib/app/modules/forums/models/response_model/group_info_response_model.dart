import 'package:quantity_savers/app/modules/forums/models/data_model/group_info_data_model.dart';

class GroupInfoResponseModel {
  GroupInfoDataModel? data;

  GroupInfoResponseModel({this.data});

  GroupInfoResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new GroupInfoDataModel.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
