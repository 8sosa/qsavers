import "../../../export.dart";

class AddNewCardScreen extends StatelessWidget {
  final themeController = Get.put(ThemeController());
  final controller = Get.put(AddNewCardController());
  final GlobalKey<FormState> addCardGlobalKey = GlobalKey<FormState>();

  AddNewCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddNewCardController>(
      init: AddNewCardController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(
            appBarTitleText: strAddNewCard.toUpperCase(),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: _addNewCardForm(),
                  ),
                ),
              ),
              BottomButtonWidget(
                onPressed: () {
                  if (addCardGlobalKey.currentState!.validate()) {
                    controller.getStripeCardTokenApiCall();
                  }
                },
                btnTitle:
                    controller.isForAddNew ? strAddCard : strCheckoutTitle,
              ),
            ],
          ),
        );
      },
    );
  }

  _addNewCardForm() => Form(
      key: addCardGlobalKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldWidget(
            hint: strCardNumber,
            textController: controller.cardTextController,
            focusNode: controller.cardFocusNode,
            borderColor: AppColors.textfieldborder,
            inputType: TextInputType.number,
            formatter: [
              FilteringTextInputFormatter.digitsOnly,
              new LengthLimitingTextInputFormatter(16),
              new CardNumberInputFormatter(),
            ],
            validate: (value)
            {
              if(value==null || value.isEmpty)
                {
                  return 'Card Number is required';
                }
              return null;
            },

            inputAction: TextInputAction.next,
          )
              .paddingOnly(bottom: margin_16, top: margin_16)
              .paddingSymmetric(horizontal: margin_16),
          TextFieldWidget(
            hint: strCardHolderName,
            textController: controller.cardHolderNameTextController,
            focusNode: controller.cardHolderFocusNode,
            borderColor: AppColors.textfieldborder,
            inputType: TextInputType.text,
            formatter: [
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
            ],
            inputAction: TextInputAction.next,
            validate: (value)
            {
              if(value==null || value.isEmpty)
              {
                return 'Name is required';
              }
              return null;
            }
          )
              .paddingOnly(bottom: margin_16)
              .paddingSymmetric(horizontal: margin_16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: TextFieldWidget(
                  hint: strExpiryDate,
                  textController: controller.expTextController,
                  focusNode: controller.expFocusNode,
                  borderColor: AppColors.textfieldborder,
                  inputType: TextInputType.number,
                  formatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                    CardMonthInputFormatter()
                  ],
                  inputAction: TextInputAction.next,
                  validate: (value) {
                    if (value != null && value.isNotEmpty) {
                      List<String> parts = value.split('/');
                      if (parts.length == 2) {
                        int month = int.tryParse(parts[0]) ?? 0;
                        int year = int.tryParse(parts[1]) ?? 0;
                        if (month < 1 || month > 12) {
                          return "Invalid month";
                        } else if (year == 0) {
                          return "Year is required";
                        } else {
                          int currentYear = DateTime.now().year % 100;
                          int currentMonth = DateTime.now().month;

                          if (year < currentYear || (year == currentYear && month < currentMonth)) {
                            return "Invalid expiry date";
                          }
                        }
                      } else {
                        return "Invalid Date";
                      }
                    } else {
                      return "Expiry date is required";
                    }
                    return null;
                  },
                ).paddingOnly(bottom: margin_16),

              ),
              SizedBox(
                width: margin_12,
              ),
              Flexible(
                child: TextFieldWidget(
                  hint: strCvv,
                  textController: controller.cvcTextController,
                  focusNode: controller.cvcFocusNode,
                  borderColor: AppColors.textfieldborder,
                  inputType: TextInputType.number,
                  formatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                  ],
                  validate: (value)
                  {
                    if(value==null || value.isEmpty)
                    {
                      return 'CVV number is required';
                    }
                    return null;
                  },

                  inputAction: TextInputAction.done,
                ).paddingOnly(bottom: margin_16),
              )
            ],
          ).paddingSymmetric(horizontal: margin_16),
          controller.isForAddNew
              ? SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      fillColor: MaterialStateColor.resolveWith(getColor),
                      checkColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      side: BorderSide(width: 1.5, color: AppColors.greyColor),
                      splashRadius: 0,
                      isError: true,
                      tristate: true,
                      value: controller.isChecked,
                      onChanged: (bool? value) {
                        controller.onChangeCheckValue();
                      },
                    ),
                    TextView(
                      text: strSaveCardForFuture,
                      textStyle: textStyleBodyMedium().copyWith(
                          color: AppColors.pricesColor,
                          fontWeight: FontWeight.w400,
                          fontSize: font_14),
                    ),
                  ],
                ).paddingSymmetric(horizontal: margin_6)
        ],
      ));

  Color getColor(Set<MaterialState> states) {
    return AppColors.borderColor;
  }
}
