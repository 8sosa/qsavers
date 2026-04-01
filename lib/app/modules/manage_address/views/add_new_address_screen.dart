import "package:quantity_savers/app/core/widget/googleplacepicker/google_place_picker.dart";
import "package:quantity_savers/app/core/widget/googleplacepicker/place_autoComplete_model.dart";
import "package:quantity_savers/app/core/widget/googleplacepicker/place_details_model.dart";

import "../../../export.dart";

class AddNewAddressScreen extends StatelessWidget {
  final themeController = Get.put(ThemeController());
  final controller = Get.put(AddNewAddressController());

  AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddNewAddressController>(
      init: AddNewAddressController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      colors: [AppColors.gradient1st, AppColors.gradient2nd])),
            ),
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                Get.back(result: false);
              },
              icon: const AssetSVGWidget(iconsAppBarback),
            ),
            centerTitle: true,
            title: controller.isRouteForEditManageAddress
                ? Text(
                    "EDIT ADDRESS",
                    style: TextStyle(
                        fontSize: font_16, fontWeight: FontWeight.w600),
                  )
                : Text(
                    strAddNewAddress.toUpperCase(),
                    style: TextStyle(
                        fontSize: font_16, fontWeight: FontWeight.w600),
                  ),
          ),
          body: controller.isRouteForEditManageAddress
              ? editAddressForm()
              : _addNewAddressForm(),
        );
      },
    );
  }

  editAddressForm() {
    controller.nameTextController = TextEditingController(
      text: controller.isRouteForEditManageAddress == true
          ? controller.manageAddressDataSubData.name
          : '',
    );
    // String? lastName = '';
    // int? lastIndex = controller.manageAddressDataSubData.name?.lastIndexOf(' ');
    // if (lastIndex != -1) {
    //   lastName = controller.manageAddressDataSubData.name?.substring(lastIndex + 1 ) ;
    // }
    // controller.lastnameTextController=TextEditingController(
    //   text:controller.isRouteForEditManageAddress==true
    //       ? lastName
    //       :''
    // );
    controller.mobileNumberTextController = TextEditingController(
        text: controller.isRouteForEditManageAddress == true
            ? controller.manageAddressDataSubData.phoneNo.toString()
            : '');
    controller.companyName = TextEditingController(
        text: controller.isRouteForEditManageAddress == true
            ? controller.manageAddressDataSubData.company
            : '');
    controller.addressTextController = TextEditingController(
        text: controller.isRouteForEditManageAddress == true
            ? controller.manageAddressDataSubData.fullAddress
            : '');
    controller.countryController = TextEditingController(
        text: controller.isRouteForEditManageAddress == true
            ? controller.manageAddressDataSubData.country
            : "");
    controller.cityController = TextEditingController(
        text: controller.isRouteForEditManageAddress == true
            ? controller.manageAddressDataSubData.city
            : '');
    controller.stateTextController = TextEditingController(
        text: controller.isRouteForEditManageAddress == true
            ? controller.manageAddressDataSubData.state
            : '');
    controller.pinTextController = TextEditingController(
        text: controller.isRouteForEditManageAddress == true
            ? controller.manageAddressDataSubData.pinCode
            : '');
    controller.apartmentNumberTextController = TextEditingController(
        text: controller.isRouteForEditManageAddress == true
            ? controller.manageAddressDataSubData.apartmentNumber
            : '');

    // if(controller.manageAddressDataSubData.addressType=="HOME")
    //   {
    //     controller.selectedAddressType=1;
    //   }
    // else
    //   {
    //     controller.selectedAddressType=2;
    //   }

    return Form(
        key: controller.addNewAddressFormGlobalKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: <Widget>[
                  TextFieldWidget(
                    hint: strFirstName,
                    textController: controller.nameTextController,
                    focusNode: controller.nameFocusNode,
                    inputType: TextInputType.text,
                    formatter: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                    ],
                    inputAction: TextInputAction.next,
                    validate: (value) => FieldChecker.fieldChecker(
                        value: value, message: strFieldRequired),
                  )
                      .paddingOnly(bottom: margin_16)
                      .paddingSymmetric(horizontal: margin_16),
                  TextFieldWidget(
                    hint: strLastName,
                    textController: controller.lastnameTextController,
                    focusNode: controller.lastnameFocusNode,
                  )
                      .paddingOnly(bottom: margin_16)
                      .paddingSymmetric(horizontal: margin_16),
                  CountryPickerTextField(
                    // suffix: const AssetSVGWidget(
                    //   iconsError,
                    // ),
                    showCountryFlag: true,
                    hintText: strPhoneNumber,
                    focusNode: controller.mobileNumberFocusNode,
                    onCountryChanged: (Country country) {
                      controller.selectedCountry = country;
                    },
                    // onCountryChanged: null,
                    selectedCountry: controller.selectedCountry,
                    controller: controller.mobileNumberTextController,
                  )
                      .paddingOnly(bottom: margin_16)
                      .paddingSymmetric(horizontal: margin_16),
                  TextFieldWidget(
                    hint: strCompanyOptional,
                    focusNode: controller.companyNameFocusNode,
                  )
                      .paddingOnly(bottom: margin_16)
                      .paddingSymmetric(horizontal: margin_16),
                  Container(child: placesAutoCompleteTextField())
                      .paddingOnly(bottom: margin_16)
                      .paddingSymmetric(horizontal: margin_16),
                  TextFieldWidget(
                    textController: controller.countryController,
                    focusNode: controller.countryFocusNode,
                    hint: strCountry,
                    inputType: TextInputType.text,
                    formatter: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                    ],
                    inputAction: TextInputAction.next,
                    validate: (value) => FieldChecker.fieldChecker(
                        value: value, message: strFieldRequired),
                  )
                      .paddingOnly(bottom: margin_16)
                      .paddingSymmetric(horizontal: margin_16),
                  TextFieldWidget(
                    textController: controller.cityController,
                    focusNode: controller.cityFocusNode,
                    hint: strCity,
                    inputType: TextInputType.text,
                    formatter: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                    ],
                    inputAction: TextInputAction.next,
                    validate: (value) => FieldChecker.fieldChecker(
                        value: value, message: strFieldRequired),
                  )
                      .paddingOnly(bottom: margin_16)
                      .paddingSymmetric(horizontal: margin_16),
                  Row(
                    children: [
                      Flexible(
                        child: TextFieldWidget(
                          textController: controller.stateTextController,
                          focusNode: controller.stateFocusNode,
                          hint: strState,
                          inputType: TextInputType.text,
                          formatter: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-zA-Z ]')),
                          ],
                          inputAction: TextInputAction.next,
                          validate: (value) => FieldChecker.fieldChecker(
                              value: value, message: strFieldRequired),
                        ),
                      ),
                      SizedBox(
                        width: width_12,
                      ),
                      Flexible(
                        child: TextFieldWidget(
                          textController: controller.pinTextController,
                          focusNode: controller.pinFocusNode,
                          hint: strPinCode,
                          inputType: TextInputType.text,
                          inputAction: TextInputAction.next,
                          validate: (value) => FieldChecker.fieldChecker(
                              value: value, message: strFieldRequired),
                        ),
                      ),
                    ],
                  )
                      .paddingOnly(bottom: margin_16)
                      .paddingSymmetric(horizontal: margin_16),
                  TextFieldWidget(
                    hint: strApartmentNumber,
                    focusNode: controller.apartmentNumberFocusNode,
                  )
                      .paddingOnly(bottom: margin_16)
                      .paddingSymmetric(horizontal: margin_16),
                  TextView(
                    text: strAddressType,
                    textStyle: textStyleBodyMedium().copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: font_16),
                  )
                      .paddingOnly(bottom: margin_14)
                      .paddingSymmetric(horizontal: margin_20),
                  _addressTypeRadio()
                ],
              ),
            ),
            BottomButtonWidget(
                onPressed: () {
                  if (controller.addNewAddressFormGlobalKey.currentState!
                      .validate()) {
                    controller.update();
                    controller.hitEditAddressApi();
                  }
                },
                btnTitle: "EDIT ADDRESS")
          ],
        )).paddingOnly(top: margin_8);
  }

  _addNewAddressForm() {
    return Form(
        key: controller.addNewAddressFormGlobalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: <Widget>[
                  TextFieldWidget(
                    hint: strFirstName,
                    textController: controller.nameTextController,
                    focusNode: controller.nameFocusNode,
                    inputType: TextInputType.text,
                    formatter: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                    ],
                    inputAction: TextInputAction.next,
                    validate: (value) => FieldChecker.fieldChecker(
                        value: value, message: strFieldRequired),
                  )
                      .paddingOnly(bottom: margin_16)
                      .paddingSymmetric(horizontal: margin_16),
                  TextFieldWidget(
                    hint: strLastName,
                    textController: controller.lastnameTextController,
                    focusNode: controller.lastnameFocusNode,
                  )
                      .paddingOnly(bottom: margin_16)
                      .paddingSymmetric(horizontal: margin_16),
                  CountryPickerTextField(
                    // suffix: const AssetSVGWidget(
                    //   iconsError,
                    // ),
                    showCountryFlag: true,
                    hintText: strPhoneNumber,
                    focusNode: controller.mobileNumberFocusNode,
                    // onCountryChanged: null,
                    onCountryChanged: (Country country) {
                      controller.selectedCountry = country;
                    },
                    selectedCountry: controller.selectedCountry,
                    controller: controller.mobileNumberTextController,
                  )
                      .paddingOnly(bottom: margin_16)
                      .paddingSymmetric(horizontal: margin_16),
                  TextFieldWidget(
                    hint: strCompanyOptional,
                    focusNode: controller.companyNameFocusNode,
                  )
                      .paddingOnly(bottom: margin_16)
                      .paddingSymmetric(horizontal: margin_16),
                  Container(child: placesAutoCompleteTextField())
                      .paddingOnly(bottom: margin_16)
                      .paddingSymmetric(horizontal: margin_16),
                  TextFieldWidget(
                    textController: controller.countryController,
                    focusNode: controller.countryFocusNode,
                    hint: strCountry,
                    inputType: TextInputType.text,
                    formatter: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                    ],
                    inputAction: TextInputAction.next,
                    validate: (value) => FieldChecker.fieldChecker(
                        value: value, message: strFieldRequired),
                  )
                      .paddingOnly(bottom: margin_16)
                      .paddingSymmetric(horizontal: margin_16),
                  TextFieldWidget(
                    textController: controller.cityController,
                    focusNode: controller.cityFocusNode,
                    hint: strCity,
                    inputType: TextInputType.text,
                    formatter: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                    ],
                    inputAction: TextInputAction.next,
                    validate: (value) => FieldChecker.fieldChecker(
                        value: value, message: strFieldRequired),
                  )
                      .paddingOnly(bottom: margin_16)
                      .paddingSymmetric(horizontal: margin_16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: TextFieldWidget(
                          textController: controller.stateTextController,
                          focusNode: controller.stateFocusNode,
                          hint: strState,
                          inputType: TextInputType.text,
                          formatter: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-zA-Z ]')),
                          ],
                          inputAction: TextInputAction.next,
                          validate: (value) => FieldChecker.fieldChecker(
                              value: value, message: strFieldRequired),
                        ),
                      ),
                      SizedBox(
                        width: width_12,
                      ),
                      Flexible(
                        child: TextFieldWidget(
                          textController: controller.pinTextController,
                          focusNode: controller.pinFocusNode,
                          hint: strPinCode,
                          inputType: TextInputType.text,
                          inputAction: TextInputAction.next,
                          validate: (value) => FieldChecker.fieldChecker(
                              value: value, message: strFieldRequired),
                        ),
                      ),
                    ],
                  )
                      .paddingOnly(bottom: margin_16)
                      .paddingSymmetric(horizontal: margin_16),
                  TextFieldWidget(
                    hint: strApartmentNumber,
                    focusNode: controller.apartmentNumberFocusNode,
                  )
                      .paddingOnly(bottom: margin_16)
                      .paddingSymmetric(horizontal: margin_16),
                  TextView(
                    text: strAddressType,
                    textStyle: textStyleBodyMedium().copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: font_16),
                  )
                      .paddingOnly(bottom: margin_14)
                      .paddingSymmetric(horizontal: margin_20),
                  _addressTypeRadio()
                ],
              ),
            ),
            BottomButtonWidget(
                onPressed: () {
                  if (controller.addNewAddressFormGlobalKey.currentState!
                      .validate()) {
                    controller.update();
                    controller.hitAddAddressApi();
                  }
                },
                btnTitle: strAddAddress)
          ],
        )).paddingOnly(top: margin_8);
  }

  _addressTypeRadio() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: TextView(
              text: strHomeAllDayDelivery,
              textStyle: textStyleBodyMedium().copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: font_14),
            ),
            leading: Radio(
              fillColor: MaterialStateProperty.resolveWith(getColor),
              groupValue: controller.selectedAddressType,
              value: 1,
              onChanged: (value) {
                controller.selectedAddressType = value!;
                controller.update();
              },
            ),
          ),
          ListTile(
            title: TextView(
              text: strWorkDelivery,
              textStyle: textStyleBodyMedium().copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: font_14),
            ),
            leading: Radio(
              fillColor: MaterialStateProperty.resolveWith(getColor),
              groupValue: controller.selectedAddressType,
              value: 2,
              onChanged: (value) {
                controller.selectedAddressType = value!;
                controller.update();
              },
            ),
          ).paddingOnly(bottom: margin_16),
        ],
      );

  Color getColor(Set<MaterialState> states) {
    return AppColors.categoriesgrey;
  }

  placesAutoCompleteTextField() {
    return GooglePlaceAutoCompleteTextField(
      textEditingController: controller.addressTextController,
      focusNode: controller.addressFocusNode,
      googleAPIKey: "AIzaSyBBZGsH8PUhQwvuwHjl7KOtvNYE_rE00ww",
      validate: (value) =>
          FieldChecker.fieldChecker(value: value, message: strFieldRequired),
      inputDecoration: InputDecoration(
        isCollapsed: true,
        isDense: true,
        contentPadding:
            EdgeInsets.symmetric(horizontal: margin_15, vertical: margin_15),
        hintText: strAddress,
        hintStyle: textStyleBodyMedium().copyWith(
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w400,
          fontSize: font_14,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        fillColor: themeController.isDarkMode.value == true
            ? Colors.black
            : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius_10),
          borderSide: BorderSide(
            color: themeController.isDarkMode.value == true
                ? AppColors.appBorderDarkColor
                : AppColors.textfieldborder,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius_10),
          borderSide: BorderSide(
            color: themeController.isDarkMode.value == true
                ? AppColors.appBorderDarkColor
                : Colors.red,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius_10),
          borderSide: BorderSide(
            color: themeController.isDarkMode.value == true
                ? AppColors.appBorderDarkColor
                : Colors.red,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius_10),
          borderSide: BorderSide(
            color: themeController.isDarkMode.value == true
                ? AppColors.appBorderDarkColor
                : AppColors.textfieldborder,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius_10),
          borderSide: BorderSide(
            color: themeController.isDarkMode.value == true
                ? AppColors.appBorderDarkColor
                : AppColors.textfieldborder,
          ),
        ),
      ),
      debounceTime: 400,
      countries: const ["us", "uk", "can", "ind"],
      isLatLngRequired: true,
      getPlaceDetailWithLatLng: (PlaceDetails placeDetails) {
        controller.lat = placeDetails.result!.geometry!.location!.lat!;
        controller.lng = placeDetails.result!.geometry!.location!.lng!;
        if (placeDetails.result != null &&
            placeDetails.result!.addressComponents != null) {
          for (var component in placeDetails.result!.addressComponents!) {
            print("${component.types} + ${component.longName}");
            if (component.types != null &&
                component.types!.contains("administrative_area_level_1") &&
                component.types!.contains("political")) {
              controller.stateTextController.text = "${component.longName}";
              print("${component.types} + ${component.longName}");
            }
            if (component.types != null &&
                component.types!.contains("country") &&
                component.types!.contains("political")) {
              controller.countryController.text = "${component.longName}";
              print("${component.types} + ${component.longName}");
            }
            if (component.types != null &&
                component.types!.contains("locality") &&
                component.types!.contains("political")) {
              controller.cityController.text = "${component.longName}";
              print("${component.types} + ${component.longName}");
            } else if (component.types != null &&
                component.types!.contains("postal_town")) {
              controller.cityController.text = "${component.longName}";
              print("${component.types} + ${component.longName}");
            }
            if (component.types != null &&
                component.types!.contains("postal_code")) {
              controller.pinTextController.text = "${component.longName}";
              print("${component.types} + ${component.longName}");
            }
          }
        }
        controller.update();
      },
      itemClick: (Prediction prediction) {
        controller.addressTextController.text = prediction.description ?? "";
      },
      seperatedBuilder: Divider(),
      // containerHorizontalPadding: 10,

      // OPTIONAL// If you want to customize list view item builder
      itemBuilder: (context, index, Prediction prediction) {
        return Row(
          children: [
            const Icon(
              Icons.location_on,
              color: AppColors.gradient2nd,
            ),
            SizedBox(
              width: width_7,
            ),
            Expanded(
                child: Text(
              "${prediction.description ?? ""}",
              style: TextStyle(fontSize: font_14),
            ))
          ],
        );
      },
      isCrossBtnShown: false,
    );
  }
}
