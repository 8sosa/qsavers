import 'package:flutter/material.dart';

import '../../../export.dart';


class MateriialButtonWidget extends StatefulWidget {
  final String? buttonText;
  final TextStyle? buttonTextStyle;
  final Color? buttonBgColor;
  final Color? textColor;
  final double? buttonRadius;
  final double? minWidth;
  final double? minHeight;
  final double? verticalPadding;
  final double? horizontalPadding;
  final Future<void> Function()? onPressed;
  final double? elevation;
  final Color? borderColor;
  final double? borderWidth;
  final Widget? widget;
  final Widget? iconWidget;
  final bool isOutlined;
  final int? isContact;
  final bool? iconInRight;

  const MateriialButtonWidget({
    Key? key,
    this.buttonText = "",
    this.buttonBgColor,
    this.buttonTextStyle,
    this.textColor,
    this.buttonRadius,
    required this.onPressed,
    this.elevation,
    this.borderColor,
    this.borderWidth,
    this.minWidth,
    this.minHeight,
    this.verticalPadding,
    this.horizontalPadding,
    this.widget,
    this.iconWidget,
    this.isContact,
    this.isOutlined = false,
    this.iconInRight = false,
  }) : super(key: key);

  @override
  _MaterialButtonWidgetState createState() => _MaterialButtonWidgetState();
}

class _MaterialButtonWidgetState extends State<MateriialButtonWidget> {
  bool _isLoading = false;

  void _handlePressed() async {
    if (widget.onPressed != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        await widget.onPressed!();
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: widget.minHeight ?? 48.0,
      splashColor: Colors.transparent,
      minWidth: widget.minWidth ?? MediaQuery.of(context).size.width,
      color: widget.isOutlined
          ? widget.buttonBgColor ?? Colors.white
          : (widget.buttonBgColor ?? AppColors.appColor),
      elevation: widget.elevation ?? 0.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: widget.isOutlined
              ? (widget.borderColor ?? AppColors.appColor)
              : Colors.transparent,
          width: widget.isOutlined ? 1.0 : 0.0,
        ),
        borderRadius: BorderRadius.circular(widget.buttonRadius ?? 8.0),
      ),
      onPressed: _isLoading ? null : _handlePressed,
      padding: EdgeInsets.symmetric(
        vertical: widget.verticalPadding ?? 8.0,
        horizontal: widget.horizontalPadding ?? 20.0,
      ),
      child: _isLoading
          ? CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          widget.textColor ?? Colors.black,
        ),
      )
          : widget.widget ??
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!(widget.iconInRight ?? false))
                widget.iconWidget ?? const SizedBox(),
              const SizedBox(width: 8),
              Text(
                widget.buttonText ?? '',
                style: widget.buttonTextStyle ??
                    TextStyle(
                      fontWeight: FontWeight.w600,
                      color: widget.isOutlined
                          ? widget.textColor ?? Colors.black
                          : widget.textColor ?? Colors.black,
                      fontSize: 14,
                    ),
              ),
              const SizedBox(width: 8),
              if (widget.iconInRight ?? false)
                widget.iconWidget ?? const SizedBox(),
            ],
          ),
    );
  }
}
