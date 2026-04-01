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

import 'package:quantity_savers/app/export.dart';
import 'package:quantity_savers/app/modules/Details/bindings/all_faqs_binding.dart';
import 'package:quantity_savers/app/modules/Details/bindings/delete_campaign_binding.dart';
import 'package:quantity_savers/app/modules/Details/bindings/exit_campaign_binding.dart';
import 'package:quantity_savers/app/modules/Details/bindings/reviewDetails_binding.dart';
import 'package:quantity_savers/app/modules/Details/views/all_faqs_screen.dart';
import 'package:quantity_savers/app/modules/Details/views/all_product_faq.dart';
import 'package:quantity_savers/app/modules/Details/views/delete_camapign_screen.dart';
import 'package:quantity_savers/app/modules/Details/views/exit_campaign.dart';
import 'package:quantity_savers/app/modules/Details/views/reviewDetails_Screen.dart';
import 'package:quantity_savers/app/modules/bank/bindings/add_bank_account_binding.dart';
import 'package:quantity_savers/app/modules/bank/bindings/bank_account_binding.dart';
import 'package:quantity_savers/app/modules/bank/views/add_bank_account_screen.dart';
import 'package:quantity_savers/app/modules/bank/views/bank_account_screen.dart';
import 'package:quantity_savers/app/modules/campaigns/binding/compaigns_binding.dart';
import 'package:quantity_savers/app/modules/campaigns/views/compaigns_screen.dart';
import 'package:quantity_savers/app/modules/forums/bindings/report_binding.dart';
import 'package:quantity_savers/app/modules/forums/views/report_screen.dart';
import 'package:quantity_savers/app/modules/home/bindings/sub_category_bindings.dart';
import 'package:quantity_savers/app/modules/home/views/sub_category_screen.dart';
import 'package:quantity_savers/app/modules/live_streaming/live_stream_binding.dart';
import 'package:quantity_savers/app/modules/live_streaming/live_stream_screen.dart';
import 'package:quantity_savers/app/modules/profile/bindings/campaign_request_details_binding.dart';
import 'package:quantity_savers/app/modules/profile/bindings/coupon_bindings.dart';
import 'package:quantity_savers/app/modules/profile/bindings/earnings_bindings.dart';
import 'package:quantity_savers/app/modules/profile/bindings/profile_request_binding.dart';
import 'package:quantity_savers/app/modules/profile/views/campaign_request_details_screen.dart';
import 'package:quantity_savers/app/modules/profile/views/earnings_screen.dart';
import 'package:quantity_savers/app/modules/profile/views/profile_request_screen.dart';
import 'package:quantity_savers/app/modules/profile/views/terms_conditions_privacy_policy_screen.dart';

import '../modules/Details/bindings/all_product_faq_binding.dart';
import '../modules/Details/bindings/campaign_filter_binding.dart';
import '../modules/Details/bindings/reviewVideosAndImages_binding.dart';
import '../modules/Details/bindings/viewAllReviews_binding.dart';
import '../modules/Details/views/campaign_filter_screen.dart';
import '../modules/Details/views/reviewVideosAndImages_screen.dart';
import '../modules/Details/views/viewAllReviews_screen.dart';
import '../modules/forums/bindings/forum_media_bindings.dart';
import '../modules/forums/views/forum_media_screen.dart';
import '../modules/profile/bindings/terms_conditions_privacy_policy_binding.dart';
import '../modules/profile/views/coupon_screen.dart';

class AppPages {
  static const INITIAL = AppRoutes.splashRoute;

  static final routes = [
    GetPage(
      name: AppRoutes.splashRoute,
      page: () => const SplashScreen(),
      bindings: [SplashBinding()],
    ),
    GetPage(
      name: AppRoutes.loginRoute,
      page: () => LoginScreen(),
      bindings: [LoginBinding()],
    ),
    GetPage(
      name: AppRoutes.forgotPasswordRoute,
      page: () => ForgotPasswordScreen(),
      bindings: [ForgotPasswordBinding()],
    ),
    GetPage(
      name: AppRoutes.signupRoute,
      page: () => SignUpScreen(),
      bindings: [SignUpBinding()],
    ),
    GetPage(
      name: AppRoutes.otpVerificationRoute,
      page: () => OtpVerificationScreen(),
      bindings: [OtpVerificationBinding()],
    ),
    GetPage(
      name: AppRoutes.campaignFilterRoute,
      page: () => CampaignFilterScreen(),
      bindings: [CampaignFiltersBinding()],
    ),
    GetPage(
      name: AppRoutes.verifiedScreenRoute,
      page: () => VerifiedScreen(),
      bindings: [VerifiedBinding()],
    ),
    GetPage(
      name: AppRoutes.forumMediaRoute,
      page: () => ForumMediaScreen(),
      bindings: [ForumMediaBinding()],
    ),
    GetPage(
      name: AppRoutes.setPasswordRoute,
      page: () => SetPasswordScreen(),
      bindings: [SetPasswordBinding()],
    ),
    GetPage(
      name: AppRoutes.homeRoute,
      page: () => HomeScreen(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: AppRoutes.mainScreenRoute,
      page: () => MainScreen(),
      bindings: [MainBinding()],
    ),
    GetPage(
      name: AppRoutes.subCategoryRoute,
      page: () =>SubCategoryScreen(),
      bindings: [SubCategoryBindings()],
    ),
    GetPage(
      name: AppRoutes.searchOnHomeScreenRoute,
      page: () => SearchOnHomeScreen(),
      bindings: [SearchOnHomeBinding()],
    ),
    GetPage(
      name: AppRoutes.viewAllProductsScreenRoute,
      page: () => ViewAllProductsScreen(),
      bindings: [ViewAllProductBinding()],
    ),
    GetPage(
      name: AppRoutes.allFAQsScreenRoute,
      page: () => AllFAQsScreen(),
      bindings: [AllFAQsBinding()],
    ),
    GetPage(
      name: AppRoutes.allProductFAQsScreenRoute,
      page: () => AllProductFAQsScreen(),
      bindings: [AllProductFAQsBinding()],
    ),
    GetPage(
      name: AppRoutes.viewAllCampaignsScreenRoute,
      page: () => ViewAllCompaignsScreen(),
      bindings: [ViewAllCompaignsBinding()],
    ),
    GetPage(
      name: AppRoutes.viewAllVendorsScreenRoute,
      page: () => ViewAllVendorsScreen(),
      bindings: [ViewAllVendorsBinding()],
    ),
    GetPage(
      name: AppRoutes.viewAllCampaignListScreenRoute,
      page: () => ViewAllCampaignListScreen(),
      bindings: [ViewAllCampaignsListBinding()],
    ),
    GetPage(
      name: AppRoutes.aboutCampaignScreenRoute,
      page: () => AboutCampaignScreen(),
      bindings: [AboutCampaignBinding()],
    ),
    GetPage(
      name: AppRoutes.filterCampaignsScreenRoute,
      page: () => FiltersScreen(),
      bindings: [FiltersBinding()],
    ),
    GetPage(
      name: AppRoutes.vendorsProductsScreenRoute,
      page: () => VendorsProductsScreen(),
      bindings: [VendorsProductsBinding()],
    ),
    GetPage(
      name: AppRoutes.productsDetailsScreenRoute,
      page: () => ProductDetailsScreen(tag: DateTime.now().millisecondsSinceEpoch.toString()),
      bindings: [ProductDetailsBinding()],
    ),
    GetPage(
      name: AppRoutes.requestCampaignScreenRoute,
      page: () => RequestCampaignScreen(),
      bindings: [RequestCampaignBinding()],
    ),
    GetPage(
      name: AppRoutes.notificationRoute,
      page: () => NotificationScreen(),
      bindings: [NotificationBinding()],
    ),
    GetPage(
      name: AppRoutes.contactUsRoute,
      page: () => ContactUsScreen(),
      bindings: [ContactUsBinding()],
    ),
    GetPage(
      name: AppRoutes.submitFormRoute,
      page: () => SubmitFormScreen(),
      bindings: [SubmitFormBinding()],
    ),
    GetPage(
      name: AppRoutes.startCampaignScreenRoute,
      page: () => StartCampaignScreen(),
      bindings: [StartCampaignBinding()],
    ),
    GetPage(
      name: AppRoutes.startCampaignSecondScreenRoute,
      page: () => StartCampaignSecondScreen(),
      bindings: [StartCampaignSecondBinding()],
    ),
    GetPage(
      name: AppRoutes.checkoutItemScreenRoute,
      page: () => CheckoutItemScreen(),
      bindings: [CheckoutItemBinding()],
    ),
    GetPage(
      name: AppRoutes.orderPlacedScreenRoute,
      page: () => OrderPlacedScreen(),
      bindings: [OrderplacedBinding()],
    ),
    GetPage(
      name: AppRoutes.staticPageRoute,
      page: () => StaticPageScreen(),
      bindings: [StaticPageBinding()],
    ),
    GetPage(
      name: AppRoutes.profileView,
      page: () => ProfileScreen(),
      bindings: [ProfileBinding()],
    ),
    GetPage(
      name: AppRoutes.campaignDetailsScreenRoute,
      page: () => CampaignDetailsScreen(),
      bindings: [CampaignDetailsBinding()],
    ),
    GetPage(
      name: AppRoutes.personalInfoRoute,
      page: () => PersonalInformationScreen(),
      bindings: [PersonalInformationBinding()],
    ),
    GetPage(
      name: AppRoutes.editProfileScreenRoute,
      page: () => EditProfileScreen(),
      bindings: [EditProfileBinding()],
    ),
    GetPage(
      name: AppRoutes.changePasswordRoute,
      page: () => ChangePasswordScreen(),
      bindings: [ChangePasswordBinding()],
    ),
    GetPage(
      name: AppRoutes.scheduledLiveBroadcastRoute,
      page: () => ScheduledLiveBroadcastScreen(),
      bindings: [ScheduledLiveBroadcastBinding()],
    ),
    GetPage(
      name: AppRoutes.manageAddressRoute,
      page: () => ManageAddressScreen(),
      bindings: [ManageAddressBinding()],
    ),
    GetPage(
      name: AppRoutes.addNewAddressRoute,
      page: () => AddNewAddressScreen(),
      bindings: [AddNewAddressBinding()],
    ),
    GetPage(
      name: AppRoutes.paymentRoute,
      page: () => PaymentScreen(),
      bindings: [PaymentBinding()],
    ),
    GetPage(
      name: AppRoutes.addPaymentRoute,
      page: () => AddNewCardScreen(),
      bindings: [AddNewCardBinding()],
    ),
    GetPage(
      name: AppRoutes.reviewsAndRatingsRoute,
      page: () => ReviewsAndRatingsScreen(),
      bindings: [ReviewsAndRatingsBinding()],
    ),
    GetPage(
      name: AppRoutes.editReviewsAndRatingsRoute,
      page: () => EditReviewsAndRatingsScreen(),
      bindings: [EditReviewsAndRatingsBinding()],
    ),
    GetPage(
      name: AppRoutes.wishlistRoute,
      page: () => WishlistScreen(),
      bindings: [WishlistBinding()],
    ),
    GetPage(
      name: AppRoutes.earningsRoute,
      page: () => EarningsScreen(),
      bindings: [EarningsBinding()],
    ),
    GetPage(
      name: AppRoutes.forumsRoute,
      page: () => ForumsScreen(),
      bindings: [ForumsBinding()],
    ),
    GetPage(
      name: AppRoutes.forumsChatRoute,
      page: () => ForumsChatScreen(),
      bindings: [ForumsChatBinding()],
    ),
    GetPage(
      name: AppRoutes.seeAllMembersScreenRoute,
      page: () => SeeAllMembersScreen(),
      bindings: [SeeAllMembersBinding()],
    ),
    GetPage(
      name: AppRoutes.createGroupRoute,
      page: () => CreateGroupScreen(),
      bindings: [CreateGroupBinding()],
    ),
    GetPage(
      name: AppRoutes.groupInfoRoute,
      page: () => GroupInfoScreen(),
      bindings: [GroupInfoBinding()],
    ),
    GetPage(
      name: AppRoutes.ordersScreenRoute,
      page: () => OrdersScreen(),
      bindings: [OrdersBinding()],
    ),
    GetPage(
      name: AppRoutes.couponScreenRoute,
      page: () => CouponScreen(),
      bindings: [CouponBinding()],
    ),
    GetPage(
      name: AppRoutes.cancelOrderPlacedScreenRoute,
      page: () => CancelOrderPlacedScreen(),
      bindings: [CancelOrdersBinding()],
    ),
    GetPage(
      name: AppRoutes.viewRequestsRoute,
      page: () => ViewRequestsScreen(),
      bindings: [ViewRequestsBinding()],
    ),
    GetPage(
      name: AppRoutes.campaignsScreenRoute,
      page: () => CampaignsScreen(),
      bindings: [CampaignsBinding()],
    ),
    GetPage(
      name: AppRoutes.deleteAccountRoute,
      page: () => DeleteAccountScreen(),
      bindings: [DeleteAccountBinding()],
    ),
    GetPage(
      name: AppRoutes.bankAccountRoute,
      page: () => BankAccountScreen(),
      bindings: [BankAccountBinding()],
    ),
    GetPage(
      name: AppRoutes.addBankRoute,
      page: () => AddBankAccountScreen(),
      bindings: [AddBankAccountBinding()],
    ),
    GetPage(
      name: AppRoutes.deleteCampaignScreenRoute,
      page: () => DeleteCampaignScreen(),
      bindings: [DeleteCampaignBinding()],
    ),
    GetPage(
      name: AppRoutes.exitCampaignScreenRoute,
      page: () => ExitCampaignScreen(),
      bindings: [ExitCampaignBinding()],
    ),
    GetPage(
      name: AppRoutes.termsAndConditions,
      page: () => TermsCondAndPvtPolicy(),
      bindings: [TermsConditionsPrivacyPolicyBinding()],
    ),
    GetPage(
      name: AppRoutes.privacyPolicy,
      page: () => TermsCondAndPvtPolicy(),
      bindings: [TermsConditionsPrivacyPolicyBinding()],
    ),
    GetPage(
      name: AppRoutes.aboutUs,
      page: () => TermsCondAndPvtPolicy(),
      bindings: [TermsConditionsPrivacyPolicyBinding()],
    ),
    GetPage(
      name: AppRoutes.reportMember,
      page: () => ReportMember(),
      bindings: [ReportMemberBinding()],
    ),
    GetPage(
      name: AppRoutes.campaignRequestRoute,
      page: () => ProfileRequestScreen(),
      bindings: [ProfileRequestBinding()],
    ),
    GetPage(
      name: AppRoutes.campaignRequestDetailsRoute,
      page: () => CampaignRequestDetailsScreen(),
      bindings: [CampaignRequestDetailsBinding()],
    ),
    GetPage(
      name: AppRoutes.viewAllReviewsScreenRoute,
      page: () => ViewAllReviewsScreen(),
      bindings: [ViewAllReviewsBinding()],
    ),
    GetPage(
      name: AppRoutes.reviewVideosAndImagesScreenRoute,
      page: () => ReviewVideosAndImagesScreen(),
      bindings: [ReviewVideosAndImageBinding()],
    ),
    GetPage(
      name: AppRoutes.reviewsDetailsScreenRoute,
      page: () => ReviewsDetailsScreen(),
      bindings: [ReviewDetailsBinding()],
    ),
    GetPage(
      name: AppRoutes.liveStreamingRoute,
      page: () => LiveScreen(),
      bindings: [LiveStreamBinding()],
    ),
  ];
}
