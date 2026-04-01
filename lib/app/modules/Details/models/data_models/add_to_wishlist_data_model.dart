class AddToWishlistData {
  String? sId;
  String? productId;
  String? campaignId;
  String? userId;
  String? createdAt;
  bool? inWishlist;

  AddToWishlistData(
      {this.sId,
        this.productId,
        this.campaignId,
        this.userId,
        this.createdAt,
        this.inWishlist});

  AddToWishlistData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productId = json['product_id'];
    campaignId = json['campaign_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    inWishlist = json['in_wishlist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['product_id'] = this.productId;
    data['campaign_id'] = this.campaignId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['in_wishlist'] = this.inWishlist;
    return data;
  }
}