import 'package:quantity_savers/app/modules/forums/models/data_model/forum_request_members_data_model.dart';

class RequestStatusResponseModel {
  ForumRequestMembersDataModel? data;

  RequestStatusResponseModel({this.data});

  RequestStatusResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new ForumRequestMembersDataModel.fromJson(json['data'])
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
