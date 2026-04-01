class FilterCampaignData {
  String? title;
  bool? forVendorFiltration;
  int? lowestPrice;
  int? highestPrice;
  int? selectedRating;
  int? selectedDiscount;
  int? selectedStreaming;
  String? selectedCategory;
  int? categoryIndex;
  int?subsubCategoryIndex;
  int? customerRatingIndex;
  int? customerDiscountIndex;
  int? streamingIndex;
  int? initialPrice;
  var sellerId;
  var sellerIndex;
  var categoryId;
  var subcategoryId;
  var subsubcategoryId;
  var isFilterApply;
  var brandId;
  var brandIndex;
  bool? isLive;


  FilterCampaignData({
    this.title,
    this.lowestPrice,
    this.highestPrice,
    this.selectedRating,
    this.selectedStreaming,
    this.selectedCategory,
    this.categoryIndex,
    this.subsubCategoryIndex,
    this.customerRatingIndex,
    this.streamingIndex,
    this.initialPrice,
    this.sellerId,
    this.sellerIndex,
    this.categoryId,
    this.subcategoryId,
    this.isFilterApply,
    this.brandId,
    this.brandIndex,
    this.subsubcategoryId,
    this.customerDiscountIndex,
    this.selectedDiscount,
    this.isLive
  });
}