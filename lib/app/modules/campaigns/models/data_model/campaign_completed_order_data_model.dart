class CampaignCompletedOrderDataModel {
  var sId;
  var paymentMode;
  var orderId;
  List<OrderProducts>? orderProducts;
  AddressData? addressId;
  var createdAt;

  CampaignCompletedOrderDataModel(
      {this.sId,
      this.paymentMode,
      this.orderId,
      this.orderProducts,
      this.addressId,
      this.createdAt});

  CampaignCompletedOrderDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    paymentMode = json['payment_mode'];
    orderId = json['order_id'];
    if (json['order_products'] != null) {
      orderProducts = <OrderProducts>[];
      json['order_products'].forEach((v) {
        orderProducts!.add(new OrderProducts.fromJson(v));
      });
    }
    addressId = json['address_id'] != null
        ? new AddressData.fromJson(json['address_id'])
        : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['payment_mode'] = this.paymentMode;
    data['order_id'] = this.orderId;
    if (this.orderProducts != null) {
      data['order_products'] =
          this.orderProducts!.map((v) => v.toJson()).toList();
    }
    if (this.addressId != null) {
      data['address_id'] = this.addressId!.toJson();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class OrderProducts {
  var sId;
  var orderId;
  var productOrderId;
  var productId;
  var taxNo;
  var quantity;
  var price;
  var discountPercantage;
  var discountPrice;
  var deliveryPrice;
  var couponDiscount;
  var totalPrice;
  var totalEarnings;
  var adminCommision;
  var taxPercentage;
  var taxAmount;
  var orderStatus;
  var previousStatus;
  var cancellationReason;
  var cancelRequested;
  var cancelRequestAccepted;
  var paymentStatus;
  var trackingLink;
  Products? products;
  var updatedAt;
  var shippedAt;
  var deliveryDate;
  var cancelledAt;
  var createdAt;
  AddressData? addressData;

  OrderProducts(
      {this.sId,
      this.orderId,
      this.productOrderId,
      this.productId,
      this.taxNo,
      this.quantity,
      this.price,
      this.discountPercantage,
      this.discountPrice,
      this.deliveryPrice,
      this.couponDiscount,
      this.totalPrice,
      this.totalEarnings,
      this.adminCommision,
      this.taxPercentage,
      this.taxAmount,
      this.orderStatus,
      this.previousStatus,
      this.cancellationReason,
      this.cancelRequested,
      this.cancelRequestAccepted,
      this.paymentStatus,
      this.trackingLink,
      this.products,
      this.updatedAt,
      this.shippedAt,
      this.deliveryDate,
      this.cancelledAt,
      this.createdAt,
      this.addressData});

  OrderProducts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    orderId = json['order_id'];
    productOrderId = json['product_order_id'];
    productId = json['product_id'];
    taxNo = json['tax_no'];
    quantity = json['quantity'];
    price = json['price'];
    discountPercantage = json['discount_percantage'];
    discountPrice = json['discount_price'];
    deliveryPrice = json['delivery_price'];
    couponDiscount = json['coupon_discount'];
    totalPrice = json['total_price'];
    totalEarnings = json['total_earnings'];
    adminCommision = json['admin_commision'];
    taxPercentage = json['tax_percentage'];
    taxAmount = json['tax_amount'];
    orderStatus = json['order_status'];
    previousStatus = json['previous_status'];
    cancellationReason = json['cancellation_reason'];
    cancelRequested = json['cancel_requested'];
    cancelRequestAccepted = json['cancel_request_accepted'];
    paymentStatus = json['payment_status'];
    trackingLink = json['tracking_link'];
    products = json['products'] != null
        ? new Products.fromJson(json['products'])
        : null;
    updatedAt = json['updated_at'];
    shippedAt = json['shipped_at'];
    deliveryDate = json['delivery_date'];
    cancelledAt = json['cancelled_at'];
    createdAt = json['created_at'];
    addressData = json['address_data'] != null
        ? new AddressData.fromJson(json['address_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['order_id'] = this.orderId;
    data['product_order_id'] = this.productOrderId;
    data['product_id'] = this.productId;
    data['tax_no'] = this.taxNo;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['discount_percantage'] = this.discountPercantage;
    data['discount_price'] = this.discountPrice;
    data['delivery_price'] = this.deliveryPrice;
    data['coupon_discount'] = this.couponDiscount;
    data['total_price'] = this.totalPrice;
    data['total_earnings'] = this.totalEarnings;
    data['admin_commision'] = this.adminCommision;
    data['tax_percentage'] = this.taxPercentage;
    data['tax_amount'] = this.taxAmount;
    data['order_status'] = this.orderStatus;
    data['previous_status'] = this.previousStatus;
    data['cancellation_reason'] = this.cancellationReason;
    data['cancel_requested'] = this.cancelRequested;
    data['cancel_request_accepted'] = this.cancelRequestAccepted;
    data['payment_status'] = this.paymentStatus;
    data['tracking_link'] = this.trackingLink;
    if (this.products != null) {
      data['products'] = this.products!.toJson();
    }
    data['updated_at'] = this.updatedAt;
    data['shipped_at'] = this.shippedAt;
    data['delivery_date'] = this.deliveryDate;
    data['cancelled_at'] = this.cancelledAt;
    data['created_at'] = this.createdAt;
    if (this.addressData != null) {
      data['address_data'] = this.addressData!.toJson();
    }
    return data;
  }
}

class Products {
  var sId;
  var name;
  var description;
  var productId;
  List<String>? images;

  Products({this.sId, this.name, this.description, this.images,this.productId});

  Products.fromJson(Map<String, dynamic> json) {
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

class AddressData {
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

  AddressData(
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

  AddressData.fromJson(Map<String, dynamic> json) {
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
