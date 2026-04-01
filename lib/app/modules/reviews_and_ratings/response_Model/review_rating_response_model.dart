import 'package:quantity_savers/app/modules/reviews_and_ratings/data_model/review_rating_data_model.dart';

class ReviewRatingResponseModel {
  String? message;
  ReviewRatingDataModel? data;

  ReviewRatingResponseModel({this.message, this.data});

  ReviewRatingResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new ReviewRatingDataModel.fromJson(json['data']) : null;
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