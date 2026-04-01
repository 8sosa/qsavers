import 'package:quantity_savers/app/modules/forums/models/data_model/forum_request_members_data_model.dart';

class ForumRequestMembersResponseModel {
  List<ForumRequestMembersDataModel>? data;

  ForumRequestMembersResponseModel({this.data});

  ForumRequestMembersResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ForumRequestMembersDataModel>[];
      json['data'].forEach((v) {
        data!.add(new ForumRequestMembersDataModel.fromJson(v));
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
