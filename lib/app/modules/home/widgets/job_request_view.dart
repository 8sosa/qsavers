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

class JobRequestView extends StatelessWidget {
  bool? buttonsEnabled;
  bool? buttonOutlined;
  String? title;
  String? stateTxt;
  Color? stateColor;
  Color? stateTxtColor;
  final detailTap;
  JobRequestView({super.key, this.buttonsEnabled=true,this.buttonOutlined=false,this.title,this.stateTxt,this.stateColor,this.stateTxtColor,this.detailTap});

  final themeController=Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(children: [
      _stateProfileView(),
      _textView(title: 'Location:',subTxt: '71 Cherry Court Southampton SO...'),
      _textView(title: 'Date & Time:',subTxt: 'Wed, Jun 21 - 05:00PM'),
      _viewDetailButton(),
      buttonsEnabled==true?_acceptRejectButtons():Container()
    ],).paddingSymmetric(vertical: margin_10));
  }

  _stateProfileView(){
    return Row(children: [
      _profileView(),
      stateTxt!=null?_stateTxt():Container()
    ],);
  }


  _profileView(){
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        AssetImageWidget(iconsIcJobProfile,imageHeight: height_45,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(title??'A/C Maintenance',style: textStyleBodyLarge().copyWith(
              fontWeight: FontWeight.w600,
              color: themeController.isDarkMode.value==true?Colors.white:Colors.black,
              fontSize: font_14),).paddingOnly(bottom: margin_3),
          Text('\$57',style: textStyleBodyLarge().copyWith(fontWeight: FontWeight.w600,color: Colors.grey.shade600),),
        ],).paddingOnly(left: margin_8,)
      ],),
    );
  }

  _stateTxt(){
    return  Container(
      padding: EdgeInsets.symmetric(vertical: margin_5,horizontal: margin_8),
      decoration: BoxDecoration(color: stateColor??AppColors.appColor,borderRadius: BorderRadius.circular(radius_5)),
        child: Text(stateTxt??'Active',style: textStyleBodyLarge().copyWith(fontWeight: FontWeight.w600,color:stateTxtColor),));
  }

  _textView({title,subTxt}){
    return Row(children: [
      Text(title??"",style: textStyleBodyLarge().copyWith(fontWeight: FontWeight.w500,color: Colors.grey.shade600),).paddingOnly(right: margin_3),
      Text(subTxt??"",style: textStyleBodyMedium().copyWith(fontWeight: FontWeight.w600,color: themeController.isDarkMode.value==true?Colors.white:Colors.black,),),

    ],).paddingOnly(top: margin_15);
  }

  _viewDetailButton(){
    return MaterialButtonWidget(
      minHeight: height_42,
      isOutlined:buttonOutlined??false,
      onPressed: detailTap??() {

      },
      buttonBgColor:themeController.isDarkMode.value==true&&buttonOutlined==true?AppColors.appDarkColor:null,
      textColor: buttonOutlined==true?(themeController.isDarkMode.value==true?Colors.white:Colors.black):Colors.black,
      buttonText: "View Detail",
    ).paddingOnly(top: margin_15);
  }


  Widget _acceptRejectButtons() => Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      Expanded(
        child: MaterialButtonWidget(
          onPressed: () {

          },
          isOutlined: true,
          textColor: Colors.red,
          minHeight: height_42,
          buttonText: "Reject",
          buttonBgColor: themeController.isDarkMode.value==true?AppColors.appDarkColor:Colors.white,
          borderColor: AppColors.redColor,
        ),
      ),
      SizedBox(
        width: width_5,
      ),
      Expanded(
        child: MaterialButtonWidget(
          onPressed: () {

          },
          buttonText: "Accept",
          textColor: Colors.white,
          minHeight: height_42,
          buttonBgColor:  AppColors.appGreenColor,
          horizontalPadding: margin_10,
        ),
      ),
    ],
  ).paddingOnly(top: margin_8);

}