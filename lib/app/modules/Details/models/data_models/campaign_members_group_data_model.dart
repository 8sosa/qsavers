class CampaignGroupMemberDataModel {
  var sId;
  UserId? userId;
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
  List<Products>? products;

  CampaignGroupMemberDataModel(
      {this.sId,
      this.userId,
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
      this.products});

  CampaignGroupMemberDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId =
        json['user_id'] != null ? new UserId.fromJson(json['user_id']) : null;
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
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.userId != null) {
      data['user_id'] = this.userId!.toJson();
    }
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
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserId {
  var sId;
  var profilePic;
  var name;

  UserId({this.sId, this.profilePic, this.name});

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profilePic = json['profile_pic'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['profile_pic'] = this.profilePic;
    data['name'] = this.name;
    return data;
  }
}

class Products {
  var productId;
  var quantity;
  var sId;

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
