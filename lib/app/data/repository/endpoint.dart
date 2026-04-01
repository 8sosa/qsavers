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

 const String baseUrl = "https://quantitysavers.com:3001/";
//const String baseUrl="https://staging.quantitysavers.com:3002/";
 const String imageBaseUrl = "https://quantitysavers-live.s3.amazonaws.com/quantitysavers-live/original/";
 const String documentEndPoint = "https://quantitysavers-live.s3.amazonaws.com/quantitysavers-live/documents/";
//const String imageBaseUrl="https://quantitysavers-stag.s3.amazonaws.com/quantitysavers-stag/original/";
//const String documentEndPoint = "https://quantitysavers-stag.s3.amazonaws.com/quantitysavers-stag/documents/";
const String videoBaseUrl =
    "https://quantitysavers-live.s3.amazonaws.com/quantitysavers-live/video/";
// const String videoBaseUrl =
//     "https://quantitysavers-stag.s3.amazonaws.com/quantitysavers-stag/video/";
const String signUpEndPoint = "User/signup";
const String socialLogInEndPoint="User/social_login";
const String secondContactEndPoint = "/vendor/second-contact";
const String locationEndPoint = "/vendor/location";
const String getProfileEndPoint = "User/view_my_profile";
const String addLocationEndPoint = "/vendor/location";
const String adServicesEndPoint = "/vendor/services";
const String getOtherDocListEndPoint = "/vendor/document";
const String getVendorServicesEndPoint = "/vendor/services";
const String loginEndPoint = "User/login";
const String logoutEndPoint = "User/logout";
const String deleteAccountEndPoint = "User/deactivate_account";
const String changePasswordEndPoint = "User/change_password";
const String setPasswordEndPoint = "User/set_password";
const String forgotEndPoint = "User/forgot_password";
const String changePhoneNumberEndPoint = "/vendor/change-phone";
const String changeNameImageEndPoint = "//vendor/profile";
const String verifyOtpEndPoint = "/vendor/verify-email-otp";
const String pgoneOtpVerifyEndPoint = "User/verify/phone_no";
const String verifyForgotOtpEndPoint = "User/forgot_password/verify_otp";
const String resendOtpEndPoint = "User/resend_otp";
const String resendOtpOnPhoneEndPoint = "User/resend/phone_no/otp";
const String resendOtpOnForgotPasswordEndPoint =
    "User/forgot_password/resend_otp";
const String newPasswordOtpEndPoint = "User/forgot_password/set_password";
const String checkEndPoint = "/user/check";
const String getPagesEndPoint = "/user/get-page";
const String profileCompletionEndPoint = "/vendor/profile-completion";
const String editProfileEndPoint = "User/edit_profile";
const String uploadImage = "Upload/do_spaces_file_upload";
const String emailVerification = "User/email_verification";

const String uploadProfileEndPoint = "Upload/do_spaces_file_upload";

const String productBannerEndpoint = "Product/banners";
const String HomePageBannerEndpoint = "Homepage/user/banner";
const String productCategoriesEndpoint = "Product/categories";
const String dealsOfTheDayEndpoint = "Homepage/user/deal_of_the_day";
const String dealsOfTheDayTimerEndpoint = "Homepage/user/deals_day/timer";
const String topDealsEndpoint = "Homepage/user/top_deals";
const String fashionDealsEndpoint = "Homepage/user/fashion_deals";
const String featuredCategoriesEndpoint = "Homepage/user/featured_categories";
const String shopWithUsEndpoint = "Homepage/user/shop_with_us";
const String vendorsEndpoint = "User/sellers";
const String bestOnEcommerceEndpoint = "Homepage/user/best_on_ecom";
const String mainSearchEndpoint = "User/search";
const String vendorsProductDetailsEndpoint = "Product/filters";
const String productDetailsEndpoint = "Product/details";
const String productEndpoint = "Product/";
const String productFaqEndpoint = "User/product/faqs";
const String canReviewEndpoint = "User/review/can_add";
const String addToCartEndpoint = "User/cart";
const String priceDetailsEndpoint = "User/cart/price_details";
const String addressEndPoint = "User/address";
const String deliveryCheckEndPoint = "Product/check/delivery";
const String wishlistEndPoint = "User/wishlist";
const String deleteFromWishlistEndPoint = "User/wishlists/delete";
const String listContent = "/User/list_content";

const String relatedProductsEndpoint = "Product/related";
const String addBankEndpoint = "Stripe/bank";
const String getCountriesEndPoint = "User/country";
const String stripeCards = "Stripe/card";
const String ordersEndPoint = "Order";
const String ordersDetailsEndPoint = "Order/products";
const String createCampaignEndpoint = "User/campaign";
const String getGroupMembersEndpoint = "Group/users";
const String createGroupEndpoint = "Group/create_group";
const String getGroupListEndpoint = "Group/user_groups_list";
const String groupSearchEndpoint = "Group/";
const String getProductCampaignsEndpoint = "User/product/campaign";
const String productCampaigns = "User/product/campaign";
const String groupUserList = "Group/user_groups_list";
const String userCampaign = "User/campaign";
const String userCampaignOrder = "User/campaign_order";
const String getCreatorCampaignList = "User/campaign/creater/list";
const String getCustomerCampaignList = "User/campaign/joined/list";
const String getAllCampaigns = "User/campaign_list";
const String editCampaignEndpoint = "User/campaign";
const String getForumRequestEndpoint = "Group/user/request_list";
const String manageForumRequestEndpoint = "Group/manage_request";
const String getRequestStatusEndpoint = "Group/request";
const String getRequestChatHistoryEndpoint = "Group/request/chat_history";
const String getGroupChatHistoryEndpoint = "Group/chat/history";
const String exitGroupEndpoint = "Group/leave_group";
const String manageMemberEndpoint = "Group/edit/members";
const String groupJoinEndpoint = "Group/join";
const String updateGroupEndpoint = "Group/edit";
const String ReportUserEndpoint = "User/report";
const String getOrderListEndPoint = "Order";
const String cancelOrder = "Order/cancel";
const String userReviewEndPoint = "User/review";
const String userProductReviewEndPoint = "User/review/my";
const String contactUsEndpoint = "User/contact_us";
const String profileFAQEndpoint = "Product/faqs";
const String campaignRequestEndpoint = "User/campaign_request";
const String deleteAddressEndPoint = "User/address/delete/";
const String deleteBankAccountEndPoint="Stripe/bank/";
const String availableCoupons="User/coupons";
const String expiredCoupons="User/coupons/expired";
const String applyCoupons="Order/coupon/availablity";
const String canAddReviewEndPoint="User/review/can_add";
const String userReviewListEndPoint="User/review/my";
const String userReviewDeleteEndPoint="User/review/delete/";
const String editReviewEndPoint="User/review";
const String campaignFilterEndPoint="User/campaign_list/filter";
const String downloadInvoiceEndPoint="Order/invoice/detail/";
const String usernotificationsEndPoint="User/notifications";
const String agoraLiveTokenEndPoint="User/campaign-live-token";
const String VendorSearchEndPoint="User/sellers";
const String addMemberEndPoint="Group/users";
const String productSubCategoriesEndPoint="Product/subcategories";
const String productSubSubCategoriesEndPoint="Product/sub_subcategories";
const String scheduleCampaignLiveBroadCastEndPoint="User/campaign/";
const String getScheduleLiveBroadCastEndPoint="User/campaign-live-scheduel";
const String userEarningEndPoint="User/earning/list";
const String payOutEndPoint = "User/payout-claim";
const String messageDelieverdEndPoint="Group/message/";
const String likeProductFaq="User/product/faqs/like-dislike";
const String brandListEndPoint="Product/brands";
const String mediaReviewsEndPoint="Product/media/reviews";
const String orderCancellationRequestEndPoint="Order/cancellation/request";
const String productReviewEndPoint="User/product/review/like-dislike";
const String allCategoriesEndPoint="User/categories_list";
const String flwPayPalContactAdminEndPoint="User/flw-paypal-bank";

//type const
const typeActive = 0;
const typeUpcoming = 1;
const typeCompleted = 2;
const typeCancelled = 3;
const typeRequested = 4;
const typePersonalInfo = 0;
const typeServiceInfo = 1;
const typeContactInfo = 2;
const typeLogoutInfo = 3;
const typeTradeLicence = 0;
const typeInsurance = 1;
const typeVatCertificate = 2;
const typeOtherDoc = 3;
const typeDescription = 4;
