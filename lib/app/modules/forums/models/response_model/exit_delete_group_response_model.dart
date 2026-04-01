import 'package:quantity_savers/app/modules/forums/models/data_model/exit_delete_group_data_model.dart';

class ExitDeleteGroupResponseModel {
  List<ExitDeleteGroupDataModel>? data;

  ExitDeleteGroupResponseModel({this.data});

  ExitDeleteGroupResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ExitDeleteGroupDataModel>[];
      json['data'].forEach((v) {
        data!.add(new ExitDeleteGroupDataModel.fromJson(v));
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
