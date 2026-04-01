class ReviewRatingDataModel {
  int? totalCount;
  List<ReviewRatingData>? data;

  ReviewRatingDataModel({this.totalCount, this.data});

  ReviewRatingDataModel.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    if (json['data'] != null) {
      data = <ReviewRatingData>[];
      json['data'].forEach((v) {
        data!.add(ReviewRatingData.fromJson(v));
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

class ReviewRatingData {
  String? sId;
  String? userId;
  ProductId? productId;
  String? sellerId;
  String? title;
  String? description;
  var ratings;
  String? type;
  List<String>? images;
  List<String>? videos;
  String? language;
  String? updatedAt;
  String? createdAt;

  ReviewRatingData(
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

  ReviewRatingData.fromJson(Map<String, dynamic> json) {
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
    if(json["images"]!=null)
      {
        images = json['images'].cast<String>();
      }


    if (json['videos'] != null) {
      videos = <String>[];
      json['videos'].forEach((v) {
        videos!.add(v);
      });
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
    // if (this.videos != null) {
    //   data['videos'] = this.videos!.map((v) => v.toJson()).toList();
    // }
    data['language'] = this.language;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class ProductId {
  String? sId;
  String? name;
  List<String>? images;
  var discountPrice;
  var averageRating;
  var totalReviews;
  var totalRatings;
  var produuctId;


  ProductId(
      {this.sId,
        this.name,
        this.images,
        this.discountPrice,
        this.totalRatings,
        this.totalReviews,
        this.produuctId,
        this.averageRating});

  ProductId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    images = json['images'].cast<String>();
    discountPrice = json['discount_price'];
    averageRating = json['average_rating'];
    totalRatings =json['total_ratings'];
    totalReviews = json ['total_reviews'];
    produuctId = json['prodct_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['images'] = this.images;
    data['discount_price'] = this.discountPrice;
    data['average_rating'] = this.averageRating;
    data['total_ratings'] = this.totalRatings;
    data['total_reviews'] = this.totalReviews;
    data['prodct_id'] = this.produuctId;
    return data;
  }
}


