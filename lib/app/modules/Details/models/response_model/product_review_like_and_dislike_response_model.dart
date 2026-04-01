class ProductReviewLikeAndDislikeResponseModel {
  bool? success;
  String? message;
  Data? data;

  ProductReviewLikeAndDislikeResponseModel(
      {this.success, this.message, this.data});

  ProductReviewLikeAndDislikeResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? reviewId;
  String? userId;
  String? type;
  String? updatedAt;
  String? createdAt;
  int? likesCount;
  int? dislikeCount;
  String? userLikeStatus;

  Data(
      {this.sId,
        this.reviewId,
        this.userId,
        this.type,
        this.updatedAt,
        this.createdAt,
        this.likesCount,
        this.dislikeCount,
        this.userLikeStatus});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    reviewId = json['review_id'];
    userId = json['user_id'];
    type = json['type'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    likesCount = json['likes_count'];
    dislikeCount = json['dislike_count'];
    userLikeStatus = json['user_like_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['review_id'] = this.reviewId;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['likes_count'] = this.likesCount;
    data['dislike_count'] = this.dislikeCount;
    data['user_like_status'] = this.userLikeStatus;
    return data;
  }
}


