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

import '../../../export.dart';

class MainScreen extends StatelessWidget {
  final controller = Get.put(MainController());
  final themeController = Get.put(ThemeController());

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      child: GetBuilder<MainController>(
          init: MainController(),
          builder: (controller) {
            return Scaffold(
                appBar: controller.selectedIndex == 0
                    ? CustomAppBar(
                        appBarTitleText:
                            " ${strApplicationName.toUpperCase()}.",
                        titleFontSize: font_24,
                        titleFontWeight: FontWeight.w400,
                        isLeadingPresent: false,
                        isTitleCenter: false,
                        titleFontFamily: "Impact",
                        actionWidget: [
                          Stack(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'This is the home screen. Here you can see listing of the..'),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              content: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    _buildRowWithBulletPoint(
                                                        'Banners: Promoting the latest products, sales, or campaigns. Redirecting to associated products, sales or campaigns details. There are three options to set banner (Top, middle, and bottom).'),
                                                    _buildRowWithBulletPoint(
                                                        'Deals of the Day: Display of limited-time offers with product images, names, prices, original prices (if discounted), with countdown timer.'),
                                                    _buildRowWithBulletPoint(
                                                        'Campaign (Ongoing campaigns): Display of ongoing or upcoming campaigns with key details such as campaign name, discount percentage, group size requirement, and participation progress.'),
                                                    _buildRowWithBulletPoint(
                                                        'Featured Categories of the Week: Brief descriptions or highlights of what users can find in each category.'),
                                                    _buildRowWithBulletPoint(
                                                        'The Popular sellers section showcases the most reputable and favoured sellers on the Quantity savers platform. This section helps build trust and guides users to explore products from vendors who consistently deliver quality and satisfaction.')
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(); // Close the dialog
                                                  },
                                                  child: const Text(
                                                    'Close',
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .gradient2nd),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.help_outline,
                                        color: Colors.white,
                                        size: 28,
                                      )),
                                  IconButton(
                                    onPressed: () {
                                      // Get.back();
                                    },
                                    icon: InkWell(
                                      onTap: () {
                                        controller.handleNotifications();
                                      },
                                      child: AssetSVGWidget(
                                        iconsNotifications,
                                        imageHeight: height_24,
                                      ),
                                    ),
                                  ).paddingOnly(right: margin_10),
                                ],
                              ),
                              if (controller.userNotificationResponseModel.data
                                          ?.unreadCount !=
                                      0 &&
                                  controller.userNotificationResponseModel.data
                                          ?.unreadCount !=
                                      null) ...[
                                Positioned(
                                  right: 15,
                                  top: 2,
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${(controller.userNotificationResponseModel != null && controller.userNotificationResponseModel.data != null && controller.userNotificationResponseModel.data!.unreadCount != null && controller.userNotificationResponseModel.data!.unreadCount! > 9) ? '9+' : controller.userNotificationResponseModel?.data?.unreadCount ?? ''}', // Replace '5' with the number you want to display
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      )
                    : null,
                body: Center(
                  child: controller.pages[controller.selectedIndex].view,
                ),
                bottomNavigationBar: _bottomNavigation());
          }),
    );
  }

  _bottomNavigation() => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColors.gradient1st, AppColors.gradient2nd],
              begin: Alignment.centerLeft),
        ),
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
                  backgroundColor: Colors.transparent,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: AssetSVGWidget(
                          iconsHome,
                          color: controller.selectedIndex == 0
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                        ),
                        label: strHome),
                    BottomNavigationBarItem(
                      icon: AssetSVGWidget(
                        iconsCampaign,
                        color: controller.selectedIndex == 1
                            ? Colors.white
                            : Colors.white.withOpacity(0.5),
                      ),
                      label: strCampaigns,
                    ),
                    BottomNavigationBarItem(
                      icon: Stack(
                        clipBehavior: Clip.none,
                          children: [
                        AssetSVGWidget(
                          iconsForum,
                          color: controller.selectedIndex == 2
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                        ),
                       Obx(()=> (unreadCount.value != 0)
                            ? Positioned(
                                right: -20,
                                top:-10,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Obx(
                                      () => Text(
                                        unreadCount.value > 9 ? "9+" :"${unreadCount.value}",
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : emptySizeBox(),
                       )]),
                      label: strForums,
                    ),
                    BottomNavigationBarItem(
                      icon: AssetSVGWidget(
                        iconsAccountCircle,
                        color: controller.selectedIndex == 3
                            ? Colors.white
                            : Colors.white.withOpacity(0.5),
                      ),
                      label: strProfile,
                    ),
                  ],
                  type: BottomNavigationBarType.fixed,
                  currentIndex: controller.selectedIndex,
                  unselectedFontSize: font_13,
                  selectedFontSize: font_13,
                  selectedIconTheme: const IconThemeData(color: Colors.white),
                  selectedItemColor: Colors.white,
                  iconSize: height_30,
                  unselectedItemColor: Colors.white.withOpacity(0.5),
                  unselectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.5),
                      fontSize: font_12),
                  selectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: font_12,
                  ),
                  onTap: controller.onItemTapped,
                  elevation: elevation_0)
              .paddingOnly(top: margin_12),
        ),
      );

  Widget _buildRowWithBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Icon(Icons.circle, size: 12),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              text,
            ),
          ),
        ],
      ),
    );
  }
}
