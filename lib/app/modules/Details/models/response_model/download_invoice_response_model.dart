class DownloadInvoiceResponseModel {
  bool? success;
  String? message;
  Data? data;

  DownloadInvoiceResponseModel({this.success, this.message, this.data});

  DownloadInvoiceResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? sId;
  String? invoiceId;
  String? taxNo;
  String? orderObjectId;
  String? orderId;
  ProductId? productId;
  UserId? userId;
  AddressId? addressId;
  SellerId? sellerId;
  int? quantity;
  int? price;
  double? deliveryPrice;
  int? couponDiscount;
  int? totalPrice;
  double? yourEarning;
  double? adminCommision;
  int? taxPercantage;
  double? taxAmount;
  var shippoData;
  String? orderStatus;
  String? deliveryDate;
  String? invoiceDate;
  var reviews;
  String? updatedAt;
  String? createdAt;

  Data(
      {this.sId,
        this.invoiceId,
        this.taxNo,
        this.orderObjectId,
        this.orderId,
        this.productId,
        this.userId,
        this.addressId,
        this.sellerId,
        this.quantity,
        this.price,
        this.deliveryPrice,
        this.couponDiscount,
        this.totalPrice,
        this.yourEarning,
        this.adminCommision,
        this.taxPercantage,
        this.taxAmount,
        this.shippoData,
        this.orderStatus,
        this.deliveryDate,
        this.invoiceDate,
        this.reviews,
        this.updatedAt,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    invoiceId = json['invoice_id'];
    taxNo = json['tax_no'];
    orderObjectId = json['order_object_id'];
    orderId = json['order_id'];
    productId = json['product_id'] != null
        ? new ProductId.fromJson(json['product_id'])
        : null;
    userId =
    json['user_id'] != null ? new UserId.fromJson(json['user_id']) : null;
    addressId = json['address_id'] != null
        ? new AddressId.fromJson(json['address_id'])
        : null;
    sellerId = json['seller_id'] != null
        ? new SellerId.fromJson(json['seller_id'])
        : null;
    quantity = json['quantity'];
    price = json['price'];
    deliveryPrice = json['delivery_price'];
    couponDiscount = json['coupon_discount'];
    totalPrice = json['total_price'];
    yourEarning = json['your_earning'];
    adminCommision = json['admin_commision'];
    taxPercantage = json['tax_percantage'];
    taxAmount = json['tax_amount'];
    shippoData = json['shippo_data'];
    orderStatus = json['order_status'];
    deliveryDate = json['delivery_date'];
    invoiceDate = json['invoice_date'];
    reviews = json['reviews'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['invoice_id'] = this.invoiceId;
    data['tax_no'] = this.taxNo;
    data['order_object_id'] = this.orderObjectId;
    data['order_id'] = this.orderId;
    if (this.productId != null) {
      data['product_id'] = this.productId!.toJson();
    }
    if (this.userId != null) {
      data['user_id'] = this.userId!.toJson();
    }
    if (this.addressId != null) {
      data['address_id'] = this.addressId!.toJson();
    }
    if (this.sellerId != null) {
      data['seller_id'] = this.sellerId!.toJson();
    }
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['delivery_price'] = this.deliveryPrice;
    data['coupon_discount'] = this.couponDiscount;
    data['total_price'] = this.totalPrice;
    data['your_earning'] = this.yourEarning;
    data['admin_commision'] = this.adminCommision;
    data['tax_percantage'] = this.taxPercantage;
    data['tax_amount'] = this.taxAmount;
    data['shippo_data'] = this.shippoData;
    data['order_status'] = this.orderStatus;
    data['delivery_date'] = this.deliveryDate;
    data['invoice_date'] = this.invoiceDate;
    data['reviews'] = this.reviews;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class ProductId {
  String? sId;
  String? name;
  String? prodId;
  String? description;
  List<String>? images;
  BrandId? brandId;
  Subcategory? subcategory;
  List<Services>? services;

  ProductId(
      {this.sId,
        this.name,
        this.prodId,
        this.description,
        this.images,
        this.brandId,
        this.subcategory,
        this.services});

  ProductId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    prodId = json['prod_id'];
    description = json['description'];
    images = json['images'].cast<String>();
    brandId = json['brand_id'] != null
        ? new BrandId.fromJson(json['brand_id'])
        : null;
    subcategory = json['subcategory'] != null
        ? new Subcategory.fromJson(json['subcategory'])
        : null;
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['prod_id'] = this.prodId;
    data['description'] = this.description;
    data['images'] = this.images;
    if (this.brandId != null) {
      data['brand_id'] = this.brandId!.toJson();
    }
    if (this.subcategory != null) {
      data['subcategory'] = this.subcategory!.toJson();
    }
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BrandId {
  String? sId;
  String? name;
  bool? isDeleted;
  String? updatedAt;
  String? createdAt;
  String? language;
  int? iV;

  BrandId(
      {this.sId,
        this.name,
        this.isDeleted,
        this.updatedAt,
        this.createdAt,
        this.language,
        this.iV});

  BrandId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    isDeleted = json['is_deleted'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    language = json['language'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['is_deleted'] = this.isDeleted;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['language'] = this.language;
    data['__v'] = this.iV;
    return data;
  }
}

class Subcategory {
  String? sId;
  String? categoryId;
  String? name;
  bool? isDeleted;
  String? language;
  String? updatedAt;
  String? createdAt;
  int? iV;

  Subcategory(
      {this.sId,
        this.categoryId,
        this.name,
        this.isDeleted,
        this.language,
        this.updatedAt,
        this.createdAt,
        this.iV});

  Subcategory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryId = json['category_id'];
    name = json['name'];
    isDeleted = json['is_deleted'];
    language = json['language'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['is_deleted'] = this.isDeleted;
    data['language'] = this.language;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Services {
  String? sId;
  String? productId;
  String? content;
  String? updatedAt;
  String? createdAt;
  int? iV;

  Services(
      {this.sId,
        this.productId,
        this.content,
        this.updatedAt,
        this.createdAt,
        this.iV});

  Services.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productId = json['product_id'];
    content = json['content'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['product_id'] = this.productId;
    data['content'] = this.content;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class UserId {
  String? sId;
  String? profilePic;
  String? name;
  String? email;
  String? countryCode;
  int? phoneNo;

  UserId(
      {this.sId,
        this.profilePic,
        this.name,
        this.email,
        this.countryCode,
        this.phoneNo});

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profilePic = json['profile_pic'];
    name = json['name'];
    email = json['email'];
    countryCode = json['country_code'];
    phoneNo = json['phone_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['profile_pic'] = this.profilePic;
    data['name'] = this.name;
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['phone_no'] = this.phoneNo;
    return data;
  }
}

class AddressId {
  String? name;
  String? countryCode;
  int? phoneNo;
  var company;
  String? country;
  String? state;
  String? city;
  String? pinCode;
 var apartmentNumber;
  String? fullAddress;
  String? addressType;
  String? lat;
  String? lng;

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

class SellerId {
  String? sId;
  String? name;
  String? countryCode;
  int? phoneNumber;
  String? image;
  String? company;
 var country;
  String? state;
  String? pinCode;
  String? fullAddress;

  SellerId(
      {this.sId,
        this.name,
        this.countryCode,
        this.phoneNumber,
        this.image,
        this.company,
        this.country,
        this.state,
        this.pinCode,
        this.fullAddress});

  SellerId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    countryCode = json['country_code'];
    phoneNumber = json['phone_number'];
    image = json['image'];
    company = json['company'];
    country = json['country'];
    state = json['state'];
    pinCode = json['pin_code'];
    fullAddress = json['full_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['country_code'] = this.countryCode;
    data['phone_number'] = this.phoneNumber;
    data['image'] = this.image;
    data['company'] = this.company;
    data['country'] = this.country;
    data['state'] = this.state;
    data['pin_code'] = this.pinCode;
    data['full_address'] = this.fullAddress;
    return data;
  }
}
