import 'package:quantity_savers/app/modules/forums/models/data_model/forum_sent_request_data_model.dart';

class ForumRequestResponseModel {
  List<ForumRequestDataModel>? data;

  ForumRequestResponseModel({this.data});

  ForumRequestResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ForumRequestDataModel>[];
      json['data'].forEach((v) {
        data!.add(new ForumRequestDataModel.fromJson(v));
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
