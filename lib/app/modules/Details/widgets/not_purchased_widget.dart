import "../../../export.dart";

class NotPurchasedWidget extends StatelessWidget {
  const NotPurchasedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AssetSVGWidget(iconsNotPurchased)
                .paddingOnly(bottom: margin_20),
            TextView(
              text: strHaveNotPurchased,
              textStyle: textStyleBodyMedium().copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: font_16),
            ),
          ],
        ),
      ),
    );
  }
}
