import '../../../export.dart';
import 'countries.dart';
import 'intl_phone_field.dart';

class CountryPickerTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final Color? labelColor;
  final double? labelSize;
  final FocusNode? focusNode;
  final GlobalKey<IntlPhoneFieldState>? pickerKey;
  final String? hintText;
  final String? labelText;
  final TextStyle? inputTextStyle;
  final TextInputType? inputType;
  final TextInputAction? textInputAction;
  final double? contentPadding;
  final double? borderRadius;
  final bool showShadow;
  final bool showCountryFlag;
  final bool readOnly;
  final Widget? suffix;
  final Country? selectedCountry;
  final ValueChanged<Country>? onCountryChanged;

  const CountryPickerTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.label,
      this.labelColor,
      this.labelSize,
      this.pickerKey,
      this.labelText,
      this.inputTextStyle,
      this.contentPadding,
      this.borderRadius,
      this.inputType = TextInputType.text,
      this.textInputAction = TextInputAction.next,
      this.showShadow = false,
      this.showCountryFlag = false,
      this.readOnly = false,
      this.suffix,
      this.focusNode,
      required this.selectedCountry,
      required this.onCountryChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (label != null)
          Text(
            label!,
            style: textStyleBodyMedium().copyWith(
                color: labelColor,
                fontWeight: FontWeight.w500,
                fontSize: labelSize),
          ),
        if (label != null) SizedBox(height: margin_10),
        AbsorbPointer(
          absorbing: readOnly,
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                radius_12,
              )),
              child: IntlPhoneField(
                controller: controller,
                focusNode: focusNode,
                key: pickerKey,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textInputAction: textInputAction,
                invalidNumberMessage: strInvalidNumber,
                emptyFieldMessage: '$strPlsEnterYour phone number',
                decoration: _inputDecoration(),
                dropdownTextStyle: textStyleTitleSmall().copyWith(color: themeController.isDarkMode.value==true?Colors.white:Colors.black),
                showCountryFlag: showCountryFlag,
                style: inputTextStyle ?? textStyleTitleMedium().copyWith(
                    fontWeight: FontWeight.w500,
                    color: themeController.isDarkMode.value == true
                        ? Colors.white
                        : Colors.black,
                    fontSize: font_14),
                initialSelectedCountry: selectedCountry,
                dropdownIconPosition: IconPosition.trailing,
                onCountryChanged: onCountryChanged
              )),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      errorMaxLines: 2,
      hoverColor: AppColors.appBorderDarkColor,
      filled: true,
      isCollapsed: true,
      isDense: true,
      counterText: '',
      contentPadding: EdgeInsets.symmetric(horizontal: margin_15, vertical: margin_15),
      suffixIcon: suffix,
      hintText: hintText,
      hintStyle: textStyleBodyMedium().copyWith(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
              fontSize: font_14),
      labelText: "",
      floatingLabelBehavior: FloatingLabelBehavior.always,
      fillColor: (themeController.isDarkMode.value == true
              ? Colors.black
              : Colors.white),
      border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? radius_10),
              borderSide: BorderSide(
                  color: (themeController.isDarkMode.value == true
                          ? AppColors.appBorderDarkColor
                          : AppColors.textfieldborder))),
      focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? radius_10),
              borderSide: BorderSide(
                  color: (themeController.isDarkMode.value == true
                          ? AppColors.appBorderDarkColor
                          : Colors.red))),
      errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? radius_10),
              borderSide: BorderSide(
                  color: (themeController.isDarkMode.value == true
                          ? AppColors.appBorderDarkColor
                          : Colors.red))),
      focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? radius_10),
              borderSide: BorderSide(
                  color: (themeController.isDarkMode.value == true
                          ? AppColors.appBorderDarkColor
                          : AppColors.textfieldborder))),
      enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? radius_10),
              borderSide: BorderSide(
                  color: (themeController.isDarkMode.value == true
                          ? AppColors.appBorderDarkColor
                          : AppColors.textfieldborder))),
    );
  }
}
