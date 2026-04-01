class UserProductReviewData {
  var totalCount;
  List<UserReviewData>? data;

  UserProductReviewData({this.totalCount, this.data});

  UserProductReviewData.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    if (json['data'] != null) {
      data = <UserReviewData>[];
      json['data'].forEach((v) {
        data!.add(new UserReviewData.fromJson(v));
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

class UserReviewData {
  var sId;
  var userId;
  ProductId? productId;
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

  UserReviewData(
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
      this.createdAt});

  UserReviewData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    productId = json['product_id'] != null
        ? new ProductId.fromJson(json['product_id'])
        : null;
    sellerId = json['seller_id'];
    title = json['title'];
    description = json['description'];
    ratings = json['ratings'];
    type = json['type'];
    if (json['images'] != null) {
      images = json['images'];
    }
    if (json['videos'] != null) {
      videos = json['videos'];
    }

    language = json['language'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_id'] = this.userId;
    if (this.productId != null) {
      data['product_id'] = this.productId!.toJson();
    }
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
    return data;
  }
}

class ProductId {
  var sId;
  var name;
  List<String>? images;
  var discountPrice;
  var averageRating;

  ProductId(
      {this.sId,
      this.name,
      this.images,
      this.discountPrice,
      this.averageRating});

  ProductId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    images = json['images'].cast<String>();
    discountPrice = json['discount_price'];
    averageRating = json['average_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['images'] = this.images;
    data['discount_price'] = this.discountPrice;
    data['average_rating'] = this.averageRating;
    return data;
  }
}
