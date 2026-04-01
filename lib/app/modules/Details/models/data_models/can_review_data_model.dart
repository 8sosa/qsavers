class CanReviewDataModel {
  bool? canReview;

  CanReviewDataModel({this.canReview});

  CanReviewDataModel.fromJson(Map<String, dynamic> json) {
    canReview = json['can_review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['can_review'] = this.canReview;
    return data;
  }
}
