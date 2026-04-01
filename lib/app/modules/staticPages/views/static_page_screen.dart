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

class StaticPageScreen extends GetView<StaticPageController> {
  var themeController=Get.put(ThemeController());

  var text="Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin condimentum fermentum augue quis tempor. Ut nec pulvinar leo. In condimentum porttitor est et aliquet. Maecenas elementum enim vitae lorem accumsan, eu egestas metus posuere. Pellentesque feugiat, massa vitae suscipit feugiat, lorem magna porttitor metus, sit amet maximus massa ligula eget turpis. Praesent facilisis mi erat, ut porttitor leo euismod nec. Nullam ullamcorper arcu et dui porta rhoncus. Praesent in convallis lectus, vel facilisis leo. Interdum et malesuada fames ac ante ipsum primis in faucibus. Donec rutrum orci lacus, vitae pharetra arcu fermentum et.Nullam ante massa, ullamcorper sed fermentum vitae, hendrerit nec massa. Nam et urna massa. Suspendisse potenti. Maecenas vel felis nec urna placerat viverra nec bibendum mi. Mauris maximus nec lectus ac maximus. Ut iaculis placerat vehicula. Mauris in iaculis mi, sed eleifend leo. Nullam ultrices aliquam dui in rhoncus. Etiam eget metus tincidunt, lacinia ante a, condimentum nulla.Integer vitae elit vestibulum, molestie leo ac, rutrum justo. Nullam sodales dolor ac semper consequat. Nullam porta erat et magna elementum, a egestas velit tristique. Quisque non nisl quis ligula aliquam accumsan vulputate eu tortor. In vel cursus enim, a dignissim nunc. Vivamus ac gravida nibh. Aenean tincidunt elit id fermentum pellentesque. Curabitur viverra luctus cursus. Fusce laoreet id risus nec consequat. Suspendisse id pellentesque augue. Sed finibus rutrum ipsum non tincidunt. Ut vel suscipit elit. Donec sem tellus, pulvinar a eleifend a, malesuada id ligula. Integer vehicula placerat dui nec ultrices. Cras felis lacus.";

  StaticPageScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: CustomAppBar(
          isCustom:true,
          appBarTitleText: controller.pageType == pageTypePrivacyPolicy ?
              "Privacy policy":
          controller.pageType ==  pageTypeTerms ? "Term & conditions"  : ""

        ),
        body: SingleChildScrollView(
            child: RichText(
                text: HTML.toTextSpan(
          context,text?? "Data Will Be Available Soon",
          linksCallback: (dynamic link) {
            launchUrl(Uri.parse(link));
          },
          defaultTextStyle: TextStyle(
              color: themeController.isDarkMode.value==true?Colors.grey.shade400:Colors.grey.shade600, fontSize: font_13,
              fontFamily: "WixMadeforDisplay"),
          overrideStyle: <String, TextStyle>{
            "body": TextStyle(
                color: themeController.isDarkMode.value==true?Colors.grey.shade400:Colors.grey.shade600, fontSize: font_15,
                fontFamily: "WixMadeforDisplay")
          },
        )).paddingSymmetric(horizontal: margin_20, vertical: margin_25)));
  }
}
