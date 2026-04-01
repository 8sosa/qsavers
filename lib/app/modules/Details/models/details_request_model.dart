import "../../../export.dart";

class DetailsRequestModel {
  /*=================================================== Product Details Request Model==============================================*/

  static productDetailsRequestModel({
    String? id,
    String? language,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null && id != "") {
      data["_id"] = id;
    }
    data["language"] = strLanguageEnglish;
    return data;
  }

  /*=================================================== Product Details Request Model==============================================*/

  static productDetailsMediaRequestModel({
    String? id,
    String? language,
    String?type,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null && id != "") {
      data["_id"] = id;
    }
    data["language"] = strLanguageEnglish;
    data['review_type']="VIDEOS";
    return data;
  }

  /*=================================================== Product Details Request Model==============================================*/

  static productFaqRequestModel({
    String? productId,
    String? language,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (productId != null && productId != "") {
      data["product_id"] = productId;
    }
    data["language"] = strLanguageEnglish;
    return data;
  }

  /*=================================================== Related Products Request Model==============================================*/

  static relatedProductRequestModel({
    String? productId,
    // int? limit,
    // int? pagination,
    String? language,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["product_id"] = productId;
    // data["limit"] = limit;
    // data["pagination"] = pagination;
    data["language"] = strLanguageEnglish;
    return data;
  }

  /*=================================================== Add to Cart Request Model==============================================*/

  static addToCartRequestModel({
    String? productId,
    int? quantity,
    String? language,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["product_id"] = productId;
    data["language"] = strLanguageEnglish;
    data["quantity"] = quantity;
    return data;
  }

  /*=================================================== Add to Cart Request Model==============================================*/

  static updateToCartRequestModel({
    String? id,
    int? quantity,
    String? language,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["language"] = strLanguageEnglish;
    data["quantity"] = quantity;
    return data;
  }

  static addToWishlistRequestModel({
    String? productId,
    String? campaign_id,
    String? language,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["product_id"] = productId;
    data["campaign_id"] = campaign_id;
    data["language"] = strLanguageEnglish;
    return data;
  }

  /*=================================================== Create Campaign Request Model==============================================*/

  static createCampaignRequestModel({
    String? campaignName,
    String? campaignId,
    String? productId,
    String? groupId,
    int? startDate,
    int? endDate,
    String? image,
    String? video,
    dynamic description,
    String? language,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["campaign_name"] = campaignName;
    data["campaign_id"] = campaignId;
    data["product_id"] = productId;
    data["group_id"] = groupId;
    data["start_date"] = startDate;
    data["end_date"] = endDate;
    data["image"] = image;
    data["video"] = video;
    data["description"] = description;
    data["language"] = strLanguageEnglish;
    return data;
  }

  /*=================================================== Join Campaign Request Model==============================================*/

  static joinCampaignRequestModel({
    String? id,
    List<Map<String, dynamic>>? products,
    int? totalQuantity,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["products"] = products;
    data["total_quantity"] = totalQuantity;
    return data;
  }

  /*=================================================== Group Members Request Model==============================================*/

  static groupMembersRequestModel({
    String? search,
    int? pagination,
    int? limit,
    String? language,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["search"] = search;
    data["pagination"] = pagination;
    data["limit"] = limit;
    data["search"] = search;
    data["language"] = strLanguageEnglish;
    return data;
  }

  /*=================================================== Create Group Request Model==============================================*/

  static createGroupRequestModel({
    String? groupName,
    String? groupType,
    String? request,
    List<dynamic>? groupMembers,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["group_name"] = groupName;
    data["group_type"] = groupType;
    data["request"] = request;
    data["group_members"] = groupMembers;
    return data;
  }

  /*=================================================== Group List Request Model==============================================*/

  static groupListRequestModel({
    // int? pagination,
    // int? limit,
    String? language,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data["pagination"] = pagination;
    // data["limit"] = limit;
    data["language"] = strLanguageEnglish;
    return data;
  }

  /*=================================================== Product Campaigns Request Model==============================================*/

  static productCampaignsRequestModel({
    String? productId,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["product_id"] = productId;
    return data;
  }

  /*=================================================== Campaign Details Request Model==============================================*/

  static campaignDetailsRequestModel({
    String? id,
    String? language,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["language"] = strLanguageEnglish;
    return data;
  }

  /*=================================================== Campaign Members Request Model==============================================*/

  static campaignMembersRequestModel({
    String? id,
    String? type,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["type"] = type;
    return data;
  }

  /*=================================================== Campaign Creator Request Model==============================================*/

  static campaignCreatorRequestModel({
    String? language,
    String? type,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["type"] = type;
    data["language"] = strLanguageEnglish;
    return data;
  }

  /*=================================================== Exit Campaign Request Model==============================================*/

  static exitCampaignRequestModel({
    String? id,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    return data;
  }

  /*=================================================== Forum Request Model==============================================*/

  static forumRequestModel({
    String? language,
    String? type,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["language"] = strLanguageEnglish;
    data["type"] = type;
    return data;
  }

  /*=================================================== VIew All Campaign Data==============================================*/

  static viewAllRequestModel({
    String? sortBy,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["sort_by"] = sortBy;
    return data;
  }

  /*=================================================== Forum Request Members Model==============================================*/

  static forumRequestMembersModel({
    String? id,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    return data;
  }

  /*=================================================== Edit Campaign Request Model==============================================*/

  static editCampaignRequestModel({
    String? id,
    String? campaignName,
    String? productId,
    String? groupId,
    int? startDate,
    int? endDate,
    String? image,
    String? video,
    dynamic description,
    String? language,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["campaign_name"] = campaignName;
    data["product_id"] = productId;
    data["group_id"] = groupId;
    data["start_date"] = startDate;
    data["end_date"] = endDate;
    data["image"] = image;
    data["video"] = video;
    data["description"] = description;
    data["language"] = strLanguageEnglish;
    return data;
  }

  /*=================================================== Edit Group Request Model==============================================*/

  static editGroupRequestModel({
    String? groupId,
    String? groupName,
    String? groupType,
    List<dynamic>? addMembers,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["group_id"] = groupId;
    data["group_name"] = groupName;
    data["group_type"] = groupType;
    data["add_members"] = addMembers;
    return data;
  }

  /*=================================================== Order Request Model==============================================*/

  static orderRequestModel({
    String? language,
    String? type,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["order_status"] = type;
    data["language"] = strLanguageEnglish;
    return data;
  }

  /*===================================================Delete Order Request Model==============================================*/

  static deleteOrderRequestModel(
      {String? id,
      String? orderId,
      String? cancellationReason,
      String? description,
      String? language}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["order_id"] = orderId;
    data["cancellation_reason"] = cancellationReason;
    data["description"] = description;
    data["language"] = strLanguageEnglish;
    return data;
  }

  /*===================================================Product Review Request Model==============================================*/

  static productReviewRequestModel(
      {String? productId,
      String? title,
      String? description,
      double? rating,
      String? type,
      List<String>? arrayImage,
      List<String>? arrayVideo,
      String? language}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["product_id"] = productId;
    data["title"] = title;
    data["description"] = description;
    data["ratings"] = rating;
    data["type"] = type;
    data["language"] = strLanguageEnglish;
    data["images"] = arrayImage;
    data["videos"] = arrayVideo;
    return data;
  }

  /*=================================================== User Product Request Model==============================================*/

  static userProductReviewRequestModel({
    String? reviewId,
    String? productId,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (reviewId != null && reviewId != "") {
      data["_id"] = reviewId;
    }
    data["product_id"] = productId;
    return data;
  }

  /*=================================================== Default Address Request Model==============================================*/

  static defaultAddressRequestModel({
    String? addressId,
    String? language,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (addressId != null && addressId != "") {
      data["_id"] = addressId;
    }
    data["language"] = strLanguageEnglish;
    return data;
  }

  /*=================================================== Delete Bank Account Request Model==============================================*/

  static deleteBankAccountRequestModel({
    String? id,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null && id != "") {
      data["_id"] = id;
    }
    return data;
  }

  /*=================================================== Can Add Review Request Model==============================================*/

  static canAddReviewRequestModel({
    String? productId,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["product_id"] = productId;
    return data;
  }

  /*=================================================== CouponsRequestModel Request Model==============================================*/

  static couponsRequestModel({
    String? language,

  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["language"] = language;
    return data;
  }

  /*=================================================== Coupon Apply Request Model==============================================*/

  static couponApplyRequestModel({
    String? name,
    String? language,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null && name != "") {
      data["name"] = name;
    }
    data["language"] = strLanguageEnglish;
    return data;
  }

  /*=================================================== Delete Review & Rating Request Model==============================================*/

  static deleteReviewRequestModel({
    String? id,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null && id != "") {
      data["_id"] = id;
    }
    return data;
  }
/*===================================================Edit Review Request Model==============================================*/

  static editReviewRequestModel(
      {String? id,
        String? title,
        String? description,
        double? rating,
        List<String>? arrayImage,
        List<String>? arrayVideo,
        String? language}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["title"] = title;
    data["description"] = description;
    data["ratings"] = rating;
    data["language"] = strLanguageEnglish;
    data["images"] = arrayImage;
    data["videos"] = arrayVideo;
    return data;
  }
/*=================================================== Add to Cart Request Model==============================================*/

  static deliveryCheckRequestModel({
    String? productId,
    var lat,
    var lng,
    String?country,
    String? language,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["product_id"] = productId;
    data["language"] = strLanguageEnglish;
    data["lat"] = lat;
    data["lng"] = lng;
    data["country"] = country;
    return data;
  }

  /*=================================================== Campaign Creator Request Model==============================================*/

  static getNotificationsRequestModel({
    String? language,
    String? type,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["type"] = type;
    data["language"] = strLanguageEnglish;
    return data;
  }
  /*=================================================== Agora Live Token Request Model==============================================*/

  static agoraTokenRequestModel({
    String? campaignId,
    String?type
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["campaign_id"] = campaignId;
    data['type'] = type;
    return data;
  }

  /*=================================================== SubCategoriesRequestModel==============================================*/

  static subCategoryRequestModel({
    String? categoryId,
    String? language
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["category_id"] = categoryId;
    data['language'] = language;
    return data;
  }

  /*=================================================== SubSubCategoriesRequestModel==============================================*/

  static subsubCategoryRequestModel({
    String? subCategoryId,
    String? language
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["subcategory_id"] = subCategoryId;
    data['language'] = language;
    return data;
  }

  /*=================================================== Product FAQ LIKE Request Model==============================================*/

  static productFaqLikeRequestModel({
    String? faqId,
    String? language,
    String?type,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (faqId != null && faqId != "") {
      data["faq_id"] = faqId;
    }
    data["type"]=type;
    data["language"] = strLanguageEnglish;
    return data;
  }

  /*=================================================== Product Cancel Request Model==============================================*/

  static productCancelRequestModel({
    String? id,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null && id != "") {
      data["_id"] = id;
    }
    return data;
  }

  /*=================================================== Product Cancel Request Model==============================================*/

  static productReviewLikeAndDislikeRequestModel({
    String? id,
    String?type,
    String?language
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null && id != "") {
      data["review_id"] = id;
    }
    data["type"] = type;
    data["language"] = strLanguageEnglish;
    return data;
  }

}
