class WishlistDataModel {
  var totalCount;
  List<WishlistDataSubModel>? data;

  WishlistDataModel({
    this.totalCount,
    this.data,
  });

  WishlistDataModel.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    if (json['data'] != null) {
      data = <WishlistDataSubModel>[];
      json['data'].forEach((v) {
        data!.add(WishlistDataSubModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_count'] = totalCount;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WishlistDataSubModel {
  var id;
  ProductId? productId;
  CampaignId? campaignId;
  var userId;
  var createdAt;
  var inWishlist;

  WishlistDataSubModel({
    required this.id,
    required this.productId,
    required this.campaignId,
    required this.userId,
    required this.createdAt,
    required this.inWishlist,
  });

  factory WishlistDataSubModel.fromJson(Map<String, dynamic> json) =>
      WishlistDataSubModel(
        id: json["_id"],
        productId: json["product_id"] == null
            ? null
            : ProductId.fromJson(json["product_id"]),
        campaignId: json["campaign_id"] == null
            ? null
            : CampaignId.fromJson(json["campaign_id"]),
        userId: json["user_id"],
        createdAt: json["created_at"],
        inWishlist: json["in_wishlist"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "product_id": productId?.toJson(),
        "campaign_id": campaignId?.toJson(),
        "user_id": userId,
        "created_at": createdAt,
        "in_wishlist": inWishlist,
      };
}

class GroupId {
  var sId;
  var groupType;
  var groupName;

  GroupId({this.sId, this.groupType, this.groupName});

  GroupId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    groupType = json['group_type'];
    groupName = json['group_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['group_type'] = this.groupType;
    data['group_name'] = this.groupName;
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
  var id;
  var name;
  var description;
  var prodctId;
  List<String> images;
  int quantity;
  var price;
  var discountPercantage;
  var discount;
  var discountPrice;
  var totalReviews;
  var totalRatings;
  var averageRating;
  var sold;

  ProductId({
    required this.id,
    required this.name,
    required this.description,
    required this.prodctId,
    required this.images,
    required this.quantity,
    required this.price,
    required this.discountPercantage,
    required this.discount,
    required this.discountPrice,
    required this.totalReviews,
    required this.totalRatings,
    required this.averageRating,
    required this.sold,
  });

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        prodctId: json["prodct_id"],
        images: List<String>.from(json["images"].map((x) => x)),
        quantity: json["quantity"],
        price: json["price"],
        discountPercantage: json["discount_percantage"],
        discount: json["discount"]?.toDouble(),
        discountPrice: json["discount_price"]?.toDouble(),
        totalReviews: json["total_reviews"],
        totalRatings: json["total_ratings"],
        averageRating: json["average_rating"],
        sold: json["sold"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "prodct_id": prodctId,
        "images": List<dynamic>.from(images.map((x) => x)),
        "quantity": quantity,
        "price": price,
        "discount_percantage": discountPercantage,
        "discount": discount,
        "discount_price": discountPrice,
        "total_reviews": totalReviews,
        "total_ratings": totalRatings,
        "average_rating": averageRating,
        "sold": sold,
      };
}
