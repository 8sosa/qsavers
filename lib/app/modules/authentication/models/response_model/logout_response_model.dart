
import "../../../../export.dart";

class LogoutResponseModel {
  LogoutDataModel? data;

  LogoutResponseModel({this.data});

  LogoutResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? LogoutDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
