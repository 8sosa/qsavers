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

import '../../export.dart';

class DropDownTextFieldWidget extends StatelessWidget {
  final String? hint;
  final dynamic selectedValue;
  final dynamic validate;
  final dynamic hintStyle;
  final dynamic labelTextStyle;
  final Color? borderColor;
  final EdgeInsets? contentPadding;
  final Function(dynamic value)? onFieldSubmitted;
  final bool? isShadow;
  final List itemsList;
  final Color? dropDownColor;
  final Color? selectedValueColor;
  final Color? arrowColor;
  final TextStyle? selectedItemTextStyle;
  final iconRightPadding;
  final bool? Quantity;
  final double? height;

  const DropDownTextFieldWidget(
      {super.key,
      this.hint,
      this.selectedValue,
      this.hintStyle,
      this.labelTextStyle,
      this.selectedItemTextStyle,
      this.validate,
      this.iconRightPadding,
      this.arrowColor,
      this.onFieldSubmitted,
      this.itemsList = const [],
      this.contentPadding,
      this.dropDownColor,
      this.selectedValueColor,
      this.isShadow = false,
      this.borderColor,
      this.Quantity = false,
      this.height});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      decoration: const InputDecoration(
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 1),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white))),
      validator: validate,
      items: itemsList
          .map(
            (item) => DropdownMenuItem<dynamic>(
              value: item,
              child: Quantity == true
                  ? TextView(
                      text:
                          item == selectedValue ? 'Quantity: $item' : item,
                      textStyle: selectedItemTextStyle ??
                          textStyleTitleMedium().copyWith(
                            fontWeight: FontWeight.w600,
                            color: selectedValueColor ?? Colors.black,
                            fontSize: font_13,
                          ),
                    )
                  : TextView(
                      text: item,
                      textStyle: selectedItemTextStyle ??
                          textStyleTitleMedium().copyWith(
                            fontWeight: FontWeight.w600,
                            color: selectedValueColor ?? Colors.black,
                            fontSize: font_13,
                          ),
                    ),
            ),
          )
          .toList(),
      onChanged: onFieldSubmitted,
      value: selectedValue != '' ? selectedValue : null,
      isExpanded: true,
      isDense: false,
      hint: TextView(
        text: hint ?? "",
        textStyle: textStyleBodyMedium().copyWith(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w400,
            fontSize: font_14),
      ),
      iconStyleData: IconStyleData(
          icon: AssetSVGWidget(iconsDropDownArrow,
                  color: arrowColor ?? (AppColors.greyColor))
              .paddingOnly(right: iconRightPadding ?? margin_15)),
      dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius_12),
          ),
          scrollbarTheme: ScrollbarThemeData(
            radius: Radius.circular(radius_12),
            thickness: MaterialStateProperty.all(2),
            thumbVisibility: MaterialStateProperty.all(true),
          )),
      buttonStyleData: ButtonStyleData(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius_10),
            border: Border.all(color: AppColors.textfieldborder)),
        height: height ?? 52,
      ),
    );
  }
}
