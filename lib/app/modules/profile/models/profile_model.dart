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

import "../../../export.dart";

class ProfileModel {
  static final ProfileModel _instance = ProfileModel._internal();

  factory ProfileModel() {
    return _instance;
  }

  ProfileModel._internal();

  List<Map<String, dynamic>> profileCustomerList = [
    {
      "type": "Customer",
      "icon": iconsPersonalInformation,
      "name": "My Profile",
      "path": AppRoutes.personalInfoRoute
    },
    {
      "type": "Customer",
      "icon": iconsOrders,
      "name": "My Orders",
      "path": AppRoutes.ordersScreenRoute
    },
    {
      "type": "Customer",
      "icon": iconsCoupons,
      "name": "Coupons",
      "path": AppRoutes.couponScreenRoute
    },
    {
      "type": "Customer",
      "icon": iconsProfileCampaign,
      "name": "Campaigns",
      "path": AppRoutes.campaignsScreenRoute
    },
    {
      "type": "Customer",
      "icon": iconsManageAddress,
      "name": "Manage Addresses",
      "path": AppRoutes.manageAddressRoute
    },
    {
      "type": "Customer",
      "icon": iconsPayments,
      "name": "Payments",
      "path": AppRoutes.paymentRoute
    },
    {
      "type": "Customer",
      "icon": iconsStar,
      "name": "My Reviews & Ratings",
      "path": AppRoutes.reviewsAndRatingsRoute
    },
    {
      "type": "Customer",
      "icon": iconsHeart,
      "name": "My Wishlist",
      "path": AppRoutes.wishlistRoute
    },
  ];

  List<Map<String, dynamic>> profileCreatorList = [
    {
      "type": "Creator",
      "icon": iconsProfileCampaign,
      "name": "Campaigns",
      "path": AppRoutes.campaignsScreenRoute
    },
    {
      "type": "Creator",
      "icon": iconsRequest,
      "name": "Requests",
      "path": AppRoutes.campaignRequestRoute
    },
    {
      "type": "Creator",
      "icon": iconsCreatorBroadcast,
      "name": "Scheduled Live Broadcast",
      "path": AppRoutes.scheduledLiveBroadcastRoute
    },
    {
      "type": "Creator",
      "icon": iconsBank,
      "name": "Bank Account",
      "path": AppRoutes.bankAccountRoute
    },
    {
      "type": "Creator",
      "icon": iconsDolar,
      "name": "Earnings",
      "path": AppRoutes.earningsRoute
    },
  ];

  List<Map<String, dynamic>> profileLegalList = [
    {
      "type": "ProfileLegal",
      "icon": iconsAbout,
      "name": "About Us",
      "path": AppRoutes.aboutUs
    },
    {
      "type": "ProfileLegal",
      "icon": iconsContact,
      "name": "Contact Us",
      "path": AppRoutes.contactUsRoute
    },
    {
      "type": "ProfileLegal",
      "icon": iconsFaq,
      "name": "FAQ's",
      "path": AppRoutes.allFAQsScreenRoute
    },
    {
      "type": "ProfileLegal",
      "icon": iconsTermAndCondition,
      "name": "Terms & Conditions",
      "path": AppRoutes.termsAndConditions
    },
    {
      "type": "ProfileLegal",
      "icon": iconsPrivacyPolicy,
      "name": "Privacy Policy",
      "path": AppRoutes.privacyPolicy
    },
    {"type": "ProfileLegal", "icon": iconsRate, "name": "Rate Us"},
  ];

  List<Map<String, dynamic>> profileAccountList = [
    {
      "icon": iconsDeactivate,
      "name": "Delete Account",
      "colors": Colors.black,
      "path": AppRoutes.deleteAccountRoute
    },
    {"icon": iconsLogout, "name": "Logout", "color": AppColors.titleRed},
  ];
}
