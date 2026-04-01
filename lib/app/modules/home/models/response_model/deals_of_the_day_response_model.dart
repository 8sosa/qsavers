import 'package:quantity_savers/app/modules/home/models/data_model/deals_of_the_day_data_model.dart';

class DealsOfTheDayResponseModel {
  bool? success;
  String? message;
  DealsOfTheDayDataModel? data;

  DealsOfTheDayResponseModel({this.success, this.message, this.data});

  DealsOfTheDayResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? DealsOfTheDayDataModel.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
