import 'package:quantity_savers/app/modules/home/controllers/sub_categor_controller.dart';
import '../../../export.dart';

class SubCategoryScreen extends StatelessWidget {
  final controller = Get.put(SubCategoryController());
  final themeController = Get.put(ThemeController());

  SubCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubCategoryController>(
        init: SubCategoryController(),
        builder: (context) {
          return Scaffold(
            appBar: CustomAppBar(
              appBarTitleText: controller.title.toUpperCase(),
            ),
            body: controller.isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(
                    color: AppColors.gradient2nd,
                  ))
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: controller.productSubCategoryResponseModel
                                  .data?.totalCount ??
                              0,
                          itemBuilder: (context, index) {
                            var subCategory = controller
                                .productSubCategoryResponseModel
                                .data
                                ?.data?[index];
                            var subSubCategories = controller
                                .subSubCategoryMap[subCategory?.sId ?? ''];
                            return Padding(
                              padding: const EdgeInsets.only(
                                left: 28.0,
                                right: 28.0,
                                bottom: 20.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextView(
                                    text: subCategory?.name,
                                    textStyle: textStyleTitleLarge().copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: font_18,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: (subSubCategories ?? [])
                                          .map((subSubCategory) {
                                        return Material(
                                          type: MaterialType.transparency,
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.toNamed(
                                                  AppRoutes
                                                      .vendorsProductsScreenRoute,
                                                  arguments: {
                                                    argSubCategory: true,
                                                    argCategoryId:
                                                        controller.categoryId,
                                                    argSubCategoryId:
                                                        subCategory?.sId,
                                                    argSubSubCategoryId:
                                                        subSubCategory['id'],
                                                    argTitle:
                                                        subSubCategory['name'],
                                                  });
                                              debugPrint(
                                                  "cat id is ${controller.categoryId}");
                                              debugPrint(
                                                  "SubCat id is ${subCategory?.sId}");
                                              debugPrint(
                                                  "SubSubCat id is ${subSubCategory['id']}");
                                            },
                                            child: Chip(
                                              label: Container(
                                                padding: const EdgeInsets.only(
                                                    left: 12.0,
                                                    right: 12.0,
                                                    top: 8.0,
                                                    bottom: 8.0),
                                                decoration: BoxDecoration(
                                                  color: AppColors.gradient2nd,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
                                                ),
                                                child: TextView(
                                                  text:
                                                      subSubCategory['name'] ??
                                                          "",
                                                  textStyle:
                                                      textStyleTitleLarge()
                                                          .copyWith(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: font_12,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  if (index <
                                      (controller.productSubCategoryResponseModel
                                                  .data?.totalCount ??
                                              0) -
                                          1)
                                    const Divider(thickness: 2,
                                      color: Colors.black26,
                                    ).paddingOnly(top: 12),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
          );
        });
  }
}
