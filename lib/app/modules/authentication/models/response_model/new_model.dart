
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

import 'dart:convert';

ProfieCompeletionModel profieCompeletionModelFromJson(var str) => ProfieCompeletionModel.fromJson(json.decode(str));

String profieCompeletionModelToJson(ProfieCompeletionModel data) => json.encode(data.toJson());

class ProfieCompeletionModel {
  var description;
  var tradeLicense;
  var insurance;
  var vat;
  var otherDoc;
  var documentId;

  ProfieCompeletionModel({
    required this.description,
    required this.tradeLicense,
    required this.insurance,
    required this.vat,
    required this.otherDoc,
    required this.documentId,
  });

  factory ProfieCompeletionModel.fromJson(Map<String, dynamic> json) => ProfieCompeletionModel(
    description: json["description"],
    tradeLicense: json["trade_license"],
    insurance: json["insurance"],
    vat: json["vat"],
    otherDoc: json["other_doc"],
    documentId: json["document_id"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "trade_license": tradeLicense,
    "insurance": insurance,
    "vat": vat,
    "other_doc": otherDoc,
    "document_id": documentId,
  };
}