import 'package:quantity_savers/app/modules/Details/models/data_models/add_to_wishlist_data_model.dart';

class AddToWishlistResponseModel {
  int? totalCount;
  AddToWishlistData? data;

  AddToWishlistResponseModel({this.totalCount, this.data});

  AddToWishlistResponseModel.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    data = json['data'] != null ? new AddToWishlistData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_count'] = this.totalCount;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}