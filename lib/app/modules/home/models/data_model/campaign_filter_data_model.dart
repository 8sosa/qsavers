class CampaignFilterDataModel {
  var totalCount;
  var maxPrice;
  List<Data>? data;

  CampaignFilterDataModel({this.totalCount, this.maxPrice, this.data});

  CampaignFilterDataModel.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    maxPrice = json['max_price'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_count'] = this.totalCount;
    data['max_price'] = this.maxPrice;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Data {
  var sId;
  var campaignName;
  var createdBy;
  var quantity;
  var totalQuantity;
  var soldQuantity;
  var sellerId;
  var status;
  ProductId? productId;
  var averageRating;
  var discountPercantage;
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
  bool? isLive;
  bool? isLiveEnd;
  var liveTimeInMilisecond;
  bool? isDelete;
  var description;
  var cancelledAt;
  var updatedAt;
  var createdAt;

  Data(
      {this.sId,
        this.campaignName,
        this.createdBy,
        this.quantity,
        this.totalQuantity,
        this.soldQuantity,
        this.sellerId,
        this.status,
        this.productId,
        this.averageRating,
        this.discountPercantage,
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
        this.isDelete,
        this.description,
        this.cancelledAt,
        this.updatedAt,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
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
    averageRating = json['average_rating'];
    discountPercantage = json['discount_percantage'];
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
    isDelete = json['is_delete'];
    description = json['description'];
    cancelledAt = json['cancelled_at'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
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
    data['average_rating'] = this.averageRating;
    data['discount_percantage'] = this.discountPercantage;
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
    data['is_delete'] = this.isDelete;
    data['description'] = this.description;
    data['cancelled_at'] = this.cancelledAt;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class ProductId {
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
  List<String>? campaignCreateSelectedMembers;
  var shipbobProductId;
  var shipbobInventoryId;
  var updatedAt;
  var createdAt;
  var iV;

  ProductId(
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

  ProductId.fromJson(Map<String, dynamic> json) {
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
    if (json['campaign_create_selected_members'] != null) {
      campaignCreateSelectedMembers = <String>[];
      json['campaign_create_selected_members'].forEach((v) {
        campaignCreateSelectedMembers!.add((v));
      });
    }
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


