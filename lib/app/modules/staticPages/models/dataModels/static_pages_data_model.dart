


/*
 *
 *  * @copyright : Henceforth Pvt. Ltd. <info@henceforthsolutions.com>
 *  * @author     : Gaurav Negi
 *  * All Rights Reserved.
 *  * Proprietary and confidential :  All information contained herein is, and remains
 *  * the property of Henceforth Pvt. Ltd. and its partners.
 *  * Unauthorized copying of this file, via any medium is strictly prohibited.
 *  *
 *
 */

class StaticPagesDataModel {
  int? id;
  String? title;
  String? url;
  String? description;
  int? stateId;
  String? createdOn;
  int? createdById;

  StaticPagesDataModel(
      {this.id,
        this.title,
        this.url,
        this.description,
        this.stateId,
        this.createdOn,
        this.createdById});

  StaticPagesDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    url = json['url'];
    description = json['description'];
    stateId = json['state_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['url'] = url;
    data['description'] = description;
    data['state_id'] = stateId;
    data['created_on'] = createdOn;
    data['created_by_id'] = createdById;
    return data;
  }
}
