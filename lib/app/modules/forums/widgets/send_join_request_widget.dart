import "../../../export.dart";

class SendJoinRequestWidget extends StatelessWidget {
  final dynamic groupName;
  final dynamic bottomBtnWidget;
  final dynamic textEditingController;
  final dynamic focusNode;

  const SendJoinRequestWidget(
      {super.key,
      required this.groupName,
      this.bottomBtnWidget,
      this.textEditingController,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitleText: strSendJoinRequest.toUpperCase(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(margin_16),
              child: ListView(
                children: [
                  TextView(
                    text: "$strJoinPrivateGroup$groupName",
                    textStyle: textStyleBodyMedium().copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: font_20),
                  ),
                  TextView(
                    text: strPleaseEnterDescription,
                    textStyle: textStyleBodyMedium().copyWith(
                        color: AppColors.categoriesgrey,
                        fontWeight: FontWeight.w400,
                        fontSize: font_14),
                  ).paddingOnly(top: margin_10, bottom: margin_20),
                  TextFieldWidget(
                    textController: textEditingController,
                    focusNode: focusNode,
                    validate: (value) => FieldChecker.fieldChecker(
                        value: value, message: strFieldRequired),
                    hint: strEnterYourMessage,
                    minLine: 5,
                    maxLines: 10,
                  )
                ],
              ),
            ),
          ),
          bottomBtnWidget
        ],
      ),
    );
  }
}
