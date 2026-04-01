class CampaignCustomerDataModel {
  var sId;
  var userId;
  CampaignId? campaignId;
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

  CampaignCustomerDataModel(
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

  CampaignCustomerDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    campaignId = json['campaign_id'] != null
        ? new CampaignId.fromJson(json['campaign_id'])
        : null;
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
    data['user_id'] = this.userId;
    if (this.campaignId != null) {
      data['campaign_id'] = this.campaignId!.toJson();
    }
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

class CampaignId {
  var sId;
  var campaignName;
  var createdBy;
  var quantity;
  var totalQuantity;
  var soldQuantity;
  var sellerId;
  var status;
  ProductId? productId;
  GroupId? groupId;
  var oneProductPrice;
  var totalPrice;
  var userJoined;
  var startDate;
  var endDate;
  var image;
  var video;
  var liveStartDate;
  var liveStartTime;
  var isLive;
  var isLiveEnd;
  var liveTimeInMilisecond;
  var isSchedule;
  var cancelledBy;
  var cancelRequested;
  var isDelete;
  var isMoneyTransfer;
  var description;
  var updatedAt;
  var createdAt;
  var cancelledAt;
  var iV;

  CampaignId(
      {this.sId,
      this.campaignName,
      this.createdBy,
      this.quantity,
      this.totalQuantity,
      this.soldQuantity,
      this.sellerId,
      this.status,
      this.productId,
      this.groupId,
      this.oneProductPrice,
      this.totalPrice,
      this.userJoined,
      this.startDate,
      this.endDate,
      this.image,
      this.video,
      this.liveStartDate,
      this.liveStartTime,
      this.isLive,
      this.isLiveEnd,
      this.liveTimeInMilisecond,
      this.isSchedule,
      this.cancelledBy,
      this.cancelRequested,
      this.isDelete,
      this.isMoneyTransfer,
      this.description,
      this.updatedAt,
      this.createdAt,
      this.cancelledAt,
      this.iV});

  CampaignId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    campaignName = json['campaign_name'];
    createdBy = json['created_by'];
    quantity = json['quantity'];
    totalQuantity = json['total_quantity'];
    soldQuantity = json['sold_quantity'];
    sellerId = json['seller_id'];
    status = json['status'];
    productId = json['product_id'] != null
        ? new ProductId.fromJson(json['product_id'])
        : null;
    groupId = json['group_id'] != null
        ? new GroupId.fromJson(json['group_id'])
        : null;
    oneProductPrice = json['one_product_price'];
    totalPrice = json['total_price'];
    userJoined = json['user_joined'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    image = json['image'];
    video = json['video'];
    liveStartDate = json['live_start_date'];
    liveStartTime = json['live_start_time'];
    isLive = json['is_live'];
    isLiveEnd = json['is_live_end'];
    liveTimeInMilisecond = json['live_time_in_milisecond'];
    isSchedule = json['is_schedule'];
    cancelledBy = json['cancelled_by'];
    cancelRequested = json['cancel_requested'];
    isDelete = json['is_delete'];
    isMoneyTransfer = json['is_money_transfer'];
    description = json['description'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    cancelledAt = json['cancelled_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['campaign_name'] = this.campaignName;
    data['created_by'] = this.createdBy;
    data['quantity'] = this.quantity;
    data['total_quantity'] = this.totalQuantity;
    data['sold_quantity'] = this.soldQuantity;
    data['seller_id'] = this.sellerId;
    data['status'] = this.status;
    if (this.productId != null) {
      data['product_id'] = this.productId!.toJson();
    }
    if (this.groupId != null) {
      data['group_id'] = this.groupId!.toJson();
    }
    data['one_product_price'] = this.oneProductPrice;
    data['total_price'] = this.totalPrice;
    data['user_joined'] = this.userJoined;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['image'] = this.image;
    data['video'] = this.video;
    data['live_start_date'] = this.liveStartDate;
    data['live_start_time'] = this.liveStartTime;
    data['is_live'] = this.isLive;
    data['is_live_end'] = this.isLiveEnd;
    data['live_time_in_milisecond'] = this.liveTimeInMilisecond;
    data['is_schedule'] = this.isSchedule;
    data['cancelled_by'] = this.cancelledBy;
    data['cancel_requested'] = this.cancelRequested;
    data['is_delete'] = this.isDelete;
    data['is_money_transfer'] = this.isMoneyTransfer;
    data['description'] = this.description;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['cancelled_at'] = this.cancelledAt;
    data['__v'] = this.iV;
    return data;
  }
}

class ProductId {
  var sId;
  var name;
  var prodctId;
  List<String>? images;

  ProductId({this.sId, this.name, this.prodctId, this.images});

  ProductId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    prodctId = json['prodct_id'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['prodct_id'] = this.prodctId;
    data['images'] = this.images;
    return data;
  }
}

class GroupId {
  var sId;

  GroupId({this.sId});

  GroupId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
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
