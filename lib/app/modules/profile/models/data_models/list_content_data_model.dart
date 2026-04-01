class ListContentDataModel {
  var sId;
  var description;
  var imageUrl;
  var language;
  var createdAt;
  var type;

  ListContentDataModel(
      {this.sId,
        this.description,
        this.imageUrl,
        this.language,
        this.createdAt,
        this.type});

  ListContentDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    description = json['description'];
    imageUrl = json['image_url'];
    language = json['language'];
    createdAt = json['created_at'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    data['description'] = this.description;
    data['image_url'] = this.imageUrl;
    data['language'] = this.language;
    data['created_at'] = this.createdAt;
    data['type'] = this.type;
    return data;
  }
}