import 'package:quantity_savers/app/modules/forums/models/data_model/search_group_data_model.dart';

class SearchGroupResponseModel {
  List<SearchGroupDataModel>? data;

  SearchGroupResponseModel({this.data});

  SearchGroupResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SearchGroupDataModel>[];
      json['data'].forEach((v) {
        data!.add(new SearchGroupDataModel.fromJson(v));
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
