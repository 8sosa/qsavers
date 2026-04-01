import 'package:quantity_savers/app/modules/forums/models/data_model/group_list_data_model.dart';

class GroupListResponseModel {
  List<GroupListDataModel>? data;

  GroupListResponseModel({this.data});

  GroupListResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <GroupListDataModel>[];
      json['data'].forEach((v) {
        data!.add(new GroupListDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
