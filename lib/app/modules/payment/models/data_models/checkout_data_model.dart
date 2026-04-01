class CheckoutData {
  var sId;
  var orderId;
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
  StripeData? stripeData;
  var updatedAt;
  var createdAt;

  CheckoutData(
      {this.sId,
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
      this.stripeData,
      this.updatedAt,
      this.createdAt});

  CheckoutData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    orderId = json['order_id'];
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
    stripeData = json['stripe_data'] != null
        ? new StripeData.fromJson(json['stripe_data'])
        : null;
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['order_id'] = this.orderId;
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
    if (this.stripeData != null) {
      data['stripe_data'] = this.stripeData!.toJson();
    }
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class ProductId {
  var sId;
  var name;
  var description;
  List<String>? images;

  ProductId({this.sId, this.name, this.description, this.images});

  ProductId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['images'] = this.images;
    return data;
  }
}

class AddressId {
  var sId;
  Location? location;
  var name;
  var userId;
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
  var language;

  AddressId(
      {this.sId,
      this.location,
      this.name,
      this.userId,
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
      this.lng,
      this.language});

  AddressId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    name = json['name'];
    userId = json['user_id'];
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
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['name'] = this.name;
    data['user_id'] = this.userId;
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
    data['language'] = this.language;
    return data;
  }
}

class Location {
  var type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
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
