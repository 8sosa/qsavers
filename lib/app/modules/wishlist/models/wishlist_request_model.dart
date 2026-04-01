class WishlistRequestModel {
  /*=================================================== Get Wishlist Request Model==============================================*/

  static getWishlistRequestModel({
    String? type,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["type"] = type;
    return data;
  }
}
