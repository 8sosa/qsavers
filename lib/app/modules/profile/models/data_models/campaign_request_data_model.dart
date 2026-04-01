class CampaignRequestDataModel {
  var createdBy;
  var sellerId;
  var status;
  var productId;
  var image;
  var video;
  var description;
  var updatedAt;
  var createdAt;
  var sId;
  var iV;

  CampaignRequestDataModel(
      {this.createdBy,
      this.sellerId,
      this.status,
      this.productId,
      this.image,
      this.video,
      this.description,
      this.updatedAt,
      this.createdAt,
      this.sId,
      this.iV});

  CampaignRequestDataModel.fromJson(Map<String, dynamic> json) {
    createdBy = json['created_by'];
    sellerId = json['seller_id'];
    status = json['status'];
    productId = json['product_id'];
    image = json['image'];
    video = json['video'];
    description = json['description'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_by'] = this.createdBy;
    data['seller_id'] = this.sellerId;
    data['status'] = this.status;
    data['product_id'] = this.productId;
    data['image'] = this.image;
    data['video'] = this.video;
    data['description'] = this.description;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}
