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

class CancelReasonsDataModel {
  int? id;
  String? title;
  int? stateId;
  int? typeId;
  String? createdOn;
  int? createdById;

  CancelReasonsDataModel(
      {this.id,
        this.title,
        this.stateId,
        this.typeId,
        this.createdOn,
        this.createdById});

  CancelReasonsDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['state_id'] = stateId;
    data['type_id'] = typeId;
    data['created_on'] = createdOn;
    data['created_by_id'] = createdById;
    return data;
  }
}