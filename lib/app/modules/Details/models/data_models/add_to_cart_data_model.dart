class AddToCartData {
  String? userId;
  String? productId;
  int? quantity;
  String? updatedAt;
  String? createdAt;
  String? sId;
  int? iV;

  AddToCartData(
      {this.userId,
        this.productId,
        this.quantity,
        this.updatedAt,
        this.createdAt,
        this.sId,
        this.iV});

  AddToCartData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}