class EditReviewDataModel {
  String? userId;
  String? productId;
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
  String? sId;
  int? iV;

  EditReviewDataModel(
      {this.userId,
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
        this.createdAt,
        this.sId,
        this.iV});

  EditReviewDataModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    productId = json['product_id'];
    sellerId = json['seller_id'];
    title = json['title'];
    description = json['description'];
    ratings = json['ratings'];
    type = json['type'];

    if (json['images'] != null) {
      images = <String>[];
      json['images'].forEach((v) {
        images!.add(v);
      });
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
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
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
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}

