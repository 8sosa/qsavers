class Data {
  List<Datum>? data;
  var count;

  Data({this.data, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Datum>[];
      json['data'].forEach((v) {
        data!.add(new Datum.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class Datum {
  var sId;
  var campaignName;
  var createdBy;
  var quantity;
  var totalQuantity;
  var soldQuantity;
  var sellerId;
  var status;
  var productId;
  var groupId;
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
  var wishlist;

  Datum(
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
        this.wishlist});

  Datum.fromJson(Map<String, dynamic> json) {
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
    groupId = json['group_id'];
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
    wishlist = json['wishlist'];
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
    data['group_id'] = this.groupId;
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
    data['wishlist'] = this.wishlist;
    return data;
  }
}

class ProductId {
  var sId;
  var name;
  var images;
  var totalReviews;
  var totalRatings;
  var averageRating;

  ProductId(
      {this.sId,
        this.name,
        this.images,
        this.totalReviews,
        this.totalRatings,
        this.averageRating});

  ProductId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    images = json['images'].cast<String>();
    totalReviews = json['total_reviews'];
    totalRatings = json['total_ratings'];
    averageRating = json['average_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['images'] = this.images;
    data['total_reviews'] = this.totalReviews;
    data['total_ratings'] = this.totalRatings;
    data['average_rating'] = this.averageRating;
    return data;
  }
}