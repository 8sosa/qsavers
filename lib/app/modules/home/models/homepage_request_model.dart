import 'package:quantity_savers/app/core/values/app_strings.dart';

class HomepageRequestModel {
  /*==================================================Product Banner Request Model==============================================*/
  static productBannerRequestModel({
    int? pagination,
    int? limit,
    String? language,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pagination != null) {
      data["pagination"] = pagination;
    }
    data["limit"] = 10;
    data["language"] = strLanguageEnglish;
    return data;
  }

  /*==================================================Top Banner Request Model==============================================*/
  static topBannerRequestModel(
      {int? pagination, int? limit, String? language, String? position}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pagination != null) {
      data["pagination"] = pagination;
    }
    data["limit"] = 10;
    data["language"] = strLanguageEnglish;
    data["position"] = 'TOP';
    return data;
  }


  /*==================================================Bottom Banner Request Model==============================================*/
  static bottomBannerRequestModel(
      {int? pagination, int? limit, String? language, String? position}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pagination != null) {
      data["pagination"] = pagination;
    }
    data["limit"] = 10;
    data["language"] = strLanguageEnglish;
    data["position"] = 'BOTTOM';
    return data;
  }

  /*==================================================Bottom Banner Request Model==============================================*/
  static middleBannerRequestModel(
      {int? pagination, int? limit, String? language, String? position}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pagination != null) {
      data["pagination"] = pagination;
    }
    data["limit"] = 10;
    data["language"] = strLanguageEnglish;
    data["position"] = 'MIDDLE';
    return data;
  }

  /*==================================================Product Categories Request Model==============================================*/
  static productCategoriesRequestModel({
    String? id,
    int? pagination,
    int? limit,
    String? language,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if ((id != null) && (id != "")) {
      data["_id"] = id;
    }
    data["pagination"] = pagination;
    data["limit"] = limit;
    data["language"] = strLanguageEnglish;
    return data;
  }

  /*================================================== Main Search Request Model==============================================*/
  static mainSearchRequestModel({
    String? type,
    String? search,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["type"] = type;
    data["search"] = search;
    return data;
  }

  /*=================================================== Corresponding Products Details Request Model==============================================*/

  static correspondingProductsDetailsRequestModel({
    String? categoryId,
    String? sortBy,
    // int? pagination,
    // int? minPrice,
    // int? maxPrice,
    // int? selectedRating,
    // int? selectedStreaming,
    String? subcategoryId,
    String? language,
    String?sellerId,
    String? brandId,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categoryId != "" && categoryId != null) {
      data["category_id"] = categoryId;
    }
    if (sortBy != "" && sortBy != null) {
      data["sort_by"] = sortBy;
    }
    // data["min_price"] = minPrice;
    // data["max_price"] = maxPrice;
    if (subcategoryId != "" && subcategoryId != null) {
      data["subcategory_id"] = subcategoryId;
    }
    if (brandId != "" && brandId != null) {
      data["brand_id"] = brandId;
    }
    if (sellerId != "" && sellerId != null) {
      data["seller_id"] = sellerId;
    }
    data["language"] = strLanguageEnglish;
    // data["pagination"] = pagination;
    return data;
  }

  /*=================================================== Vendors Products Details Request Model==============================================*/

  static vendorProductsDetailsRequestModel({
    String? sellerId,
    String? search,
    int? minPrice,
    int? maxPrice,
    String? language,
    // int? pagination
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["search"] = search;
    if (sellerId != null) {
      data["seller_id"] = sellerId;
    }
    if (minPrice != null) {
      data["min_price"] = minPrice;
    }
    if (maxPrice != null) {
      data["max_price"] = maxPrice;
    }
    if (strLanguageEnglish != null) {
      data["language"] = strLanguageEnglish;
    }
    // if (pagination != null) {
    //   data["pagination"] = pagination;
    // }
    data["limit"] = 10;
    return data;
  }

  /*=================================================== Search Forums Request Model==============================================*/

  static searchForumsRequestModel({
    String? search,
    String? language,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["search"] = search;
    data["language"] = strLanguageEnglish;
    return data;
  }

  /*=================================================== Search Country Request Model==============================================*/

  static searchCountryRequestModel({
    String? search,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["search"] = search;
    return data;
  }


  /*=================================================== Filtered Products Details Request Model==============================================*/

  static filteredProductsDetailsRequestModel(
      {String? categoryId,
      String? sortBy,
      // int? pagination,
      int? minPrice,
      int? maxPrice,
      int? selectedRating,
      // int? selectedStreaming,
      String? subcategoryId,
        String? subsubcategoryId,
      String? language,
        String?brandId,
        int? discount,
      String? sellerID,
      bool? isLive}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categoryId != "" && categoryId != null) {
      data["category_id"] = categoryId;
    }
    if(sortBy!=null)
    data["sort_by"] = sortBy;
    if(minPrice!=null)

      data["min_price"] = minPrice;
    if(maxPrice!=null)
    data["max_price"] = maxPrice;
    if(selectedRating!=null)
    data["ratings"] = selectedRating;
    // data["selectedStreaming"] = selectedStreaming;
    if (subcategoryId != "" && subcategoryId != null) {
      data["subcategory_id"] = subcategoryId;
    }
    if (subsubcategoryId != "" && subsubcategoryId != null) {
      data["sub_subcategory_id"] = subsubcategoryId;
    }

    data["language"] = strLanguageEnglish;
    // data["pagination"] = pagination;
    if (sellerID != null && sellerID.isNotEmpty) {
      data["seller_id"] = sellerID;
    }
    if (brandId != null && brandId.isNotEmpty) {
      data["brand_id"] = brandId;
    }
    if(discount!=null)
      {
        data['discount_available']=discount;
      }
    if(isLive!=null)
      {
        data['is_live']=isLive;
      }


    return data;
  }

  // /*================================================== Add to Wishlist Request Model==============================================*/
  // static addToWishlistRequestModel({
  //   var product_id,
  //   var campaign_id
  // }) {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data["product_id"] = product_id;
  //   data["campaign_id"] = campaign_id;
  //   return data;
  // }
/*=================================================== Sub Sub  Products Details Request Model==============================================*/

  static subSubProductsDetailsRequestModel({
    String? categoryId,
    String? subcategoryId,
    String? subSubcategoryId,
    String? language,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categoryId != "" && categoryId != null) {
      data["category_id"] = categoryId;
    }
    if (subcategoryId != "" && subcategoryId != null) {
      data["subcategory_id"] = subcategoryId;
    }
    if (subSubcategoryId != "" && subSubcategoryId != null) {
      data["sub_subcategory_id"] = subSubcategoryId;
    }
    data["language"] = strLanguageEnglish;
    return data;
  }


}
