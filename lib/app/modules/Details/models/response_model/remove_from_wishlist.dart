import '../data_models/remove_from_wishlist_data_model.dart';

class RemoveFromWishlistResponse {
  RemoveFromWishlistData? data;

  RemoveFromWishlistResponse({this.data});

  RemoveFromWishlistResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? RemoveFromWishlistData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

