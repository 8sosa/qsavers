class AgoraTokenRequestModel {
  bool? success;
  String? message;
  Data? data;

  AgoraTokenRequestModel({this.success, this.message, this.data});

  AgoraTokenRequestModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? channelName;
  String? token;
  CampaignDetail? campaignDetail;

  Data({this.channelName, this.token, this.campaignDetail});

  Data.fromJson(Map<String, dynamic> json) {
    channelName = json['channel_name'];
    token = json['token'];
    campaignDetail = json['campaign_detail'] != null
        ? new CampaignDetail.fromJson(json['campaign_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['channel_name'] = this.channelName;
    data['token'] = this.token;
    if (this.campaignDetail != null) {
      data['campaign_detail'] = this.campaignDetail!.toJson();
    }
    return data;
  }
}

class CampaignDetail {
  String? sId;
  String? campaignName;
  CreatedBy? createdBy;
  ProductId? productId;
  bool? isLive;

  CampaignDetail(
      {this.sId,
        this.campaignName,
        this.createdBy,
        this.productId,
        this.isLive});

  CampaignDetail.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    campaignName = json['campaign_name'];
    createdBy = json['created_by'] != null
        ? new CreatedBy.fromJson(json['created_by'])
        : null;
    productId = json['product_id'] != null
        ? new ProductId.fromJson(json['product_id'])
        : null;
    isLive = json['is_live'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['campaign_name'] = this.campaignName;
    if (this.createdBy != null) {
      data['created_by'] = this.createdBy!.toJson();
    }
    if (this.productId != null) {
      data['product_id'] = this.productId!.toJson();
    }
    data['is_live'] = this.isLive;
    return data;
  }
}

class CreatedBy {
  String? sId;
  String? profilePic;
  String? name;

  CreatedBy({this.sId, this.profilePic, this.name});

  CreatedBy.fromJson(Map<String, dynamic> json) {
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

class ProductId {
  String? sId;
  List<String>? images;

  ProductId({this.sId, this.images});

  ProductId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['images'] = this.images;
    return data;
  }
}

