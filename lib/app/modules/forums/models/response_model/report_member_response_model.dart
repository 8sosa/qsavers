import 'package:quantity_savers/app/modules/forums/models/data_model/report_member_data_model.dart';

class ReportMemberResponseModel {
  bool? success;
  String? message;
  ReportMemberDataModel? data;

  ReportMemberResponseModel({this.success, this.message, this.data});

  ReportMemberResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new ReportMemberDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}