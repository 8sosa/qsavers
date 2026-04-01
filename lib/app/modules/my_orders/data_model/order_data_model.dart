class OrderDataModel {
  var sId;
  var ordersId;
  var productOrderId;
  var orderId;
  var userId;
  var sellerId;
  ProductId? productId;
  var quantity;
  var price;
  var deliveryPrice;
  var couponDiscount;
  var totalPrice;
  var totalEarnings;
  var shippoData;
  var orderStatus;
  var trackingLink;
  StripeData? stripeData;
  var updatedAt;
  var shippedAt;
  var deliveryDate;
  var cancelledDate;
  var createdAt;

  OrderDataModel(
      {this.sId,
      this.ordersId,
      this.productOrderId,
      this.orderId,
      this.userId,
      this.sellerId,
      this.productId,
      this.quantity,
      this.price,
      this.deliveryPrice,
      this.couponDiscount,
      this.totalPrice,
      this.totalEarnings,
      this.shippoData,
      this.orderStatus,
      this.trackingLink,
      this.stripeData,
      this.updatedAt,
      this.shippedAt,
      this.deliveryDate,
        this.cancelledDate,
      this.createdAt});

  OrderDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    ordersId = json['orderId'];
    productOrderId = json['productOrderId'];
    orderId = json['order_id'];
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
    totalEarnings = json['total_earnings'];
    shippoData = json['shippo_data'];
    orderStatus = json['order_status'];
    trackingLink = json['tracking_link'];
    stripeData = json['stripe_data'] != null
        ? new StripeData.fromJson(json['stripe_data'])
        : null;
    updatedAt = json['updated_at'];
    shippedAt = json['shipped_at'];
    deliveryDate = json['delivery_date'];
    cancelledDate=json['cancelled_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['orderId'] = this.ordersId;
    data['productOrderId'] = this.productOrderId;
    data['order_id'] = this.orderId;
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
    data['total_earnings'] = this.totalEarnings;
    data['shippo_data'] = this.shippoData;
    data['order_status'] = this.orderStatus;
    data['tracking_link'] = this.trackingLink;
    if (this.stripeData != null) {
      data['stripe_data'] = this.stripeData!.toJson();
    }
    data['updated_at'] = this.updatedAt;
    data['shipped_at'] = this.shippedAt;
    data['delivery_date'] = this.deliveryDate;
    data['created_at'] = this.createdAt;
    data['cancelled_at']=this.cancelledDate;
    return data;
  }
}

class ProductId {
  var sId;
  var name;
  var description;
  List<String>? images;
  Reviews? reviews;
  var productId;

  ProductId({this.sId, this.name, this.description, this.images, this.reviews,this.productId});

  ProductId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    reviews =
        json['reviews'] != null ? new Reviews.fromJson(json['reviews']) : null;
    productId=json['prodct_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['images'] = this.images;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.toJson();
    }
    data['prodct_id']=this.productId;
    return data;
  }
}

class Reviews {
  var sId;
  var userId;
  var productId;
  var sellerId;
  var title;
  var description;
  var ratings;
  var type;
  List<dynamic>? images;
  List<dynamic>? videos;
  var language;
  var updatedAt;
  var createdAt;
  var iV;
  UserDetail? userDetail;

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
      this.iV,
      this.userDetail});

  Reviews.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    productId = json['product_id'];
    sellerId = json['seller_id'];
    title = json['title'];
    description = json['description'];
    ratings = json['ratings'];
    type = json['type'];
    if(json["images"]!=null)
      {
        images=json['images'];
      }
    if(json["images"]!=null)
    {
      videos=json['videos'];
    }
    language = json['language'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    iV = json['__v'];
    userDetail = json['user_detail'] != null
        ? new UserDetail.fromJson(json['user_detail'])
        : null;
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
    if (this.userDetail != null) {
      data['user_detail'] = this.userDetail!.toJson();
    }
    return data;
  }
}

class UserDetail {
  var sId;
  var profilePic;
  var name;

  UserDetail({this.sId, this.profilePic, this.name});

  UserDetail.fromJson(Map<String, dynamic> json) {
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

class StripeData {
  var paymentIntent;

  StripeData({this.paymentIntent});

  StripeData.fromJson(Map<String, dynamic> json) {
    paymentIntent = json['payment_intent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_intent'] = this.paymentIntent;
    return data;
  }
}
