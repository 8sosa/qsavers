import 'package:quantity_savers/app/modules/forums/models/data_model/group_members_data_model.dart';

import 'package:quantity_savers/app/modules/forums/models/data_model/group_members_data_model.dart';

import 'package:quantity_savers/app/modules/forums/models/data_model/group_members_data_model.dart';

class GroupMembersResponseModel {
  List<GroupMembersDataModel>? data;

  GroupMembersResponseModel({this.data});

  GroupMembersResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <GroupMembersDataModel>[];
      json['data'].forEach((v) {
        data!.add(GroupMembersDataModel.fromJson(v));
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
