import 'package:quantity_savers/app/modules/forums/models/data_model/join_public_data_model.dart';

class JoinPublicGroupResponseModel {
  JoinPublicGroupDataModel? data;

  JoinPublicGroupResponseModel({this.data});

  JoinPublicGroupResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new JoinPublicGroupDataModel.fromJson(json['data'])
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
