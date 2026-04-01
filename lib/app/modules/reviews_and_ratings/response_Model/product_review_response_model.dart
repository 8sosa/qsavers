import 'package:quantity_savers/app/modules/reviews_and_ratings/data_model/product_review_data_model.dart';

class ProductReviewResponseModel {
  String? message;
  ProductReviewDataModel? data;

  ProductReviewResponseModel({this.message, this.data});

  ProductReviewResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? ProductReviewDataModel.fromJson(json['data']) : null;
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