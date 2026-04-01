
class OrderPlaceData {
  var sId;
  var productOrderId;
  var sku;
  OrderId? orderId;
  var userId;
  var sellerId;
  ProductId? productId;
  AddressId? addressId;
  var quantity;
  var price;
  var deliveryPrice;
  var couponDiscount;
  var totalPrice;
  var totalEarnings;
  var shippoData;
  var orderStatus;
  var paymentStatus;
  var trackingLink;
  var stripeData;
  List<Reviews>? reviews;
  bool? cancelRequested;
  bool? cancelRequestAccepted;
  var cancellationReason;
  var deliveryDate;
  var shippedAt;
  var cancelledAt;
  var updatedAt;
  var createdAt;
  List<OtherOrderItems>? otherOrderItems;

  OrderPlaceData(
      {this.sId,
        this.productOrderId,
        this.sku,
        this.orderId,
        this.userId,
        this.sellerId,
        this.productId,
        this.addressId,
        this.quantity,
        this.price,
        this.deliveryPrice,
        this.couponDiscount,
        this.totalPrice,
        this.totalEarnings,
        this.shippoData,
        this.orderStatus,
        this.paymentStatus,
        this.trackingLink,
        this.stripeData,
        this.reviews,
        this.cancelRequested,
        this.cancelRequestAccepted,
        this.cancellationReason,
        this.deliveryDate,
        this.shippedAt,
        this.cancelledAt,
        this.updatedAt,
        this.createdAt,
        this.otherOrderItems});

  OrderPlaceData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productOrderId = json['productOrderId'];
    sku = json['sku'];
    orderId = json['order_id'] != null
        ? new OrderId.fromJson(json['order_id'])
        : null;
    userId = json['user_id'];
    sellerId = json['seller_id'];
    productId = json['product_id'] != null
        ? new ProductId.fromJson(json['product_id'])
        : null;
    addressId = json['address_id'] != null
        ? new AddressId.fromJson(json['address_id'])
        : null;
    quantity = json['quantity'];
    price = json['price'];
    deliveryPrice = json['delivery_price'];
    couponDiscount = json['coupon_discount'];
    totalPrice = json['total_price'];
    totalEarnings = json['total_earnings'];
    shippoData = json['shippo_data'];
    orderStatus = json['order_status'];
    paymentStatus = json['payment_status'];
    trackingLink = json['tracking_link'];
    stripeData = json['stripe_data'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
    cancelRequested = json['cancel_requested'];
    cancelRequestAccepted = json['cancel_request_accepted'];
    cancellationReason = json['cancellation_reason'];
    deliveryDate = json['delivery_date'];
    shippedAt = json['shipped_at'];
    cancelledAt = json['cancelled_at'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    if (json['other_order_items'] != null) {
      otherOrderItems = <OtherOrderItems>[];
      json['other_order_items'].forEach((v) {
        otherOrderItems!.add(new OtherOrderItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['productOrderId'] = this.productOrderId;
    data['sku'] = this.sku;
    if (this.orderId != null) {
      data['order_id'] = this.orderId!.toJson();
    }
    data['user_id'] = this.userId;
    data['seller_id'] = this.sellerId;
    if (this.productId != null) {
      data['product_id'] = this.productId!.toJson();
    }
    if (this.addressId != null) {
      data['address_id'] = this.addressId!.toJson();
    }
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['delivery_price'] = this.deliveryPrice;
    data['coupon_discount'] = this.couponDiscount;
    data['total_price'] = this.totalPrice;
    data['total_earnings'] = this.totalEarnings;
    data['shippo_data'] = this.shippoData;
    data['order_status'] = this.orderStatus;
    data['payment_status'] = this.paymentStatus;
    data['tracking_link'] = this.trackingLink;
    data['stripe_data'] = this.stripeData;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    data['cancel_requested'] = this.cancelRequested;
    data['cancel_request_accepted'] = this.cancelRequestAccepted;
    data['cancellation_reason'] = this.cancellationReason;
    data['delivery_date'] = this.deliveryDate;
    data['shipped_at'] = this.shippedAt;
    data['cancelled_at'] = this.cancelledAt;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    if (this.otherOrderItems != null) {
      data['other_order_items'] =
          this.otherOrderItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Reviews {
  String? sId;
  String? userId;
  String? productId;
  String? sellerId;
  String? title;
  String? description;
  var ratings;
  String? type;
  List<String>? images;
  List<String>? videos;
  String? language;
  String? updatedAt;
  String? createdAt;
  int? iV;

  Reviews(
      {this.sId,
        this.userId,
        this.productId,
        this.sellerId,
        this.title,
        this.description,
        this.ratings,
        this.type,
        this.images,
        this.videos,
        this.language,
        this.updatedAt,
        this.createdAt,
        this.iV});

  Reviews.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    productId = json['product_id'];
    sellerId = json['seller_id'];
    title = json['title'];
    description = json['description'];
    ratings = json['ratings'];
    type = json['type'];
    if(json['images']!=null)
      {
        images=<String>[];
        json['images'].forEach((v){
          images?.add(v);
        });
      }
    if(json['videos']!=null)
    {
      videos=<String>[];
      json['videos'].forEach((v){
        videos?.add(v);
      });
    }
    language = json['language'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['seller_id'] = this.sellerId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['ratings'] = this.ratings;
    data['type'] = this.type;
    data['images'] = this.images;
    data['videos'] = this.videos;
    data['language'] = this.language;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class OrderId {
  var orderId;
  CampaignId? campaignId;
  var sId;
  var totalPrice;

  OrderId({this.orderId, this.campaignId, this.sId,this.totalPrice});

  OrderId.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    campaignId = json['campaign_id'] != null
        ? new CampaignId.fromJson(json['campaign_id'])
        : null;
    sId = json['_id'];
    totalPrice=json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['campaign_id'] = this.campaignId;
    data['_id'] = this.sId;
    data['total_price'] = this.totalPrice;
    return data;
  }
}


class CampaignId {
  var campaignName;
  var createdBy;
  var quantity;
  var totalQuantity;
  var soldQuantity;
  var sellerId;
  var status;
  var productId;
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
  bool? isLive;
  bool? isLiveEnd;
  var liveTimeInMilisecond;
  bool? isSchedule;
  var cancelledBy;
  bool? cancelRequested;
  bool? isDelete;
  bool? isMoneyTransfer;
  var description;
  var updatedAt;
  var createdAt;
  var cancelledAt;
  var sId;
  var iV;

  CampaignId(
      {this.campaignName,
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
        this.sId,
        this.iV});

  CampaignId.fromJson(Map<String, dynamic> json) {
    campaignName = json['campaign_name'];
    createdBy = json['created_by'];
    quantity = json['quantity'];
    totalQuantity = json['total_quantity'];
    soldQuantity = json['sold_quantity'];
    sellerId = json['seller_id'];
    status = json['status'];
    productId = json['product_id'];
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
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['campaign_name'] = this.campaignName;
    data['created_by'] = this.createdBy;
    data['quantity'] = this.quantity;
    data['total_quantity'] = this.totalQuantity;
    data['sold_quantity'] = this.soldQuantity;
    data['seller_id'] = this.sellerId;
    data['status'] = this.status;
    data['product_id'] = this.productId;
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
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}


class GroupId {
  var groupType;
  var groupName;
  var sId;

  GroupId({this.groupType, this.groupName, this.sId});

  GroupId.fromJson(Map<String, dynamic> json) {
    groupType = json['group_type'];
    groupName = json['group_name'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_type'] = this.groupType;
    data['group_name'] = this.groupName;
    data['_id'] = this.sId;
    return data;
  }
}


class ProductId {
  var sId;
  var name;
  var description;
  List<String>? images;
  var productId;

  ProductId({this.sId, this.name, this.description, this.images,this.productId});

  ProductId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    productId=json['prodct_id'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['images'] = this.images;
    data['prodct_id'] = this.productId;
    return data;
  }
}

class AddressId {
  var name;
  var countryCode;
  var phoneNo;
  var company;
  var country;
  var state;
  var city;
  var pinCode;
  var apartmentNumber;
  var fullAddress;
  var addressType;
  var lat;
  var lng;

  AddressId(
      {this.name,
        this.countryCode,
        this.phoneNo,
        this.company,
        this.country,
        this.state,
        this.city,
        this.pinCode,
        this.apartmentNumber,
        this.fullAddress,
        this.addressType,
        this.lat,
        this.lng});

  AddressId.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    countryCode = json['country_code'];
    phoneNo = json['phone_no'];
    company = json['company'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    pinCode = json['pin_code'];
    apartmentNumber = json['apartment_number'];
    fullAddress = json['full_address'];
    addressType = json['address_type'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['country_code'] = this.countryCode;
    data['phone_no'] = this.phoneNo;
    data['company'] = this.company;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['pin_code'] = this.pinCode;
    data['apartment_number'] = this.apartmentNumber;
    data['full_address'] = this.fullAddress;
    data['address_type'] = this.addressType;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class OtherOrderItems {
  var sId;
  var orderId;
  var productOrderId;
  var userId;
  var sellerId;
  ProductId? productId;
  var quantity;
  var price;
  var deliveryPrice;
  var couponDiscount;
  var totalPrice;
  var orderStatus;
  var paymentStatus;
  var trackingLink;
  bool? cancelRequested;
  bool? cancelRequestAccepted;
  var cancellationReason;
  var deliveryDate;
  var cancelledAt;
  var updatedAt;
  var createdAt;

  OtherOrderItems(
      {this.sId,
        this.orderId,
        this.productOrderId,
        this.userId,
        this.sellerId,
        this.productId,
        this.quantity,
        this.price,
        this.deliveryPrice,
        this.couponDiscount,
        this.totalPrice,
        this.orderStatus,
        this.paymentStatus,
        this.trackingLink,
        this.cancelRequested,
        this.cancelRequestAccepted,
        this.cancellationReason,
        this.deliveryDate,
        this.cancelledAt,
        this.updatedAt,
        this.createdAt});

  OtherOrderItems.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    orderId = json['orderId'];
    productOrderId = json['productOrderId'];
    userId = json['user_id'];
    sellerId = json['seller_id'];
    productId = json['product_id'] != null
        ? new ProductId.fromJson(json['product_id'])
        : null;
    quantity = json['quantity'];
    price = json['price'];
    deliveryPrice = json['delivery_price'];
    couponDiscount = json['coupon_discount'];
    totalPrice = json['total_price'];
    orderStatus = json['order_status'];
    paymentStatus = json['payment_status'];
    trackingLink = json['tracking_link'];
    cancelRequested = json['cancel_requested'];
    cancelRequestAccepted = json['cancel_request_accepted'];
    cancellationReason = json['cancellation_reason'];
    deliveryDate = json['delivery_date'];
    cancelledAt = json['cancelled_at'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['orderId'] = this.orderId;
    data['productOrderId'] = this.productOrderId;
    data['user_id'] = this.userId;
    data['seller_id'] = this.sellerId;
    if (this.productId != null) {
      data['product_id'] = this.productId!.toJson();
    }
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['delivery_price'] = this.deliveryPrice;
    data['coupon_discount'] = this.couponDiscount;
    data['total_price'] = this.totalPrice;
    data['order_status'] = this.orderStatus;
    data['payment_status'] = this.paymentStatus;
    data['tracking_link'] = this.trackingLink;
    data['cancel_requested'] = this.cancelRequested;
    data['cancel_request_accepted'] = this.cancelRequestAccepted;
    data['cancellation_reason'] = this.cancellationReason;
    data['delivery_date'] = this.deliveryDate;
    data['cancelled_at'] = this.cancelledAt;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}