import "package:quantity_savers/app/core/values/app_values.dart";
import "package:quantity_savers/app/modules/bank/controllers/bank_account_controller.dart";
import "package:quantity_savers/app/modules/bank/models/data_model/add_bank_data_model.dart";

import "../../../export.dart";

class BankAccountScreen extends StatelessWidget {
  final themeController = Get.put(ThemeController());
  final controller = Get.put(BankAccountController());

  BankAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BankAccountController>(
        init: BankAccountController(),
        builder: (controller) {
          return Scaffold(
              appBar: CustomAppBar(
                appBarTitleText: strBankAccount.toUpperCase(),
              ),
              body: controller.isLoading == true
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: AppColors.gradient2nd,
                    ))
                  : controller.addBankResponseModel.data?.data?.length == 0
                      // ? _noBankAccountScreen()
                      ? countrySelectionScreen()
                      : Column(
                          children: [
                            Expanded(
                                child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: margin_8),
                                    color: AppColors.dividerColor,
                                    alignment: Alignment.centerLeft,
                                    child: TextView(
                                      text: strYourBankAccounts,
                                      textStyle: textStyleBodyMedium().copyWith(
                                          color: AppColors.greyColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: font_14),
                                    ).paddingOnly(left: margin_16),
                                  ).paddingOnly(top: margin_16),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: controller.addBankResponseModel
                                            .data?.data?.length ??
                                        0,
                                    itemBuilder: (context, index) {
                                      return _bankAccountScreen(controller
                                          .addBankResponseModel
                                          .data
                                          ?.data?[index]);
                                    },
                                  ).paddingAll(margin_16),
                                ],
                              ),
                            )),
                            BottomButtonWidget(
                              onPressed: () async {
                                var result = false;
                                if (controller.isForSelectedBank) {
                                  Get.toNamed(AppRoutes.paymentRoute,
                                      arguments: {
                                        argForPayment: strForMakePayment
                                      });
                                } else {
                                  await controller.hitGetCountryDetailsApi();
                                  Future.delayed(Duration(seconds: 2),
                                      () async {
                                    bool? shouldProceed =
                                        await showPaymentMethodDialog(context);
                                    bool hasStripe = hasStripeType(controller
                                        .addBankResponseModel.data?.data);

                                    if (shouldProceed == true) {
                                      result = await Get.toNamed(
                                          AppRoutes.addBankRoute,
                                          arguments: {
                                            argForAddBank: ((controller
                                                        .addBankResponseModel
                                                        .data
                                                        ?.data
                                                        ?.length ??
                                                    0) >
                                                0),
                                            argCountry: controller
                                                .addBankResponseModel
                                                .data
                                                ?.data?[0]
                                                .country,
                                            argBankType: controller
                                                .selectedCountryPaymentMethod
                                                ?.value,
                                            argStripe: !hasStripe,
                                            argCountryZipCode: controller
                                                .countryDetailResponseModel
                                                .data
                                                ?.data
                                                ?.countryCode,
                                            argCurrency: controller
                                                .countryDetailResponseModel
                                                .data
                                                ?.data
                                                ?.currency
                                          });
                                      if (result) {
                                        controller.hitGetBankAccountsApi();
                                      }
                                    }
                                  });
                                }
                              },
                              btnTitle: controller.isForSelectedBank
                                  ? strProceedToPayment
                                  : strAddBankAccount.toUpperCase(),
                            )
                          ],
                        ));
        });
  }

  Future<bool?> showPaymentMethodDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Select Payment Method')),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(thickness: margin_2,endIndent: 15,indent: 15,
                color: AppColors.dividerColor,),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.7,
                child: DropDownTextFieldWidget(
                  borderColor: AppColors.borderColor,
                  onFieldSubmitted: (value) {
                    controller.onChangeSelectedCountryPaymentMethod(value);
                  },
                  hint: "Select payment ",
                  itemsList: controller.paymentsMethodSelectedCountry,
                  hintStyle: textStyleLabelLarge().copyWith(
                      color: Colors.black,
                      fontSize: font_14,
                      fontWeight: FontWeight.w400),
                  selectedValue: controller.selectedCountryPaymentMethod?.value,
                  selectedItemTextStyle: textStyleLabelLarge().copyWith(
                      color: AppColors.pricesColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ).paddingAll(16),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel',style: TextStyle(color: AppColors.gradient2nd),),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('OK',style: TextStyle(color: AppColors.gradient2nd),),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  bool hasStripeType(List<AddBankSubDataModel>? data) {
    if (data == null) return false;
    return data.any((item) => item.type == "STRIPE");
  }

  _bankAccountScreen(AddBankSubDataModel? data) => Container(
        padding: EdgeInsets.all(margin_16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(radius_12)),
            border: Border.all(color: AppColors.borderColor)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                (data?.type == "FLUTTERWAVE" || data?.type == "STRIPE")
                    ? TextView(
                        text: "Bank Account Number".toUpperCase(),
                        textStyle: textStyleBodyMedium().copyWith(
                            color: AppColors.categoriesgrey,
                            fontWeight: FontWeight.w500,
                            fontSize: font_12),
                      )
                    : data?.type == "PAYPAL"
                        ? TextView(
                            text: "PAYPAL Email",
                            textStyle: textStyleBodyMedium().copyWith(
                                color: AppColors.categoriesgrey,
                                fontWeight: FontWeight.w500,
                                fontSize: font_12))
                        : TextView(
                            text: "Bank Details",
                            textStyle: textStyleBodyMedium().copyWith(
                                color: AppColors.categoriesgrey,
                                fontWeight: FontWeight.w500,
                                fontSize: font_12)),
                const Spacer(),
                controller.isForSelectedBank
                    ? const SizedBox()
                    : data?.isDefault == true
                        ? TextView(
                            text: strDefault,
                            textStyle: textStyleBodyMedium().copyWith(
                                color: AppColors.bottombarColor,
                                fontWeight: FontWeight.w500,
                                fontSize: font_12),
                          ).paddingOnly(right: margin_4)
                        : const SizedBox(),
                controller.isForSelectedBank
                    ? const SizedBox()
                    : data?.isDefault == true
                        ? const SizedBox()
                        : InkWell(
                            onTap: () {
                              Get.dialog(CustomDialogWidget(
                                title: strDeleteAccountDes,
                                confirmTitle: strYes,
                                cancelTitle: strNo,
                                confirmBtnBgColor: Colors.red,
                                cancelTitleColor:
                                    AppColors.gradientColorSecondary,
                                cancelBtnBorder: Border.all(
                                    color: AppColors.borderColor, width: 1),
                                cancelBtnBgColor: Colors.transparent,
                                onTapConfirm: () {
                                  controller.hitDeleteBankAccountApi(data?.sId);
                                  Get.back(result: true);
                                },
                                isImage: false,
                                isCloseBtn: true,
                              ));
                            },
                            child: AssetSVGWidget(
                              iconsDelete,
                              color: Colors.red,
                              imageWidth: width_16,
                            ),
                          ),
              ],
            ),
            TextView(
              text: data?.type == "CONTACT_ADMIN"
                  ? "${data?.accountDetail}"
                  : data?.type == "FLUTTERWAVE"
                      ? "${data?.accountNo}"
                      : data?.type == "PAYPAL"
                          ? "${data?.paypalEmail}"
                          : "*********${data?.last4}",
              textStyle: textStyleBodyMedium().copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: font_14),
            ).paddingOnly(top: margin_4),
            data?.type == "PAYPAL"
                ? SizedBox(
                    height: 10,
                  )
                : SizedBox(
                    height: 0,
                  ),
            data?.type == "STRIPE"
                ? TextView(
                    text: "Routing Number".toUpperCase(),
                    textStyle: textStyleBodyMedium().copyWith(
                        color: AppColors.categoriesgrey,
                        fontWeight: FontWeight.w500,
                        fontSize: font_12),
                  ).paddingOnly(top: margin_12)
                : SizedBox(),
            data?.type == "FLUTTERWAVE"
                ? TextView(
                    text: "SSN Number",
                    textStyle: textStyleBodyMedium().copyWith(
                        color: AppColors.categoriesgrey,
                        fontWeight: FontWeight.w500,
                        fontSize: font_12),
                  ).paddingOnly(top: margin_12)
                : SizedBox(),
            data?.type == "STRIPE"
                ? TextView(
                    text: "${data?.routingNumber}",
                    textStyle: textStyleBodyMedium().copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: font_14),
                  ).paddingOnly(bottom: margin_12, top: margin_4)
                : SizedBox(),
            data?.type == "FLUTTERWAVE"
                ? TextView(
                    text: "${data?.ssn}",
                    textStyle: textStyleBodyMedium().copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: font_14),
                  ).paddingOnly(bottom: margin_12, top: margin_4)
                : SizedBox(),
            controller.isForSelectedBank
                ? _selectButton()
                : data?.isDefault==true?const SizedBox():_addressesManageBtn(iconsLoader, strSetAsDefault, data?.sId),
          ],
        ),
      ).paddingOnly(bottom: margin_16);

  _addressesManageBtn(iconPrefix, btnName, String sid) => GestureDetector(
        onTap: () {
          controller.hitDefaultBankAccountApi(sid);
        },
        child: Container(
          padding: EdgeInsets.all(margin_10),
          decoration: BoxDecoration(
              border: btnName == strEdits
                  ? Border.all(color: AppColors.borderColor)
                  : null,
              borderRadius: BorderRadius.circular(radius_4),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: btnName == strEdits
                      ? [Colors.transparent, Colors.transparent]
                      : [AppColors.gradient1st, AppColors.gradient2nd])),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AssetSVGWidget(
                  iconPrefix,
                  color: btnName == strEdits
                      ? AppColors.categoriesgrey
                      : Colors.white,
                ).paddingOnly(right: margin_2),
                Text(btnName,
                    style: TextStyle(
                      fontSize: font_12,
                      color: btnName == strEdits
                          ? AppColors.categoriesgrey
                          : Colors.white,
                      fontWeight: FontWeight.w600,
                    ))
              ],
            ),
          ),
        ),
      );

  _selectButton() => Container(
        decoration: BoxDecoration(
          color: AppColors.gradient2nd,
          borderRadius: BorderRadius.circular(margin_4),
          border: Border.all(
            color: AppColors.gradient2nd,
            width: width_1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AssetSVGWidget(iconsFillwhiteFillRight)
                .paddingOnly(right: margin_8),
            TextView(
              text: strSELECTED,
              textStyle: textStyleBodyMedium().copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 14),
            ),
          ],
        ).paddingSymmetric(vertical: margin_8),
      );

  _noBankAccountScreen() => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AssetSVGWidget(iconsNotPurchased)
                .paddingOnly(bottom: margin_20),
            TextView(
              text: strNoBankAccountFound,
              textStyle: textStyleBodyMedium().copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: font_16),
            ).paddingOnly(bottom: margin_16),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.addBankRoute);
                  },
                  child: EditProfileBtnWidget(btnName: strAddBank)),
            )
          ],
        ),
      );

  countrySelectionScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: height_70,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                colors: [AppColors.gradient1st, AppColors.gradient2nd]),
          ),
          child: InkWell(
            onTap: () async {
              var result = await Get.toNamed(AppRoutes.searchOnHomeScreenRoute,
                  arguments: {argBank: true});
              if (result != null) {
                controller.onSelectedCountry(
                    result[argIndex], result[argCountry]);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius_10),
                  color: Colors.white),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: width_24),
                  TextView(
                    text: "Search for Country",
                    textStyle: textStyleBodyMedium().copyWith(
                        color: AppColors.greyColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                  const Spacer(),
                  const Icon(Icons.search,
                      color: AppColors.gradient2nd, size: 24),
                  const SizedBox(width: 24)
                ],
              ),
            ),
          ).paddingOnly(
              left: margin_20,
              right: margin_20,
              top: margin_6,
              bottom: margin_20),
        ),
        DropDownTextFieldWidget(
          borderColor: AppColors.borderColor,
          onFieldSubmitted: (value) {
            controller.onChangeDropDownValueQuantity(value);
          },
          hint: "Select your country",
          itemsList: controller.countryNames,
          hintStyle: textStyleLabelLarge().copyWith(
              color: Colors.black,
              fontSize: font_14,
              fontWeight: FontWeight.w400),
          selectedValue: controller.selectedQuantityValue?.value,
          selectedItemTextStyle: textStyleLabelLarge().copyWith(
              color: AppColors.pricesColor,
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ).paddingAll(16),
        const SizedBox(
          height: 12,
        ),
        DropDownTextFieldWidget(
          borderColor: AppColors.borderColor,
          onFieldSubmitted: (value) {
            controller.onChangeSelectedPaymentMethod(value);
          },
          hint: "Select payment method",
          itemsList: controller.paymentMethods,
          hintStyle: textStyleLabelLarge().copyWith(
              color: Colors.black,
              fontSize: font_14,
              fontWeight: FontWeight.w400),
          selectedValue: controller.selectedPaymentMethod?.value,
          selectedItemTextStyle: textStyleLabelLarge().copyWith(
              color: AppColors.pricesColor,
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ).paddingAll(16),
        const SizedBox(
          height: 50,
        ),
        Center(
          child: SizedBox(
            width: 200,
            child: MaterialButtonWidget(
              onPressed: () {
                if (controller.selectedQuantityValue?.value != "" &&
                    controller.selectedPaymentMethod?.value != "") {
                  Get.toNamed(AppRoutes.addBankRoute, arguments: {
                    argBankType: controller.selectedPaymentMethod?.value,
                    argCountry: controller.selectedQuantityValue?.value,
                    argCountryId: controller.countryCode,
                    argCountryZipCode: controller.countryZipCode,
                    argCurrency: controller.currency
                  });
                }
              },
              buttonText: strNext.toUpperCase(),
              buttonTextStyle: textStyleTitleMedium().copyWith(
                  fontSize: height_14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
              buttonBgColor: AppColors.gradient2nd,
              minHeight: height_42,
            ),
          ),
        ),
      ],
    );
  }
}
