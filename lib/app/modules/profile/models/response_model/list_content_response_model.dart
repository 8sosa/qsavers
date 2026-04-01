import '../data_models/list_content_data_model.dart';

class ListContentResponseModel {
  List<ListContentDataModel>? data;

  ListContentResponseModel({this.data});

  ListContentResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ListContentDataModel>[];
      json['data'].forEach((v) {
        data!.add(ListContentDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    if(this.data != null){
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
