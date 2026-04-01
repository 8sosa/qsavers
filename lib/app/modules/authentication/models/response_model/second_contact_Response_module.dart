



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

class SecondContactResponseModel {
  String? message;
  String? accessToken;
   String?image;
   String? name;

  SecondContactResponseModel({this.message,this.accessToken, });

  SecondContactResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    accessToken = json['data']['access_token'];
    image=json['data']['image'];
    name=json['data']['name'];
  }
  
}

