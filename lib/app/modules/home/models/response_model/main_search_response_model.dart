import 'package:quantity_savers/app/modules/home/models/data_model/main_search_data_model.dart';

class MainSearchResponseModel {
  bool? success;
  String? message;
  List<MainSearchDataModel>? data;

  MainSearchResponseModel({this.success, this.message, this.data});

  MainSearchResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MainSearchDataModel>[];
      json['data'].forEach((v) {
        data!.add(MainSearchDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
