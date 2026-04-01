class CanAddReviewResponseModel {
  String? message;
  Data? data;

  CanAddReviewResponseModel({this.message, this.data});

  CanAddReviewResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  bool? canReview;

  Data({this.canReview});

  Data.fromJson(Map<String, dynamic> json) {
    canReview = json['can_review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['can_review'] = this.canReview;
    return data;
  }
}
