class CampaignDetailsDataModel {
  var sId;
  var campaignName;
  CreatedBy? createdBy;
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
  ProductDetails? productDetails;
  AddressDetail? addressDetail;
  var isJoined;
  var isGroupJoined;
  var exitedAt;
  var orderProductID;
  var orderId;

  CampaignDetailsDataModel(
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
      this.productDetails,
      this.addressDetail,
      this.isJoined,
      this.isGroupJoined,
      this.exitedAt,
        this.orderProductID,
      this.orderId});

  CampaignDetailsDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    campaignName = json['campaign_name'];
    createdBy = json['created_by'] != null
        ? new CreatedBy.fromJson(json['created_by'])
        : null;
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
    productDetails = json['product_details'] != null
        ? new ProductDetails.fromJson(json['product_details'])
        : null;
    addressDetail = json['address_detail'] != null
        ? new AddressDetail.fromJson(json['address_detail'])
        : null;
    isJoined = json['is_joined'];
    isGroupJoined = json['is_group_joined'];
    exitedAt = json['exited_at'];
    orderProductID=json['order_product_id'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['campaign_name'] = this.campaignName;
    if (this.createdBy != null) {
      data['created_by'] = this.createdBy!.toJson();
    }
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
    if (this.productDetails != null) {
      data['product_details'] = this.productDetails!.toJson();
    }
    if (this.addressDetail != null) {
      data['address_detail'] = this.addressDetail!.toJson();
    }
    data['is_joined'] = this.isJoined;
    data['is_group_joined'] = this.isGroupJoined;
    data['exited_at'] = this.exitedAt;
    data['order_product_id'] = this.orderProductID;
    data['order_id'] = this.orderId;
    return data;
  }
}

class CreatedBy {
  var sId;
  var profilePic;
  var name;

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

class GroupId {
  var sId;
  var groupType;
  var createdBy;
  var groupName;
  var token;
  var isDeleted;
  var isDefault;
  var updatedAt;
  var createdAt;
  var iV;

  GroupId(
      {this.sId,
      this.groupType,
      this.createdBy,
      this.groupName,
      this.token,
      this.isDeleted,
      this.isDefault,
      this.updatedAt,
      this.createdAt,
      this.iV});

  GroupId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    groupType = json['group_type'];
    createdBy = json['created_by'];
    groupName = json['group_name'];
    token = json['token'];
    isDeleted = json['is_deleted'];
    isDefault = json['is_default'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['group_type'] = this.groupType;
    data['created_by'] = this.createdBy;
    data['group_name'] = this.groupName;
    data['token'] = this.token;
    data['is_deleted'] = this.isDeleted;
    data['is_default'] = this.isDefault;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class ProductDetails {
  var sId;
  var name;
  var description;
  var prodctId;
  var sku;
  AddedBy? addedBy;
  var parcelId;
  CategoryId? categoryId;
  CategoryId? subcategoryId;
  CategoryId? subSubcategoryId;
  CategoryId? brandId;
  List<String>? images;
  var quantity;
  var taxPercentage;
  var price;
  var discountPercantage;
  var discount;
  var discountPrice;
  var totalReviews;
  var totalRatings;
  var averageRating;
  var oneStarRatings;
  var twoStarRatings;
  var threeStarRatings;
  var fourStarRatings;
  var fiveStarRatings;
  var sold;
  var isVisible;
  var isDeliveryAvailable;
  var isBlocked;
  var isDeleted;
  var wholesaleQuntity;
  var wholesalePrice;
  var campaignQuantity;
  var campaignCreateType;
  var campaignCreateSelectedMembers;
  var shipbobProductId;
  var shipbobInventoryId;
  var updatedAt;
  var createdAt;
  List<Productdetails>? productdetails;
  List<ProductServices>? productServices;
  List<ProductServices>? productHighlights;
  List<ProductVariations>? productVariations;

  ProductDetails(
      {this.sId,
      this.name,
      this.description,
      this.prodctId,
      this.sku,
      this.addedBy,
      this.parcelId,
      this.categoryId,
      this.subcategoryId,
      this.subSubcategoryId,
      this.brandId,
      this.images,
      this.quantity,
      this.taxPercentage,
      this.price,
      this.discountPercantage,
      this.discount,
      this.discountPrice,
      this.totalReviews,
      this.totalRatings,
      this.averageRating,
      this.oneStarRatings,
      this.twoStarRatings,
      this.threeStarRatings,
      this.fourStarRatings,
      this.fiveStarRatings,
      this.sold,
      this.isVisible,
      this.isDeliveryAvailable,
      this.isBlocked,
      this.isDeleted,
      this.wholesaleQuntity,
      this.wholesalePrice,
      this.campaignQuantity,
      this.campaignCreateType,
      this.campaignCreateSelectedMembers,
      this.shipbobProductId,
      this.shipbobInventoryId,
      this.updatedAt,
      this.createdAt,
      this.productdetails,
      this.productServices,
      this.productHighlights,
      this.productVariations});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    prodctId = json['prodct_id'];
    sku = json['sku'];
    addedBy = json['added_by'] != null
        ? new AddedBy.fromJson(json['added_by'])
        : null;
    parcelId = json['parcel_id'];
    categoryId = json['category_id'] != null
        ? new CategoryId.fromJson(json['category_id'])
        : null;
    subcategoryId = json['subcategory_id'] != null
        ? new CategoryId.fromJson(json['subcategory_id'])
        : null;
    subSubcategoryId = json['sub_subcategory_id'] != null
        ? new CategoryId.fromJson(json['sub_subcategory_id'])
        : null;
    brandId = json['brand_id'] != null
        ? new CategoryId.fromJson(json['brand_id'])
        : null;
    images = json['images'].cast<String>();
    quantity = json['quantity'];
    taxPercentage = json['tax_percentage'];
    price = json['price'];
    discountPercantage = json['discount_percantage'];
    discount = json['discount'];
    discountPrice = json['discount_price'];
    totalReviews = json['total_reviews'];
    totalRatings = json['total_ratings'];
    averageRating = json['average_rating'];
    oneStarRatings = json['one_star_ratings'];
    twoStarRatings = json['two_star_ratings'];
    threeStarRatings = json['three_star_ratings'];
    fourStarRatings = json['four_star_ratings'];
    fiveStarRatings = json['five_star_ratings'];
    sold = json['sold'];
    isVisible = json['is_visible'];
    isDeliveryAvailable = json['is_delivery_available'];
    isBlocked = json['is_blocked'];
    isDeleted = json['is_deleted'];
    wholesaleQuntity = json['wholesale_quntity'];
    wholesalePrice = json['wholesale_price'];
    campaignQuantity = json['campaign_quantity'];
    campaignCreateType = json['campaign_create_type'];
    // if (json['campaign_create_selected_members'] != null) {
    //   campaignCreateSelectedMembers = <Null>[];
    //   json['campaign_create_selected_members'].forEach((v) {
    //     campaignCreateSelectedMembers!.add(new Null.fromJson(v));
    //   });
    // }
    shipbobProductId = json['shipbob_product_id'];
    shipbobInventoryId = json['shipbob_inventory_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    if (json['productdetails'] != null) {
      productdetails = <Productdetails>[];
      json['productdetails'].forEach((v) {
        productdetails!.add(new Productdetails.fromJson(v));
      });
    }
    if (json['product_services'] != null) {
      productServices = <ProductServices>[];
      json['product_services'].forEach((v) {
        productServices!.add(new ProductServices.fromJson(v));
      });
    }
    if (json['product_highlights'] != null) {
      productHighlights = <ProductServices>[];
      json['product_highlights'].forEach((v) {
        productHighlights!.add(new ProductServices.fromJson(v));
      });
    }
    if (json['product_variations'] != null) {
      productVariations = <ProductVariations>[];
      json['product_variations'].forEach((v) {
        productVariations!.add(new ProductVariations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['prodct_id'] = this.prodctId;
    data['sku'] = this.sku;
    if (this.addedBy != null) {
      data['added_by'] = this.addedBy!.toJson();
    }
    data['parcel_id'] = this.parcelId;
    if (this.categoryId != null) {
      data['category_id'] = this.categoryId!.toJson();
    }
    if (this.subcategoryId != null) {
      data['subcategory_id'] = this.subcategoryId!.toJson();
    }
    if (this.subSubcategoryId != null) {
      data['sub_subcategory_id'] = this.subSubcategoryId!.toJson();
    }
    if (this.brandId != null) {
      data['brand_id'] = this.brandId!.toJson();
    }
    data['images'] = this.images;
    data['quantity'] = this.quantity;
    data['tax_percentage'] = this.taxPercentage;
    data['price'] = this.price;
    data['discount_percantage'] = this.discountPercantage;
    data['discount'] = this.discount;
    data['discount_price'] = this.discountPrice;
    data['total_reviews'] = this.totalReviews;
    data['total_ratings'] = this.totalRatings;
    data['average_rating'] = this.averageRating;
    data['one_star_ratings'] = this.oneStarRatings;
    data['two_star_ratings'] = this.twoStarRatings;
    data['three_star_ratings'] = this.threeStarRatings;
    data['four_star_ratings'] = this.fourStarRatings;
    data['five_star_ratings'] = this.fiveStarRatings;
    data['sold'] = this.sold;
    data['is_visible'] = this.isVisible;
    data['is_delivery_available'] = this.isDeliveryAvailable;
    data['is_blocked'] = this.isBlocked;
    data['is_deleted'] = this.isDeleted;
    data['wholesale_quntity'] = this.wholesaleQuntity;
    data['wholesale_price'] = this.wholesalePrice;
    data['campaign_quantity'] = this.campaignQuantity;
    data['campaign_create_type'] = this.campaignCreateType;
    // if (this.campaignCreateSelectedMembers != null) {
    //   data['campaign_create_selected_members'] =
    //       this.campaignCreateSelectedMembers!.map((v) => v.toJson()).toList();
    // }
    data['shipbob_product_id'] = this.shipbobProductId;
    data['shipbob_inventory_id'] = this.shipbobInventoryId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    if (this.productdetails != null) {
      data['productdetails'] =
          this.productdetails!.map((v) => v.toJson()).toList();
    }
    if (this.productServices != null) {
      data['product_services'] =
          this.productServices!.map((v) => v.toJson()).toList();
    }
    if (this.productHighlights != null) {
      data['product_highlights'] =
          this.productHighlights!.map((v) => v.toJson()).toList();
    }
    if (this.productVariations != null) {
      data['product_variations'] =
          this.productVariations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddedBy {
  var sId;
  var name;
  var maxCampaignDuration;

  AddedBy({this.sId, this.name, this.maxCampaignDuration});

  AddedBy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    maxCampaignDuration = json['max_campaign_duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['max_campaign_duration'] = this.maxCampaignDuration;
    return data;
  }
}

class CategoryId {
  var sId;
  var name;

  CategoryId({this.sId, this.name});

  CategoryId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}

class Productdetails {
  var sId;
  var productId;
  var key;
  var value;
  var uniqueNumber;
  var updatedAt;
  var createdAt;

  Productdetails(
      {this.sId,
      this.productId,
      this.key,
      this.value,
      this.uniqueNumber,
      this.updatedAt,
      this.createdAt});

  Productdetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productId = json['product_id'];
    key = json['key'];
    value = json['value'];
    uniqueNumber = json['unique_number'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['product_id'] = this.productId;
    data['key'] = this.key;
    data['value'] = this.value;
    data['unique_number'] = this.uniqueNumber;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class ProductServices {
  var sId;
  var productId;
  var content;
  var updatedAt;
  var createdAt;

  ProductServices(
      {this.sId, this.productId, this.content, this.updatedAt, this.createdAt});

  ProductServices.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productId = json['product_id'];
    content = json['content'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['product_id'] = this.productId;
    data['content'] = this.content;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class ProductVariations {
  var sId;
  var productId;
  var name;
  var images;
  var price;
  var quantity;
  var discountPercantage;
  var wholesaleQuntity;
  var discount;
  var discountPrice;

  ProductVariations(
      {this.sId,
      this.productId,
      this.name,
      this.images,
      this.price,
      this.quantity,
      this.discountPercantage,
      this.wholesaleQuntity,
      this.discount,
      this.discountPrice});

  ProductVariations.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productId = json['product_id'];
    name = json['name'];
    images = json['images'];
    price = json['price'];
    quantity = json['quantity'];
    discountPercantage = json['discount_percantage'];
    wholesaleQuntity = json['wholesale_quntity'];
    discount = json['discount'];
    discountPrice = json['discount_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['images'] = this.images;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['discount_percantage'] = this.discountPercantage;
    data['wholesale_quntity'] = this.wholesaleQuntity;
    data['discount'] = this.discount;
    data['discount_price'] = this.discountPrice;
    return data;
  }
}

class AddressDetail {
  var sId;
  AddressId? addressId;
  var buyQuantity;

  AddressDetail({this.sId, this.addressId, this.buyQuantity});

  AddressDetail.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    addressId = json['address_id'] != null
        ? new AddressId.fromJson(json['address_id'])
        : null;
    buyQuantity = json['buy_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.addressId != null) {
      data['address_id'] = this.addressId!.toJson();
    }
    data['buy_quantity'] = this.buyQuantity;
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
  var shippoUserAddressId;
  var addressType;
  var lat;
  var lng;
  var language;
  var isDefault;
  var isDeleted;
  var createdAt;
  var iV;

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
      this.shippoUserAddressId,
      this.addressType,
      this.lat,
      this.lng,
      this.language,
      this.isDefault,
      this.isDeleted,
      this.createdAt,
      this.iV});

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
    shippoUserAddressId = json['shippo_user_address_id'];
    addressType = json['address_type'];
    lat = json['lat'];
    lng = json['lng'];
    language = json['language'];
    isDefault = json['is_default'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    iV = json['__v'];
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
    data['shippo_user_address_id'] = this.shippoUserAddressId;
    data['address_type'] = this.addressType;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['language'] = this.language;
    data['is_default'] = this.isDefault;
    data['is_deleted'] = this.isDeleted;
    data['created_at'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Location {
  var type;
  List<int>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}
