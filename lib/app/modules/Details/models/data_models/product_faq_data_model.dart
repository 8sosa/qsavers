class ProductFaqDataModel {
  var sId;
  var productId;
  SellerId? sellerId;
  var question;
  var answer;
  var language;
  var updatedAt;
  var createdAt;
  var totalLikes;
  var totalDislikes;
  var isLiked;
  var isDisliked;

  ProductFaqDataModel(
      {this.sId,
      this.productId,
      this.sellerId,
      this.question,
      this.answer,
      this.language,
      this.updatedAt,
      this.createdAt,
      this.totalLikes,
      this.totalDislikes,
      this.isLiked,
      this.isDisliked});

  ProductFaqDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productId = json['product_id'];
    sellerId = json['seller_id'] != null
        ? new SellerId.fromJson(json['seller_id'])
        : null;
    question = json['question'];
    answer = json['answer'];
    language = json['language'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    totalLikes = json['total_likes'];
    totalDislikes = json['total_dislikes'];
    isLiked = json['is_liked'];
    isDisliked = json['is_disliked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['product_id'] = this.productId;
    if (this.sellerId != null) {
      data['seller_id'] = this.sellerId!.toJson();
    }
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['language'] = this.language;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['total_likes'] = this.totalLikes;
    data['total_dislikes'] = this.totalDislikes;
    data['is_liked'] = this.isLiked;
    data['is_disliked'] = this.isDisliked;
    return data;
  }
}

class SellerId {
  var sId;
  var name;

  SellerId({this.sId, this.name});

  SellerId.fromJson(Map<String, dynamic> json) {
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
