class RelatedProductDataModel {
  int? totalCount;
  List<RelatedProductSubDataModel>? data;

  RelatedProductDataModel({this.totalCount, this.data});

  RelatedProductDataModel.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    if (json['data'] != null) {
      data = <RelatedProductSubDataModel>[];
      json['data'].forEach((v) {
        data!.add(RelatedProductSubDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_count'] = this.totalCount;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RelatedProductSubDataModel {
  var sId;
  var name;
  var description;
  var productType;
  AddedBy? addedBy;
  var parcelId;
  AddedBy? brandId;
  AddedBy? categoryId;
  AddedBy? subcategoryId;
  AddedBy? subSubcategoryId;
  List<String>? images;
  var quantity;
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
  var isBlocked;
  var isDeleted;
  var updatedAt;
  var createdAt;
  var wishlist;

  RelatedProductSubDataModel(
      {this.sId,
      this.name,
      this.description,
      this.productType,
      this.addedBy,
      this.parcelId,
      this.brandId,
      this.categoryId,
      this.subcategoryId,
      this.subSubcategoryId,
      this.images,
      this.quantity,
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
      this.isBlocked,
      this.isDeleted,
      this.updatedAt,
      this.createdAt,
      this.wishlist
      });

  RelatedProductSubDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    productType = json['product_type'];
    addedBy = json['added_by'] != null
        ? new AddedBy.fromJson(json['added_by'])
        : null;
    parcelId = json['parcel_id'];
    brandId = json['brand_id'] != null
        ? new AddedBy.fromJson(json['brand_id'])
        : null;
    categoryId = json['category_id'] != null
        ? new AddedBy.fromJson(json['category_id'])
        : null;
    subcategoryId = json['subcategory_id'] != null
        ? new AddedBy.fromJson(json['subcategory_id'])
        : null;
    subSubcategoryId = json['sub_subcategory_id'] != null
        ? new AddedBy.fromJson(json['sub_subcategory_id'])
        : null;
    images = json['images'].cast<String>();
    quantity = json['quantity'];
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
    isBlocked = json['is_blocked'];
    isDeleted = json['is_deleted'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    wishlist = json['wishlist'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['product_type'] = this.productType;
    if (this.addedBy != null) {
      data['added_by'] = this.addedBy!.toJson();
    }
    data['parcel_id'] = this.parcelId;
    if (this.brandId != null) {
      data['brand_id'] = this.brandId!.toJson();
    }
    if (this.categoryId != null) {
      data['category_id'] = this.categoryId!.toJson();
    }
    if (this.subcategoryId != null) {
      data['subcategory_id'] = this.subcategoryId!.toJson();
    }
    if (this.subSubcategoryId != null) {
      data['sub_subcategory_id'] = this.subSubcategoryId!.toJson();
    }
    data['images'] = this.images;
    data['quantity'] = this.quantity;
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
    data['is_blocked'] = this.isBlocked;
    data['is_deleted'] = this.isDeleted;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['wishlist'] = this.wishlist;
    return data;
  }
}

class AddedBy {
  String? sId;
  String? name;

  AddedBy({this.sId, this.name});

  AddedBy.fromJson(Map<String, dynamic> json) {
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
