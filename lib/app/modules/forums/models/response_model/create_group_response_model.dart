import 'package:quantity_savers/app/modules/forums/models/data_model/create_group_data_model.dart';

class CreateGroupResponseModel {
  CreateGroupDataModel? data;

  CreateGroupResponseModel({this.data});

  CreateGroupResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new CreateGroupDataModel.fromJson(json['data'])
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
