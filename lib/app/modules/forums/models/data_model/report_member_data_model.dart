class ReportMemberDataModel  {
  var userId;
  var reportedUser;
  var reason;
  var updatedAt;
  var createdAt;
  var sId;
  var iV;

  ReportMemberDataModel(
      {this.userId,
        this.reportedUser,
        this.reason,
        this.updatedAt,
        this.createdAt,
        this.sId,
        this.iV});

  ReportMemberDataModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    reportedUser = json['reported_user'];
    reason = json['reason'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['reported_user'] = this.reportedUser;
    data['reason'] = this.reason;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}