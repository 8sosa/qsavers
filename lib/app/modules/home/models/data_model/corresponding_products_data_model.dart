class VendorsProductsDataModel {
  int? totalCount;
  int? maxPrice;
  List<VendorsProductsSubDataModel>? data;

  VendorsProductsDataModel({this.totalCount, this.maxPrice, this.data});

  VendorsProductsDataModel.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    maxPrice = json['max_price'];
    if (json['data'] != null) {
      data = <VendorsProductsSubDataModel>[];
      json['data'].forEach((v) {
        data!.add(VendorsProductsSubDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_count'] = totalCount;
    data['max_price'] = maxPrice;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VendorsProductsSubDataModel {
  String? sId;
  String? name;
  String? description;
  var productType;
  AddedBy? addedBy;
  var parcelId;
  AddedBy? brandId;
  CategoryId? categoryId;
  AddedBy? subcategoryId;
  var subSubcategoryId;
  List<String>? images;
  int? quantity;
  int? price;
  int? discountPercantage;
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
  List<ProductHighlights>? productHighlights;
  bool? wishlist;
  bool? isBlocked;
  bool? isDeleted;
  String? updatedAt;
  String? createdAt;

  VendorsProductsSubDataModel(
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
      this.productHighlights,
      this.wishlist,
      this.isBlocked,
      this.isDeleted,
      this.updatedAt,
      this.createdAt});

  VendorsProductsSubDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    productType = json['product_type'];
    addedBy =
        json['added_by'] != null ? AddedBy.fromJson(json['added_by']) : null;
    parcelId = json['parcel_id'];
    brandId =
        json['brand_id'] != null ? AddedBy.fromJson(json['brand_id']) : null;
    categoryId = json['category_id'] != null
        ? CategoryId.fromJson(json['category_id'])
        : null;
    subcategoryId = json['subcategory_id'] != null
        ? AddedBy.fromJson(json['subcategory_id'])
        : null;
    subSubcategoryId = json['sub_subcategory_id'];
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
    if (json['product_highlights'] != null) {
      productHighlights = <ProductHighlights>[];
      json['product_highlights'].forEach((v) {
        productHighlights!.add(new ProductHighlights.fromJson(v));
      });
    }
    wishlist = json['wishlist'];
    isBlocked = json['is_blocked'];
    isDeleted = json['is_deleted'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
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
    data['sub_subcategory_id'] = this.subSubcategoryId;
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
    if (this.productHighlights != null) {
      data['product_highlights'] =
          this.productHighlights!.map((v) => v.toJson()).toList();
    }
    data['wishlist'] = this.wishlist;
    data['is_blocked'] = this.isBlocked;
    data['is_deleted'] = this.isDeleted;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
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

class CategoryId {
  String? sId;
  String? name;
  var designType;

  CategoryId({this.sId, this.name, this.designType});

  CategoryId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    designType = json['design_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['design_type'] = this.designType;
    return data;
  }
}

class ProductHighlights {
  String? sId;
  String? productId;
  String? content;
  String? updatedAt;
  String? createdAt;

  ProductHighlights(
      {this.sId, this.productId, this.content, this.updatedAt, this.createdAt});

  ProductHighlights.fromJson(Map<String, dynamic> json) {
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
