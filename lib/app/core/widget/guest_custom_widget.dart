import '../../export.dart';

class CustommDialogWidget extends StatelessWidget {
  final String? title;
  final String confirmTitle;
  final Color? confirmBtnBgColor;
  final Color? cancelBtnBgColor;
  final Border? confirmBtnBorder;
  final Widget? textWidget;
  final Border? cancelBtnBorder;
  final String cancelTitle;
  final Color? cancelTitleColor;
  final Color? confirmTitleColor;
  final bool isImage;
  final String? image;
  final bool isCloseBtn;
  final bool isCustomizedTapCancel;
  final TextStyle? titleStyle;
  final dynamic onTapConfirm;
  final dynamic onTapCancel;
  final dynamic discretion;
  final dynamic gradient;

  const CustommDialogWidget(
      {super.key,
        this.title,
        required this.confirmTitle,
        required this.cancelTitle,
        required this.onTapConfirm,
        this.confirmBtnBgColor,
        this.confirmBtnBorder,
        this.isCloseBtn = true,
        this.isImage = false,
        this.image,
        this.discretion,
        this.cancelTitleColor,
        this.confirmTitleColor,
        this.cancelBtnBorder,
        this.cancelBtnBgColor,
        this.gradient,
        this.textWidget,
        this.onTapCancel,
        this.titleStyle,
        this.isCustomizedTapCancel = false});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Disable Android back button
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.all(margin_16),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(margin_16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(radius_8))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  isCloseBtn
                      ? Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const AssetSVGWidget(iconsCloseGray)))
                      : const SizedBox(),
                  textWidget ??
                      TextView(
                        textAlign: TextAlign.center,
                        text: title,
                        textStyle: titleStyle ??
                            textStyleBodyMedium().copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: font_20),
                      ).paddingSymmetric(vertical: margin_16),
                  isImage
                      ? Center(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radius_8),
                          border: Border.all(
                              color: AppColors.borderColor,
                              width: width_1)),
                      child: NetworkImageWidget(
                        imageHeight: height_60,
                        imageWidth: height_60,
                        imageUrl: image ?? "",
                      ).paddingSymmetric(
                          vertical: margin_20, horizontal: margin_20),
                    ).paddingOnly(bottom: margin_20),
                  )
                      : SizedBox(),
                  Row(
                    children: [
                      InkWell(
                        onTap: onTapConfirm,
                        child: _manageBtn(confirmTitle, confirmBtnBgColor,
                            confirmBtnBorder, confirmTitleColor),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: isCustomizedTapCancel
                            ? onTapCancel
                            : () {
                          Get.back();
                        },
                        child: _manageBtn(cancelTitle, cancelBtnBgColor,
                            cancelBtnBorder, cancelTitleColor),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _manageBtn(btnName, btnBgColor, border, titleColor) => Container(
    width: width_135,
    decoration: gradient ??
        BoxDecoration(
            borderRadius: BorderRadius.circular(radius_4),
            border: border,
            color: btnBgColor),
    child: Center(
      child: TextView(
        text: btnName,
        textStyle: TextStyle(
          fontSize: font_14,
          color: titleColor ?? Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ).paddingSymmetric(vertical: margin_12),
    ),
  ).paddingOnly(bottom: margin_8);
}
