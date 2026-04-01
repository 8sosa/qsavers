import 'package:quantity_savers/app/modules/Details/models/data_models/can_review_data_model.dart';

import 'package:quantity_savers/app/modules/Details/models/data_models/can_review_data_model.dart';

class CanReviewResponseModel {
  String? message;

  CanReviewDataModel? data;

  CanReviewResponseModel({this.message, this.data});

  CanReviewResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null
        ? new CanReviewDataModel.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
