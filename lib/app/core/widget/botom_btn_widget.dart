import '../../export.dart';

class BotomButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String btnTitle;
  final Color? btnBgColor;
  final bool isBorderColor;
  final Widget? iconWidget;

  const BotomButtonWidget({
    super.key,
    required this.onPressed,
    required this.btnTitle,
    this.btnBgColor,
    this.isBorderColor = true,
    this.iconWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 105,
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: 30,
      ),
      child: MateriallButtonWidget(
        minHeight: 40,
        onPressed: onPressed,
        buttonText: btnTitle.toUpperCase(),
        buttonBgColor: btnBgColor ?? AppColors.gradient2nd,
        buttonTextStyle: textStyleBodyMedium().copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        iconWidget: iconWidget,
      ),
    );
  }
}

class MateriallButtonWidget extends StatelessWidget {
  final double minHeight;
  final VoidCallback onPressed;
  final String buttonText;
  final Color buttonBgColor;
  final TextStyle buttonTextStyle;
  final Widget? iconWidget;

  const MateriallButtonWidget({
    super.key,
    required this.minHeight,
    required this.onPressed,
    required this.buttonText,
    required this.buttonBgColor,
    required this.buttonTextStyle,
    this.iconWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          height: minHeight,
          color: buttonBgColor,
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    buttonText,
                    textAlign: TextAlign.center,
                    style: buttonTextStyle,
                  ),
                ),
              ),
              if (iconWidget != null)
                Container(
                  padding: const EdgeInsets.only(right: 16),
                  child: iconWidget,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
