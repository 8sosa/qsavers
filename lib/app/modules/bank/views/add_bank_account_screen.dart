import "package:quantity_savers/app/modules/bank/controllers/add_bank_account_controller.dart";
import "package:quantity_savers/app/core/widget/googleplacepicker/google_place_picker.dart";
import "package:quantity_savers/app/core/widget/googleplacepicker/place_autoComplete_model.dart";
import "package:quantity_savers/app/core/widget/googleplacepicker/place_details_model.dart";

import "../../../export.dart";

class AddBankAccountScreen extends StatelessWidget {
  final themeController = Get.put(ThemeController());
  final controller = Get.put(AddBankAccountController());
  final GlobalKey<FormState> addBankFormGlobalKey = GlobalKey<FormState>();
  final GlobalKey<FormState> flutterWaveBankFormGlobalKey =
      GlobalKey<FormState>();
  final GlobalKey<FormState> payPalBankFormGlobalKey = GlobalKey<FormState>();

  AddBankAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddBankAccountController>(
        init: AddBankAccountController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomAppBar(
              appBarTitleText: strAddBankAccount.toUpperCase(),
            ),
            body: controller.bankType == "Contact Admin"
                ? contactAdminBankForm()
                : (controller.bankType == "PayPal" || controller.bankType=="Paypal")
                    ? payPalBankAccountForm()
                    : controller.bankType == "Flutterwave"
                        ? flutterwavebankAccountForm()
                        : _addBankAccountForm(),
          );
        });
  }

  flutterwavebankAccountForm() {
    return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(margin_16),
            child: Form(
                key: flutterWaveBankFormGlobalKey,
                child: Column(children: [
                  TextFieldWidget(
                    textController: controller.countryController,
                    focusNode: controller.countryFocusNode,
                    inputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                    readOnly: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget(
                    textController: controller.accountHolderNameController,
                    focusNode: controller.accountHolderNameFocusNode,
                    inputType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    formatter: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                    ],
                    hint: strAccountHolderName,
                    validate: (value) => FieldChecker.fieldChecker(
                        value: value, message: strFieldRequired),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget(
                    textController:
                        controller.flutterWaveAccountNumberController,
                    focusNode: controller.flutterWaveAccountNoFocusNode,
                    inputType: TextInputType.number,
                    inputAction: TextInputAction.next,
                    hint: "Enter your Account No.",
                    validate: (value) => FieldChecker.fieldChecker(
                        value: value, message: strFieldRequired),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget(
                    textController: controller.flutterWaveAccessBankController,
                    focusNode: controller.flutterWaveAccessBankFocusNode,
                    inputType: TextInputType.number,
                    inputAction: TextInputAction.next,
                    hint: "Enter your SSN No.",
                    validate: (value) => FieldChecker.fieldChecker(
                        value: value, message: strFieldRequired),
                  ),
                  addFlutterWaveAccountBtn()
                ]))));
  }

  payPalBankAccountForm() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(margin_16),
        child: Form(
          key: payPalBankFormGlobalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFieldWidget(
                textController: controller.countryController,
                focusNode: controller.countryFocusNode,
                inputType: TextInputType.text,
                inputAction: TextInputAction.next,
                readOnly: true,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                textController: controller.accountHolderNameController,
                focusNode: controller.accountHolderNameFocusNode,
                inputType: TextInputType.text,
                inputAction: TextInputAction.next,
                formatter: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                ],
                hint: strAccountHolderName,
                validate: (value) => FieldChecker.fieldChecker(
                    value: value, message: strFieldRequired),
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                textController: controller.payPalEmailController,
                focusNode: controller.payPalFocusNode,
                inputType: TextInputType.emailAddress,
                inputAction: TextInputAction.next,
                hint: strPayPalEmail,
                validate: (value) => EmailValidator.validateEmail(value),

              ),
              addPayPalAccountBtn()
            ],
          ),
        ),
      ),
    );
  }

  contactAdminBankForm() {
    final maxLines = 10;

    return SingleChildScrollView(
      child: Column(
        children: [
          TextFieldWidget(
            textController: controller.countryController,
            focusNode: controller.countryFocusNode,
            inputType: TextInputType.text,
            inputAction: TextInputAction.next,
            readOnly: true,
          ).paddingAll(margin_12),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.all(12),
            height: maxLines * 24.0,
            child: TextField(
              maxLines: maxLines,
              keyboardType: TextInputType.multiline,
              controller: controller.contactAdminController,
              focusNode: controller.contactAdminFocusNode,
              decoration: InputDecoration(
                filled: true,
                hintText: 'Enter your bank details.',
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
          addContactAdminBtn()
        ],
      ),
    );
  }

  _addBankAccountForm() => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(margin_16),
          child: Form(
            key: addBankFormGlobalKey,
            child: Column(
              children: [
                _countryDropdownField(),
                _accountHolderNameField(),
                _accountNumberField(),
                _currencyDropdownField(),
                _routingNumberField(),
                controller.isAlreadyAdded ? SizedBox() : _uploadDocumentInfo(),
                controller.isAlreadyAdded
                    ? SizedBox()
                    : _firstAndLastNameField(),
                controller.isAlreadyAdded ? SizedBox() : _emailField(),
                controller.isAlreadyAdded ? SizedBox() : _phoneNumberField(),
                controller.isAlreadyAdded ? SizedBox() : _addressAndCityField(),
                controller.isAlreadyAdded
                    ? SizedBox()
                    : _stateAndPostalCodeField(),
                controller.isAlreadyAdded ? SizedBox() : _ssnNumberField(),
                controller.isAlreadyAdded
                    ? SizedBox()
                    : _datePickerAndMccNumberField(),
                controller.isAlreadyAdded ? SizedBox() : _taxNumberField(),
                _addBankAccountBtn()
              ],
            ),
          ),
        ),
      );

  // _countryDropdownField() => DropDownTextFieldWidget(
  //       validate: (value) =>
  //           FieldChecker.fieldChecker(value: value, message: strFieldRequired),
  //       onFieldSubmitted: (value) {
  //         controller.onCountryChangeDropDownValue(value);
  //       },
  //       hint: strSelectCountry,
  //       itemsList: controller.countryList,
  //       selectedValue: controller.selectedCountry,
  //     );

  _countryDropdownField()=>TextFieldWidget(
    textController: controller.countryZipCodeController,
    focusNode: controller.countryZipFocusNode,
    inputType: TextInputType.text,
    inputAction: TextInputAction.next,
    validate: (value) =>
        FieldChecker.fieldChecker(value: value, message: strFieldRequired),
   readOnly: true,
  );

  _accountHolderNameField() => TextFieldWidget(
        textController: controller.holderNameController,
        focusNode: controller.holderNameFocusNode,
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        formatter: [
          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
        ],
        hint: strAccountHolderName,
        validate: (value) =>
            FieldChecker.fieldChecker(value: value, message: strFieldRequired),
      ).paddingSymmetric(vertical: margin_16);

  _accountNumberField() => TextFieldWidget(
        textController: controller.accountNumberController,
        focusNode: controller.accountNumberFocusNode,
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        validate: (value) =>
            FieldChecker.fieldChecker(value: value, message: strFieldRequired),
        hint: strAccountNumber,
      );

  // _currencyDropdownField() => DropDownTextFieldWidget(
  //       onFieldSubmitted: (value) {
  //         controller.onCurrencyChangeDropDownValue(value);
  //       },
  //       hint: strSelectCurrency,
  //       itemsList: controller.currencyList,
  //       selectedValue: controller.selectedCurrency,
  //     ).paddingSymmetric(vertical: margin_16);

  _currencyDropdownField()=>TextFieldWidget(
    textController: controller.currencyController,
    focusNode: controller.currencyFocusNode,
    inputType: TextInputType.text,
    inputAction: TextInputAction.next,
    validate: (value) =>
        FieldChecker.fieldChecker(value: value, message: strFieldRequired),
    readOnly: true,
  ).paddingSymmetric(vertical: margin_16);

  _routingNumberField() => TextFieldWidget(
        textController: controller.routingNumberController,
        focusNode: controller.routingNumberFocusNode,
        inputType: TextInputType.number,
        inputAction: TextInputAction.next,
        validate: (value) =>
            FieldChecker.fieldChecker(value: value, message: strFieldRequired),
        hint: strRoutingNumber,
      );

  _uploadDocumentInfo() => Column(
        children: [
          controller.docImagePath.isEmpty
              ? TextView(
                  text: "Supported Formats: .jpg/.png",
                  textStyle: textStyleBodyMedium().copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: font_16),
                ).paddingOnly(bottom: margin_16)
              : ClipRRect(
                  borderRadius: BorderRadius.circular(radius_8),
                  child: Image.file(
                    File(controller.docImagePath),
                    height: height_120,
                  ).paddingOnly(bottom: margin_8),
                ),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: InkWell(
                onTap: () {
                  controller.pickImage();
                },
                child: EditProfileBtnWidget(
                    btnName: controller.docImagePath.isEmpty
                        ? strUploadImage.toUpperCase()
                        : strChangeImage.toUpperCase())),
          )
        ],
      ).paddingSymmetric(vertical: margin_16);

  _firstAndLastNameField() => Row(
        children: [
          Expanded(
              child: TextFieldWidget(
            textController: controller.firstNameController,
            focusNode: controller.firstNameFocusNode,
            inputType: TextInputType.text,
            inputAction: TextInputAction.next,
            hint: strFirstName,
            validate: (value) => FieldChecker.fieldChecker(
                value: value, message: strFieldRequired),
          )),
          SizedBox(
            width: margin_8,
          ),
          Expanded(
              child: TextFieldWidget(
            textController: controller.lastNameController,
            focusNode: controller.lastNameFocusNode,
            inputType: TextInputType.text,
            inputAction: TextInputAction.next,
            hint: strLastName,
          ))
        ],
      );

  _emailField() => TextFieldWidget(
        textController: controller.emailController,
        focusNode: controller.emailFocusNode,
        inputType: TextInputType.emailAddress,
        inputAction: TextInputAction.next,
        hint: strEmail,
        validate: (value) => EmailValidator.validateEmail(value),
      ).paddingOnly(top: margin_16);

  _phoneNumberField() => TextFieldWidget(
        textController: controller.phoneNumberController,
        focusNode: controller.phoneNumberFocusNode,
        inputType: TextInputType.number,
        inputAction: TextInputAction.next,
        validate: (value) =>
            FieldChecker.fieldChecker(value: value, message: strFieldRequired),
        hint: strPhoneNumber,
      ).paddingSymmetric(vertical: margin_16);

  _addressAndCityField() => Row(
        children: [
          Expanded(child: placesAutoCompleteTextField()),
          SizedBox(
            width: margin_8,
          ),
          Expanded(
              child: TextFieldWidget(
            textController: controller.cityController,
            focusNode: controller.cityFocusNode,
            inputType: TextInputType.text,
            inputAction: TextInputAction.next,
            validate: (value) => FieldChecker.fieldChecker(
                value: value, message: strFieldRequired),
            hint: strCity,
          ))
        ],
      );

  _stateAndPostalCodeField() => Row(
        children: [
          Expanded(
              child: TextFieldWidget(
            textController: controller.stateController,
            focusNode: controller.stateFocusNode,
            inputType: TextInputType.text,
            inputAction: TextInputAction.next,
            validate: (value) => FieldChecker.fieldChecker(
                value: value, message: strFieldRequired),
            hint: strState,
          )),
          SizedBox(
            width: margin_8,
          ),
          Expanded(
              child: TextFieldWidget(
            textController: controller.postalCodeController,
            focusNode: controller.postalCodeFocusNode,
            inputType: TextInputType.text,
            inputAction: TextInputAction.next,
            validate: (value) => FieldChecker.fieldChecker(
                value: value, message: strFieldRequired),
            hint: strPostalCode,
          ))
        ],
      ).paddingSymmetric(vertical: margin_16);

  _ssnNumberField() => TextFieldWidget(
        textController: controller.ssnNumberController,
        focusNode: controller.ssNumberFocusNode,
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        validate: (value) =>
            FieldChecker.fieldChecker(value: value, message: strFieldRequired),
        hint: strSsnNumber,
      );

  _datePickerAndMccNumberField() => Row(
        children: [
          Expanded(
              child: TextFieldWidget(
            hint: "dd/mm/yyyy",
            textController: controller.datePickerController,
            readOnly: true,
            onTap: () {
              controller.onDateChange();
            },
          )),
          SizedBox(
            width: margin_8,
          ),
          Expanded(
              child: TextFieldWidget(
            textController: controller.mccNumberController,
            focusNode: controller.mccNumberFocusNode,
            inputType: TextInputType.text,
            inputAction: TextInputAction.next,
            validate: (value) => FieldChecker.fieldChecker(
                value: value, message: strFieldRequired),
            hint: strMccNumber,
          ))
        ],
      ).paddingSymmetric(vertical: margin_16);

  _taxNumberField() => TextFieldWidget(
        textController: controller.taxNumberController,
        focusNode: controller.taxNumberFocusNode,
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        validate: (value) =>
            FieldChecker.fieldChecker(value: value, message: strFieldRequired),
        hint: strTaxNumber,
      );

  _addBankAccountBtn() => BottomButtonWidget(borderColor: Colors.transparent,
      onPressed: () {
        if (addBankFormGlobalKey.currentState!.validate()) {
          controller.hitAddBankApiCall();
        }
      },
      btnTitle: strAddBankAccount.toUpperCase());

  addPayPalAccountBtn() {
    return BottomButtonWidget(borderColor: Colors.transparent,
        onPressed: () {
          if (payPalBankFormGlobalKey.currentState!.validate()) {
            controller.hitAddFlwPayPalContactAdminBank(
              userCountry: controller.countryController.text.trim(),
              name: controller.accountHolderNameController.text.trim(),
              paypalAccountEmail: controller.payPalEmailController.text.trim(),
              banktype: "PAYPAL"
            );
          }
        },
        btnTitle: strAddBankAccount.toUpperCase());
  }

  addFlutterWaveAccountBtn() {
    return BottomButtonWidget(borderColor: Colors.transparent,
        onPressed: () {
          if (flutterWaveBankFormGlobalKey.currentState!.validate()) {
            controller.hitAddFlwPayPalContactAdminBank(
              userCountry: controller.countryController.text.trim(),
              name: controller.accountHolderNameController.text.trim(),
              accNo: controller.flutterWaveAccountNumberController.text.trim(),
              ssnNo: controller.flutterWaveAccessBankController.text.trim(),
              banktype: "FLUTTERWAVE"
            );
          }
        },
        btnTitle: strAddBankAccount.toUpperCase());
  }

  addContactAdminBtn() {
    return BottomButtonWidget(borderColor: Colors.transparent,
        onPressed: () {
          if (controller.contactAdminController.text.isNotEmpty) {
            controller.hitAddFlwPayPalContactAdminBank(
                userCountry: controller.countryController.text.trim(),
                contactAdminDetails:
                    controller.contactAdminController.text.trim(),
            banktype: "CONTACT_ADMIN");
          }
          else
            {
              showToast(message: "Please add your bank details");
            }
        },
        btnTitle: strAddBankAccount.toUpperCase());
  }

  placesAutoCompleteTextField() {
    return GooglePlaceAutoCompleteTextField(
      textEditingController: controller.addressController,
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
      countries: ["us", "uk", "can", "ind"],
      isLatLngRequired: true,
      getPlaceDetailWithLatLng: (PlaceDetails placeDetails) {
        if (placeDetails.result != null &&
            placeDetails.result!.addressComponents != null) {
          for (var component in placeDetails.result!.addressComponents!) {
            print("${component.types} + ${component.longName}");
            if (component.types != null &&
                component.types!.contains("administrative_area_level_1") &&
                component.types!.contains("political")) {
              controller.stateController.text = "${component.longName}";
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
              controller.postalCodeController.text = "${component.longName}";
              print("${component.types} + ${component.longName}");
            }
          }
        }
        controller.update();
      },
      itemClick: (Prediction prediction) {
        controller.addressController.text = prediction.description ?? "";
      },
      seperatedBuilder: Divider(),
      // containerHorizontalPadding: 10,

      // OPTIONAL// If you want to customize list view item builder
      itemBuilder: (context, index, Prediction prediction) {
        return Container(
          // padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(Icons.location_on),
              SizedBox(
                width: 7,
              ),
              Expanded(child: Text("${prediction.description ?? ""}"))
            ],
          ),
        );
      },
      isCrossBtnShown: false,
    );
  }
}
