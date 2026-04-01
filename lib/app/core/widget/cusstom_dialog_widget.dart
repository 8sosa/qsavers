import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Assuming you are using GetX for navigation and state management
import '../../export.dart'; // Adjust the import path as necessary

class CusstomDialogWidget extends StatefulWidget {
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
  final Future<void> Function()? onTapConfirm;
  final dynamic onTapCancel;
  final dynamic discretion;
  final dynamic gradient;

  const CusstomDialogWidget({
    Key? key,
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
    this.isCustomizedTapCancel = false,
  }) : super(key: key);

  @override
  _CusstomDialogWidgetState createState() => _CusstomDialogWidgetState();
}

class _CusstomDialogWidgetState extends State<CusstomDialogWidget> {
  bool _isLoading = false;

  void _handleConfirmPressed() async {
    if (widget.onTapConfirm != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        await widget.onTapConfirm!();
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                widget.isCloseBtn
                    ? Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.close), // Replace with AssetSVGWidget if needed
                  ),
                )
                    : const SizedBox(),
                widget.textWidget ??
                    Text(
                      widget.title ?? '',
                      textAlign: TextAlign.center,
                      style: widget.titleStyle ??
                          TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                    ).paddingSymmetric(vertical: 16.0),
                widget.isImage
                    ? Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: Image.network(
                      widget.image ?? '',
                      height: 60,
                      width: 60,
                    ).paddingSymmetric(
                      vertical: 20.0,
                      horizontal: 20.0,
                    ),
                  ).paddingOnly(bottom: 20.0),
                )
                    : SizedBox(),
                Row(
                  children: [
                    InkWell(
                      onTap: _isLoading ? null : _handleConfirmPressed,
                      child: _manageBtn(
                        _isLoading
                            ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            widget.confirmTitleColor ?? Colors.white,
                          ),
                        )
                            : Text(
                          widget.confirmTitle,
                          style: TextStyle(
                            fontSize: 14,
                            color: widget.confirmTitleColor ?? Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        widget.confirmBtnBgColor,
                        widget.confirmBtnBorder,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: widget.isCustomizedTapCancel
                          ? widget.onTapCancel
                          : () {
                        Get.back();
                      },
                      child: _manageBtn(
                        Text(
                          widget.cancelTitle,
                          style: TextStyle(
                            fontSize: 14,
                            color: widget.cancelTitleColor ?? Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        widget.cancelBtnBgColor,
                        widget.cancelBtnBorder,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _manageBtn(Widget content, Color? btnBgColor, Border? border) {
    return Container(
      width: 135,
      decoration: widget.gradient ??
          BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: border,
            color: btnBgColor,
          ),
      child: Center(
        child: content.paddingSymmetric(vertical: 12.0),
      ),
    ).paddingOnly(bottom: 8.0);
  }
}
