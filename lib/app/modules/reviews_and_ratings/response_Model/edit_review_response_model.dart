import 'package:quantity_savers/app/modules/reviews_and_ratings/data_model/edit_review_data_model.dart';

class EditReviewResponseModel {
  String? message;
  EditReviewDataModel? data;

  EditReviewResponseModel({this.message, this.data});

  EditReviewResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new EditReviewDataModel.fromJson(json['data']) : null;
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