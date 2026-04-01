class JoinCampaignDataModel {
  var userId;
  var campaignId;
  var totalPrice;
  var totalQuantity;
  var updatedAt;
  var exitedAt;
  var createdAt;
  var status;
  var isComplete;
  var isCancelled;
  var isFailed;
  var sId;
  var products;
  var iV;

  JoinCampaignDataModel(
      {this.userId,
      this.campaignId,
      this.totalPrice,
      this.totalQuantity,
      this.updatedAt,
      this.exitedAt,
      this.createdAt,
      this.status,
      this.isComplete,
      this.isCancelled,
      this.isFailed,
      this.sId,
      this.products,
      this.iV});

  JoinCampaignDataModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    campaignId = json['campaign_id'];
    totalPrice = json['total_price'];
    totalQuantity = json['total_quantity'];
    updatedAt = json['updated_at'];
    exitedAt = json['exited_at'];
    createdAt = json['created_at'];
    status = json['status'];
    isComplete = json['is_complete'];
    isCancelled = json['is_cancelled'];
    isFailed = json['is_failed'];
    sId = json['_id'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['campaign_id'] = this.campaignId;
    data['total_price'] = this.totalPrice;
    data['total_quantity'] = this.totalQuantity;
    data['updated_at'] = this.updatedAt;
    data['exited_at'] = this.exitedAt;
    data['created_at'] = this.createdAt;
    data['status'] = this.status;
    data['is_complete'] = this.isComplete;
    data['is_cancelled'] = this.isCancelled;
    data['is_failed'] = this.isFailed;
    data['_id'] = this.sId;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class Products {
  String? productId;
  var quantity;
  String? sId;

  Products({this.productId, this.quantity, this.sId});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['_id'] = this.sId;
    return data;
  }
}
