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

import '../../data/local/preferences/theme_controller.dart';
import '../../export.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hint;
  final String? label;
  final Color? labelColor;
  final double? labelSize;
  final bool canSendEmoji;
  final Color? fillColor;
  final Color? courserColor;
  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? errorBorderColor;
  final dynamic validate;
  final dynamic hintStyle;
  final EdgeInsets? contentPadding;
  final TextInputType? inputType;
  final TextEditingController? textController;
  final FocusNode? focusNode;
  final Function(String value)? onFieldSubmitted;
  final Function()? onTap;
  final TextInputAction? inputAction;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? sufix;
  final int? maxLines;
  final dynamic decoration;
  final double? borderRadius;
  final int? minLine;
  final int? maxLength;
  final bool readOnly;
  final bool? obscureText;
  final TextAlign textAlign;
  final dynamic suffixIconConstraints;
  final Function(String value)? onChange;
  final List<TextInputFormatter>? formatter;
  final String? initialValue;
  final Color? textColor;

  TextFieldWidget(
      {super.key,
      this.hint,
      this.label,
      this.labelColor,
      this.sufix,
      this.labelSize,
      this.inputType,
      this.textController,
      this.hintStyle,
      this.focusBorderColor,
      this.errorBorderColor,
      this.courserColor,
      this.validate,
      this.onChange,
      this.decoration,
      this.focusNode,
      this.readOnly = false,
      this.onFieldSubmitted,
      this.formatter,
      this.inputAction,
      this.contentPadding,
      this.maxLines,
      this.minLine,
      this.maxLength,
      this.fillColor,
      this.suffixIcon,
      this.prefixIcon,
      this.suffixIconConstraints,
      this.obscureText,
      this.onTap,
      this.borderColor,
      this.borderRadius,
      this.textAlign = TextAlign.start,
      this.initialValue,
        this.textColor,
      this.canSendEmoji = false});

  var themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: textStyleBodyMedium().copyWith(
                color: labelColor,
                fontWeight: FontWeight.w500,
                fontSize: labelSize),
          ),
        if (label != null) SizedBox(height: margin_10),
        TextFormField(
            initialValue: initialValue,
            textAlign: textAlign,
            readOnly: readOnly,
            onTap: onTap,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: obscureText ?? false,
            controller: textController,
            focusNode: focusNode,
            keyboardType: inputType,
            maxLength: maxLength,
            onChanged: onChange,
            cursorColor: courserColor ?? AppColors.appBorderDarkColor,
            inputFormatters: formatter ??
                [
                  FilteringTextInputFormatter(
                      RegExp(
                          '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                      allow: canSendEmoji)
                ],
            maxLines: maxLines ?? 1,
            minLines: minLine ?? 1,
            obscuringCharacter: "*",
            textInputAction: inputAction,
            onFieldSubmitted: onFieldSubmitted,
            validator: validate,
            style: textStyleTitleMedium().copyWith(
                fontWeight: FontWeight.w500,
                color: themeController.isDarkMode.value == true
                    ? Colors.white
                    : (textColor ?? Colors.black),
                fontSize: font_14),
            decoration: inputDecoration()),
      ],
    );
  }

  inputDecoration() => InputDecoration(
        errorMaxLines: 4,
        hoverColor: AppColors.appBorderDarkColor,
        filled: true,
        isCollapsed: true,
        isDense: true,
        counterText: '',
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(horizontal: margin_15, vertical: margin_15),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        suffix: sufix,
        hintText: hint,
        hintStyle: hintStyle ??
            textStyleBodyMedium().copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w400,
                fontSize: font_14),
        labelText: "",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        fillColor: fillColor ??
            (themeController.isDarkMode.value == true
                ? Colors.black
                : Colors.white),
        border: decoration ??
            OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? radius_10),
                borderSide: BorderSide(
                    color: borderColor ??
                        (themeController.isDarkMode.value == true
                            ? AppColors.appBorderDarkColor
                            : AppColors.textfieldborder))),
        focusedErrorBorder: decoration ??
            OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? radius_10),
                borderSide: BorderSide(
                    color: errorBorderColor ??
                        (themeController.isDarkMode.value == true
                            ? AppColors.appBorderDarkColor
                            : Colors.red))),
        errorBorder: decoration ??
            OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? radius_10),
                borderSide: BorderSide(
                    color: errorBorderColor ??
                        (themeController.isDarkMode.value == true
                            ? AppColors.appBorderDarkColor
                            : Colors.red))),
        focusedBorder: decoration ??
            OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? radius_10),
                borderSide: BorderSide(
                    color: focusBorderColor ??
                        (themeController.isDarkMode.value == true
                            ? AppColors.appBorderDarkColor
                            : AppColors.textfieldborder))),
        enabledBorder: decoration ??
            OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? radius_10),
                borderSide: BorderSide(
                    color: focusBorderColor ??
                        (themeController.isDarkMode.value == true
                            ? AppColors.appBorderDarkColor
                            : AppColors.textfieldborder))),
      );
}

