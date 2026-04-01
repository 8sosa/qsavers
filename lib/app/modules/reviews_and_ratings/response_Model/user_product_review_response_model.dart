import 'package:quantity_savers/app/modules/reviews_and_ratings/data_model/user_product_data_model.dart';

class UserProductReviewResponseModel {
  String? message;
  UserProductReviewData? data;

  UserProductReviewResponseModel({this.message, this.data});

  UserProductReviewResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new UserProductReviewData.fromJson(json['data']) : null;
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