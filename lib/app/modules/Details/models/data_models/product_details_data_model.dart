class ProductDetailsDataModel {
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
  var shipbobProductId;
  var shipbobInventoryId;
  var updatedAt;
  var createdAt;
  var inCart;
  var wishlist;
  List<Productdetails>? productdetails;
  List<ProductServices>? productServices;
  List<ProductServices>? productHighlights;
  List<ProductVariations>? productVariations;
  List<FaqsProducts>? faqsProducts;
  List<Ratings>? ratings;
  var canCreateCampaign;
  var createCampaign;
  var campaignRequest;
  var campaignLimit;
  var ongoingCampaign;

  ProductDetailsDataModel(
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
      this.shipbobProductId,
      this.shipbobInventoryId,
      this.updatedAt,
      this.createdAt,
      this.inCart,
      this.wishlist,
      this.productdetails,
      this.productServices,
      this.productHighlights,
      this.productVariations,
      this.faqsProducts,
      this.ratings,
      this.canCreateCampaign,
        this.campaignRequest,
        this.campaignLimit,
        this.ongoingCampaign,
      this.createCampaign});

  ProductDetailsDataModel.fromJson(Map<String, dynamic> json) {
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
    shipbobProductId = json['shipbob_product_id'];
    shipbobInventoryId = json['shipbob_inventory_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    inCart = json['in_cart'];
    campaignLimit=json['campaign_limit'];
    ongoingCampaign=json['ongoing_campaign'];
    wishlist = json['wishlist'];
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
    if (json['faqs_products'] != null) {
      faqsProducts = <FaqsProducts>[];
      json['faqs_products'].forEach((v) {
        faqsProducts!.add(new FaqsProducts.fromJson(v));
      });
    }
    if (json['ratings'] != null) {
      ratings = <Ratings>[];
      json['ratings'].forEach((v) {
        ratings!.add(new Ratings.fromJson(v));
      });
    }
    canCreateCampaign = json['can_create_campaign'];
    createCampaign = json['create_campaign'];
    campaignRequest = json['campaign_request'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['prodct_id'] = this.prodctId;
    data['sku'] = this.sku;
    data['campaign_limit']=this.campaignLimit;
    data['ongoing_campaign']=this.ongoingCampaign;
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
    data['shipbob_product_id'] = this.shipbobProductId;
    data['shipbob_inventory_id'] = this.shipbobInventoryId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['in_cart'] = this.inCart;
    data['wishlist'] = this.wishlist;
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
    if (this.faqsProducts != null) {
      data['faqs_products'] =
          this.faqsProducts!.map((v) => v.toJson()).toList();
    }
    if (this.ratings != null) {
      data['ratings'] = this.ratings!.map((v) => v.toJson()).toList();
    }
    data['can_create_campaign'] = this.canCreateCampaign;
    data['create_campaign'] = this.createCampaign;
    data['campaign_request'] = this.campaignRequest;
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
  List<String>? images;
  var price;
  var quantity;
  var discountPercantage;
  var wholesaleQuntity;
  var discount;
  var discountPrice;
  var selectedQuantity;

  ProductVariations(
      {this.sId,
      this.productId,
      this.name,
      this.images,
      this.price,
      this.quantity,
      this.discountPercantage,
      this.wholesaleQuntity,
      this.selectedQuantity,
      this.discount,
      this.discountPrice});

  ProductVariations.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productId = json['product_id'];
    name = json['name'];
    images = json['images'].cast<String>();
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

class FaqsProducts {
  var sId;
  var productId;
  var sellerId;
  var question;
  var answer;
  var language;
  var updatedAt;
  var createdAt;
  var likesCount;
  var dislikesCount;
  var likedByYou;
  var dislikedByYou;

  FaqsProducts(
      {this.sId,
      this.productId,
      this.sellerId,
      this.question,
      this.answer,
      this.language,
      this.updatedAt,
      this.createdAt,
      this.likesCount,
      this.dislikesCount,
      this.likedByYou,
      this.dislikedByYou});

  FaqsProducts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productId = json['product_id'];
    sellerId = json['seller_id'];
    question = json['question'];
    answer = json['answer'];
    language = json['language'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    likesCount = json['likes_count'];
    dislikesCount = json['dislikes_count'];
    likedByYou = json['liked_by_you'];
    dislikedByYou = json['disliked_by_you'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['product_id'] = this.productId;
    data['seller_id'] = this.sellerId;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['language'] = this.language;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['likes_count'] = this.likesCount;
    data['dislikes_count'] = this.dislikesCount;
    data['liked_by_you'] = this.likedByYou;
    data['disliked_by_you'] = this.dislikedByYou;
    return data;
  }
}

class Ratings {
  var sId;
  UserId? userId;
  var productId;
  var sellerId;
  var title;
  var description;
  var ratings;
  List<String>? images;
  List<String>? videos;
  var language;
  var updatedAt;
  var createdAt;
  var likesCount;
  var dislikeCount;
  var userLikeStatus;

  Ratings(
      {this.sId,
      this.userId,
      this.productId,
      this.sellerId,
      this.title,
      this.description,
      this.ratings,
      this.images,
      this.language,
      this.updatedAt,
      this.createdAt,
      this.likesCount,
      this.dislikeCount,
      this.userLikeStatus});

  Ratings.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId =
        json['user_id'] != null ? new UserId.fromJson(json['user_id']) : null;
    productId = json['product_id'];
    sellerId = json['seller_id'];
    title = json['title'];
    description = json['description'];
    ratings = json['ratings'];
    if (json['images'] != null) {
      images = json['images'].cast<String>();
    }
    if (json['videos'] != null) {
      videos = json['videos'].cast<String>();
    }

    language = json['language'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    likesCount = json['likes_count'];
    dislikeCount = json['dislike_count'];
    userLikeStatus = json['user_like_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.userId != null) {
      data['user_id'] = this.userId!.toJson();
    }
    data['product_id'] = this.productId;
    data['seller_id'] = this.sellerId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['ratings'] = this.ratings;
    data['images'] = this.images;
    data['language'] = this.language;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['likes_count'] = this.likesCount;
    data['dislike_count'] = this.dislikeCount;
    data['user_like_status'] = this.userLikeStatus;
    return data;
  }
}

class UserId {
  var sId;
  var profilePic;
  var name;

  UserId({this.sId, this.profilePic, this.name});

  UserId.fromJson(Map<String, dynamic> json) {
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
