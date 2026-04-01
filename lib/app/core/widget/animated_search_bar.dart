import "../../export.dart";

class AnimatedSearchBarWidget extends StatelessWidget {
  bool folded;
  final dynamic onSearchIconTap;
  final dynamic onCloseIconTap;

  AnimatedSearchBarWidget(
      {super.key, this.onSearchIconTap, required this.folded,this.onCloseIconTap});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
          color: folded ? Colors.transparent : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(radius_8))),
      width: folded ? width_65 : Get.width / 1.2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (!folded)
            AssetSVGWidget(
              Assets.iconsSearch,
              color: AppColors.categoriesgrey,
              imageHeight: height_12,
              imageWidth: width_12,
            ).paddingSymmetric(horizontal: margin_10),
          Expanded(
              flex: 2,
              child: InkWell(
                onTap: folded?null:onSearchIconTap,
                child: Container(
                  child: folded
                      ? null
                      : TextFieldWidget(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: margin_6,
                          ),
                          decoration: InputBorder.none,
                          hint: "Search",

                          hintStyle: const TextStyle(color: Colors.black),
                        ),
                ),
              )),
          InkWell(
              onTap:folded? onSearchIconTap:onCloseIconTap,
              splashColor: Colors.transparent,
              child: Container(
                padding: EdgeInsets.only(right: margin_5),
                child: folded
                    ? const Icon(
                        Icons.search,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.close,
                        color: AppColors.greyColor,
                      ),
              ))
        ],
      ),
    ).marginSymmetric(vertical: margin_6, horizontal: margin_10);
  }
}
