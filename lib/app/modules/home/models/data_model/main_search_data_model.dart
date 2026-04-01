class MainSearchDataModel {
  String? sId;
  String? name;
  String? image;
  String? type;
  String? categoryId;
  String? subCategoryId;

  MainSearchDataModel(
      {this.sId, this.name, this.image, this.type, this.categoryId,this.subCategoryId});

  MainSearchDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    type = json['type'];
    categoryId = json['category_id'];
    subCategoryId=json['sub_category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['type'] = this.type;
    data['category_id'] = this.categoryId;
    data['sub_category_id']=this.subCategoryId;
    return data;
  }
}
