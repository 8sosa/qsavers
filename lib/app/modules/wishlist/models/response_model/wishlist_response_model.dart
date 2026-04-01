import '../data_models/wishlist_data_model.dart';

class WishlistResponseModel {
  WishlistDataModel? data;

  WishlistResponseModel({
    this.data,
  });

  WishlistResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? WishlistDataModel.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}