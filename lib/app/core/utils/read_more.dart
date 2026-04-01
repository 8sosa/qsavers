import 'package:flutter/cupertino.dart';
import 'package:quantity_savers/app/core/values/app_colors.dart';
import 'package:quantity_savers/app/core/values/app_values.dart';
import 'package:readmore/readmore.dart';

import '../values/text_styles.dart';

class ReadMoreTextWidget extends StatelessWidget {
  final String text;
  final int trimLines;
  final String showMoreText;
  final String showLessText;
  final TextStyle? textStyle;
  final TextStyle? moreStyle;
  final TextStyle? lessStyle;
  final TextAlign? textAlign;

  const ReadMoreTextWidget(
      {super.key,
        required this.text,
        this.trimLines = 3,
        this.textAlign,
        this.showMoreText ="show more" ,
        this.showLessText  ="show less",
        this.textStyle,
      this.moreStyle,this.lessStyle});

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      trimLines: trimLines,
      colorClickableText: AppColors.appColor,
      trimMode: TrimMode.Line,
      trimCollapsedText: showMoreText,
      trimExpandedText: showLessText,
      textAlign: textAlign,
      style: textStyle?? textStyleBodyMedium().copyWith(
          color: AppColors.appColor,
          fontWeight: FontWeight.w500),
      moreStyle:moreStyle?? textStyleBodyMedium().copyWith(
          color: AppColors.gradient2nd,
          fontWeight: FontWeight.w500),
      lessStyle:lessStyle??  textStyleBodyMedium().copyWith(
          color: AppColors.gradient2nd,
          fontWeight: FontWeight.w500),
    );
  }
}