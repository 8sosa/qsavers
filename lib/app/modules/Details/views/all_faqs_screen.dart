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

import 'package:quantity_savers/app/modules/Details/controllers/all_faqs_controller.dart';

import '../../../export.dart';

class AllFAQsScreen extends StatelessWidget {
  final controller = Get.put(AllFAQsController());
  final themeController = Get.put(ThemeController());

  AllFAQsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllFAQsController>(
        init: AllFAQsController(),
        builder: (context) {
          return Shimmer(
            child: Scaffold(
              appBar: CustomAppBar(appBarTitleText: strFaq),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [_questionAnswerList()],
                ),
              ),
            ),
          );
        });
  }

  _questionAnswerList() => ShimmerLoading(
        isLoading: controller.isLoading,
        isImage: true,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: controller.profileFaqResponseModel.data?.totalCount ?? 0,
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return _questionAnswers(index);
          },
        ),
      );

  _questionAnswers(int index) {
    var item = controller.profileFaqResponseModel.data?.data;
    return ExpansionTile(
      shape: const Border(),
      expandedAlignment: Alignment.bottomLeft,
      iconColor: AppColors.gradientColorPrimary,
      collapsedIconColor: AppColors.categoriesgrey,
      trailing: const Icon(
        Icons.add_circle_outline,
        size: 22,
      ),
      title: TextView(
        text: "Q. ${item?[index].question}",
        textStyle: textStyleBodyMedium().copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: font_12),
      ),
      children: [
        TextView(
          text: "A. ${removeAllHtmlTags(item?[index].answer)}",
          textStyle: textStyleBodyMedium().copyWith(
              color: AppColors.categoriesgrey,
              fontWeight: FontWeight.w600,
              fontSize: font_12),
        ).marginOnly(left: margin_16),
      ],
    );
  }
}
