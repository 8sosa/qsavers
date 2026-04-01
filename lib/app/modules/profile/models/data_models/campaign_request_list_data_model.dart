import 'package:quantity_savers/app/modules/Details/models/data_models/product_details_data_model.dart';

class CampaignRequestListDataModel {
  var sId;
  var createdBy;
  var sellerId;
  var status;
  ProductDetailsDataModel? productId;
  var image;
  var video;
  var description;
  var updatedAt;
  var createdAt;

  CampaignRequestListDataModel(
      {this.sId,
      this.createdBy,
      this.sellerId,
      this.status,
      this.productId,
      this.image,
      this.video,
      this.description,
      this.updatedAt,
      this.createdAt});

  CampaignRequestListDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    createdBy = json['created_by'];
    sellerId = json['seller_id'];
    status = json['status'];
    productId = json['product_id'] != null
        ? new ProductDetailsDataModel.fromJson(json['product_id'])
        : null;
    image = json['image'];
    video = json['video'];
    description = json['description'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['created_by'] = this.createdBy;
    data['seller_id'] = this.sellerId;
    data['status'] = this.status;
    if (this.productId != null) {
      data['product_id'] = this.productId!.toJson();
    }
    data['image'] = this.image;
    data['video'] = this.video;
    data['description'] = this.description;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}