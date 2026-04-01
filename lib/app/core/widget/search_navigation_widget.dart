import "../../export.dart";

class SearchNavigationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              colors: [AppColors.gradient1st, AppColors.gradient2nd]),
        ),
        child: InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.searchOnHomeScreenRoute);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: margin_6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius_8),
                color: Colors.white),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: width_16),
                TextView(
                  text: "Search for products, brands and...",
                  textStyle: textStyleBodyMedium().copyWith(
                      color: AppColors.greyColor, fontWeight: FontWeight.w400),
                ),
                const Spacer(),
                const Icon(Icons.search, color: AppColors.gradient2nd),
                SizedBox(width: margin_16)
              ],
            ),
          ),
        )).paddingOnly(top: margin_20, bottom: margin_20, right: margin_12);
  }
}
