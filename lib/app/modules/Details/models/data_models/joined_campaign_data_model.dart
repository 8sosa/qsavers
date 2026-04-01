import 'package:quantity_savers/app/modules/Details/models/data_models/product_details_data_model.dart';

import '../../../home/models/data_model/corresponding_products_data_model.dart';

class JoinedCampaignData {
  var sId;
  var userId;
  CampaignId? campaignId;
  var totalPrice;
  var totalQuantity;
  var updatedAt;
  var exitedAt;
  var createdAt;
  var status;
  bool? isComplete;
  bool? isCancelled;
  bool? isFailed;
  List<Products>? products;
  MainProductDetails? mainProductDetails;
  bool? isJoined;

  JoinedCampaignData(
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
      this.products,
      this.mainProductDetails,
      this.isJoined});

  JoinedCampaignData.fromJson(Map<String, dynamic> json) {
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
    mainProductDetails = json['main_product_details'] != null
        ? new MainProductDetails.fromJson(json['main_product_details'])
        : null;
    isJoined = json['is_joined'];
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
    if (this.mainProductDetails != null) {
      data['main_product_details'] = this.mainProductDetails!.toJson();
    }
    data['is_joined'] = this.isJoined;
    return data;
  }
}

class CampaignId {
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
    iV = json['__v'];
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
    data['__v'] = this.iV;
    return data;
  }
}

class CreatedBy {
  var sId;
  var socialType;
  var socialToken;
  var profilePic;
  var name;
  var email;
  var countryCode;
  var phoneNo;
  var password;
  var otp;
  var phoneOtp;
  var uniqueCode;
  var fpOtp;
  bool? fpOtpVerified;
  var wrongPwdCount;
  var lockedTill;
  var stripeConnectId;
  var customerId;
  var paymentId;
  var description;
  bool? adminVerified;
  bool? emailVerified;
  bool? phoneVerified;
  var about;
  var accountStatus;
  var deactivationReason;
  bool? isBlocked;
  bool? isDeleted;
  var language;
  var createdAt;
  var iV;

  CreatedBy(
      {this.sId,
      this.socialType,
      this.socialToken,
      this.profilePic,
      this.name,
      this.email,
      this.countryCode,
      this.phoneNo,
      this.password,
      this.otp,
      this.phoneOtp,
      this.uniqueCode,
      this.fpOtp,
      this.fpOtpVerified,
      this.wrongPwdCount,
      this.lockedTill,
      this.stripeConnectId,
      this.customerId,
      this.paymentId,
      this.description,
      this.adminVerified,
      this.emailVerified,
      this.phoneVerified,
      this.about,
      this.accountStatus,
      this.deactivationReason,
      this.isBlocked,
      this.isDeleted,
      this.language,
      this.createdAt,
      this.iV});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    socialType = json['social_type'];
    socialToken = json['social_token'];
    profilePic = json['profile_pic'];
    name = json['name'];
    email = json['email'];
    countryCode = json['country_code'];
    phoneNo = json['phone_no'];
    password = json['password'];
    otp = json['otp'];
    phoneOtp = json['phone_otp'];
    uniqueCode = json['unique_code'];
    fpOtp = json['fp_otp'];
    fpOtpVerified = json['fp_otp_verified'];
    wrongPwdCount = json['wrong_pwd_count'];
    lockedTill = json['locked_till'];
    stripeConnectId = json['stripe_connect_id'];
    customerId = json['customer_id'];
    paymentId = json['payment_id'];
    description = json['description'];
    adminVerified = json['admin_verified'];
    emailVerified = json['email_verified'];
    phoneVerified = json['phone_verified'];
    about = json['about'];
    accountStatus = json['account_status'];
    deactivationReason = json['deactivation_reason'];
    isBlocked = json['is_blocked'];
    isDeleted = json['is_deleted'];
    language = json['language'];
    createdAt = json['created_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['social_type'] = this.socialType;
    data['social_token'] = this.socialToken;
    data['profile_pic'] = this.profilePic;
    data['name'] = this.name;
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['phone_no'] = this.phoneNo;
    data['password'] = this.password;
    data['otp'] = this.otp;
    data['phone_otp'] = this.phoneOtp;
    data['unique_code'] = this.uniqueCode;
    data['fp_otp'] = this.fpOtp;
    data['fp_otp_verified'] = this.fpOtpVerified;
    data['wrong_pwd_count'] = this.wrongPwdCount;
    data['locked_till'] = this.lockedTill;
    data['stripe_connect_id'] = this.stripeConnectId;
    data['customer_id'] = this.customerId;
    data['payment_id'] = this.paymentId;
    data['description'] = this.description;
    data['admin_verified'] = this.adminVerified;
    data['email_verified'] = this.emailVerified;
    data['phone_verified'] = this.phoneVerified;
    data['about'] = this.about;
    data['account_status'] = this.accountStatus;
    data['deactivation_reason'] = this.deactivationReason;
    data['is_blocked'] = this.isBlocked;
    data['is_deleted'] = this.isDeleted;
    data['language'] = this.language;
    data['created_at'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class GroupId {
  var sId;
  var groupType;
  var createdBy;
  var groupName;
  var token;
  bool? isDeleted;
  bool? isDefault;
  var updatedAt;
  var createdAt;
  List<GroupMembers>? groupMembers;
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
      this.groupMembers,
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
    if (json['group_members'] != null) {
      groupMembers = <GroupMembers>[];
      json['group_members'].forEach((v) {
        groupMembers!.add(new GroupMembers.fromJson(v));
      });
    }
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
    if (this.groupMembers != null) {
      data['group_members'] =
          this.groupMembers!.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class GroupMembers {
  var memberId;
  var role;
  bool? isBlocked;
  var sId;

  GroupMembers({this.memberId, this.role, this.isBlocked, this.sId});

  GroupMembers.fromJson(Map<String, dynamic> json) {
    memberId = json['member_id'];
    role = json['role'];
    isBlocked = json['is_blocked'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['member_id'] = this.memberId;
    data['role'] = this.role;
    data['is_blocked'] = this.isBlocked;
    data['_id'] = this.sId;
    return data;
  }
}

class Products {
  ProductIdd? productId;
  var quantity;
  var sId;

  Products({this.productId, this.quantity, this.sId});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'] != null
        ? new ProductIdd.fromJson(json['product_id'])
        : null;
    quantity = json['quantity'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productId != null) {
      data['product_id'] = this.productId!.toJson();
    }
    data['quantity'] = this.quantity;
    data['_id'] = this.sId;
    return data;
  }
}

class ProductIdd {
  var sId;
  var name;
  var description;
  var prodctId;
  var sku;
  var addedBy;
  var parcelId;
  var categoryId;
  var subcategoryId;
  var subSubcategoryId;
  var brandId;
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
  bool? sold;
  bool? isVisible;
  bool? isDeliveryAvailable;
  bool? isBlocked;
  bool? isDeleted;
  var wholesaleQuntity;
  var wholesalePrice;
  var campaignQuantity;
  var campaignCreateType;
  var campaignCreateSelectedMembers;
  var shipbobProductId;
  var shipbobInventoryId;
  var updatedAt;
  var createdAt;
  var iV;

  ProductIdd(
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
      this.iV});

  ProductIdd.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    prodctId = json['prodct_id'];
    sku = json['sku'];
    addedBy = json['added_by'];
    parcelId = json['parcel_id'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    subSubcategoryId = json['sub_subcategory_id'];
    brandId = json['brand_id'];
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
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['prodct_id'] = this.prodctId;
    data['sku'] = this.sku;
    data['added_by'] = this.addedBy;
    data['parcel_id'] = this.parcelId;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['sub_subcategory_id'] = this.subSubcategoryId;
    data['brand_id'] = this.brandId;
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
    data['__v'] = this.iV;
    return data;
  }
}

class MainProductDetails {
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
  bool? sold;
  bool? isVisible;
  bool? isDeliveryAvailable;
  bool? isBlocked;
  bool? isDeleted;
  var wholesaleQuntity;
  var wholesalePrice;
  var campaignQuantity;
  var campaignCreateType;
  List<Null>? campaignCreateSelectedMembers;
  var shipbobProductId;
  var shipbobInventoryId;
  var updatedAt;
  var createdAt;
  List<Productdetails>? productdetails;
  List<ProductServicees>? productServices;
  List<ProductHighlights>? productHighlights;
  List<ProductVariations>? productVariations;

  MainProductDetails(
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

  MainProductDetails.fromJson(Map<String, dynamic> json) {
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
      productServices = <ProductServicees>[];
      json['product_services'].forEach((v) {
        productServices!.add(new ProductServicees.fromJson(v));
      });
    }
    if (json['product_highlights'] != null) {
      productHighlights = <ProductHighlights>[];
      json['product_highlights'].forEach((v) {
        productHighlights!.add(new ProductHighlights.fromJson(v));
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

class ProductServicees {
  var sId;
  var productId;
  var content;
  var updatedAt;
  var createdAt;

  ProductServicees(
      {this.sId, this.productId, this.content, this.updatedAt, this.createdAt});

  ProductServicees.fromJson(Map<String, dynamic> json) {
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
