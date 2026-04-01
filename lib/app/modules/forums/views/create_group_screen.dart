import 'package:quantity_savers/app/modules/forums/models/create_group_model.dart';
import 'package:quantity_savers/app/modules/forums/models/data_model/group_members_data_model.dart';

import '../../../export.dart';

class CreateGroupScreen extends StatelessWidget {
  final themeController = Get.put(ThemeController());
  final controller = Get.put(CreateGroupController());
  final GlobalKey<FormState> createGroupFormGlobalKey = GlobalKey<FormState>();

  CreateGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateGroupController>(
        init: CreateGroupController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              if (controller.currentPage > 1) {
                controller.navigateToPreviousPage();
                return false;
              }
              return true;
            },
            child: Scaffold(
              appBar: CustomAppBar(
                appBarTitleText: controller.isRouteFromGroupInfo == false
                    ? strCreateGroup.toUpperCase()
                    : strAddMembers.toUpperCase(),
                onTap: () {
                  (controller.currentPage > 1)
                      ? controller.navigateToPreviousPage()
                      : Get.back();
                },
                actionWidget: controller.isRouteFromGroupInfo == false
                    ? [
                        TextView(
                          text: "${(controller.currentPage.toInt())} of 3",
                          textStyle: textStyleBodyMedium().copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: font_13),
                        ).paddingOnly(right: margin_16)
                      ]
                    : [],
              ),
              body: Form(
                key: createGroupFormGlobalKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: PageView(
                        controller: controller.pageViewController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          if (controller.isRouteFromGroupInfo == false) ...[
                            _createGroup(),
                            _createdGroupPrivacyScreen(),
                          ],
                          _selectGroupMembers()
                        ],
                      ),
                    ),
                    controller.isRouteFromGroupInfo == false
                        ? BottomButtonWidget(
                            onPressed: () {
                              if (controller.currentPage == 3.0) {
                                controller.hitCreateGroupApi();
                              } else {
                                if (createGroupFormGlobalKey.currentState!
                                    .validate()) {
                                  FocusScope.of(context).unfocus();
                                  controller.navigateToNextPage();
                                }
                              }
                            },
                            btnTitle: ((controller.currentPage) == 1.0 ||
                                    (controller.currentPage) == 2.0)
                                ? strBtnNext
                                : strCreateGroup,
                          )
                        : BottomButtonWidget(
                            onPressed: () {
                              Get.back(result: controller.selectedMembersIds);
                            },
                            btnTitle: strAdd)
                  ],
                ),
              ),
            ),
          );
        });
  }

  _createGroup() => ListView(
        children: [
          TextView(
            text: strCreateGroup,
            textStyle: textStyleBodyMedium().copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: font_20),
          ),
          TextView(
            text: strNameGroup,
            textStyle: textStyleBodyMedium().copyWith(
                color: AppColors.categoriesgrey,
                fontWeight: FontWeight.w400,
                fontSize: font_14),
          ).paddingOnly(top: margin_8),
          TextFieldWidget(
            textController: controller.groupNameController,
            focusNode: controller.groupNameFocusNode,
            inputType: TextInputType.text,
            inputAction: TextInputAction.next,
            hint: strGroupNameField,
            validate: (value) => FieldChecker.fieldChecker(
                value: value, message: strFieldRequired),
          ).paddingSymmetric(vertical: margin_16),
          TextFieldWidget(
            textController: controller.requestController,
            focusNode: controller.requestFocusNode,
            inputType: TextInputType.text,
            inputAction: TextInputAction.done,
            minLine: 5,
            maxLines: 10,
            hint: strRequestOptional,
          ),
        ],
      ).paddingAll(margin_16);

  _createdGroupPrivacyScreen() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            text: strGroupPrivacy,
            textStyle: textStyleBodyMedium().copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: font_20),
          ).paddingAll(margin_16),
          TextView(
            text: strGroupVisibility,
            textStyle: textStyleBodyMedium().copyWith(
                color: AppColors.categoriesgrey,
                fontWeight: FontWeight.w400,
                fontSize: font_14),
          ).paddingOnly(left: margin_16, right: margin_16, bottom: margin_16),
          Expanded(
            child: Container(
                padding: EdgeInsets.only(left: margin_6),
                child: ListView.separated(
                  itemCount: CreateGroupModel().groupPrivacy.length,
                  itemBuilder: (context, index) {
                    return RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      visualDensity: const VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: controller.groupPrivacyList[index]["value"],
                      groupValue: controller.selectedPrivacyType,
                      onChanged: (value) {
                        controller.selectedPrivacyType = value!;
                        controller.update();
                      },
                      title: TextView(
                        text: CreateGroupModel().groupPrivacy[index]["privacy"],
                        textAlign: TextAlign.start,
                        textStyle: textStyleBodyMedium().copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: font_15),
                      ),
                      subtitle: index == 1
                          ? TextView(
                              text: strCanOnlyViewed,
                              textAlign: TextAlign.start,
                              textStyle: textStyleBodyMedium().copyWith(
                                  color: AppColors.categoriesgrey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: font_12),
                            )
                          : null,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(margin_16),
                      child: const Divider(
                        color: AppColors.textfieldborder,
                      ),
                    );
                  },
                )),
          )
        ],
      );

  Color getColor(Set<MaterialState> states) {
    return AppColors.gradientColorSecondary;
  }

  _selectGroupMembers() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldWidget(
            borderRadius: radius_1,
            hint: strSearchByNameOrEmail,
            onTap: () async {
              var result = await Get.toNamed(AppRoutes.searchOnHomeScreenRoute,
                  arguments: {argGroup: true, argMember: true , argSelectedMembers: controller.selectedMembersIds});
              if (result != null) {
                controller.selectedItems = result[argSelectedMembers];
                debugPrint("selectedItems on CreateGroupScreen is ${controller.selectedItems}");

                List<int> selectedIndices = [];
                List<String> selectedIds = [];

                for (var itemId in controller.selectedItems) {
                  int index = controller.groupMembersResponseModel.data?.indexWhere((element) => element.sId == itemId) ?? -1;
                  if (index != -1) {
                    selectedIndices.add(index);
                    selectedIds.add(itemId);
                  }
                }


                controller.onSelectionChangeSearchFieldSelected(selectedIndices, selectedIds);
              }
            },
            prefixIcon: UnconstrainedBox(
              child: AssetSVGWidget(
                imageHeight: height_25,
                iconsSearchGreen,
              ),
            ),
          ).paddingOnly(bottom: margin_16),
          (controller.groupMembersResponseModel.data ?? [])
                  .where((element) => element.isSelected == true)
                  .toList()
                  .isNotEmpty
              ? SizedBox(
                  height: height_100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.groupMembersResponseModel.data!
                        .where((element) => element.isSelected == true)
                        .toList()
                        .length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var item = controller.groupMembersResponseModel.data!
                          .where((element) => element.isSelected == true)
                          .toList()[index];
                      return Column(
                        children: [
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              NetworkImageWidget(
                                  imageUrl: item.profilePic ?? "",
                                  imageHeight: height_50,
                                  imageWidth: height_50,
                                  radiusAll: radius_50,
                                  imageFitType: BoxFit.fill,
                                  placeHolder: iconsProfilePlaceholderS),
                              InkWell(
                                onTap: () {
                                  item.isSelected = false;
                                  controller.selectedMembersIds
                                      .remove(item.sId);
                                  controller.update();
                                },
                                child: Container(
                                  width: width_16,
                                  height: height_16,
                                  padding: EdgeInsets.all(margin_4),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: const AssetSVGWidget(
                                    iconsCroses,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ).paddingOnly(bottom: margin_4),
                          TextView(
                            text: "${item.name}",
                            textStyle: textStyleBodyMedium().copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: font_10),
                          ),
                        ],
                      ).paddingSymmetric(horizontal: margin_8);
                    },
                  ),
                )
              : const SizedBox(),
          TextView(
            text: strSelectGroupMember.toUpperCase(),
            textStyle: textStyleBodyMedium().copyWith(
                color: AppColors.categoriesgrey,
                fontWeight: FontWeight.w500,
                fontSize: font_14),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.groupMembersResponseModel.data?.length ?? 0,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return _membersList(
                    controller.groupMembersResponseModel.data?[index], index);
              },
            ),
          )
          // _membersList()
        ],
      ).paddingAll(margin_16);

  // _membersList(GroupMembersDataModel? data, int index) => Row(
  //       children: [
  //         NetworkImageWidget(
  //             imageUrl: data?.profilePic ?? "",
  //             imageHeight: height_30,
  //             imageWidth: height_30,
  //             radiusAll: height_30,
  //             imageFitType: BoxFit.fill,
  //             placeHolder: iconsProfilePlaceholderS),
  //         TextView(
  //           text: "${data?.name}",
  //           textStyle: textStyleBodyMedium().copyWith(
  //               color: Colors.black,
  //               fontWeight: FontWeight.w500,
  //               fontSize: font_16),
  //         ).paddingOnly(left: margin_12),
  //         const Spacer(),
  //         SizedBox(
  //           height: height_20,
  //           width: width_20,
  //           child: Checkbox(
  //             side: MaterialStateBorderSide.resolveWith(
  //                 (states) => const BorderSide(color: AppColors.DustyGray)),
  //             activeColor: AppColors.gradientColorSecondary,
  //             shape: const CircleBorder(),
  //             value: data?.isSelected,
  //             onChanged: (bool? value) {
  //               controller.onSelectionChange(index, data?.sId);
  //             },
  //           ),
  //         )
  //       ],
  //     ).paddingSymmetric(vertical: margin_8);
  _membersList(GroupMembersDataModel? data, int index) => GestureDetector(
    onTap: () {
      bool? currentSelection = data?.isSelected;
      controller.onSelectionChange(index, data?.sId);
    },
    child: Row(
      children: [
        NetworkImageWidget(
            imageUrl: data?.profilePic ?? "",
            imageHeight: height_30,
            imageWidth: height_30,
            radiusAll: height_30,
            imageFitType: BoxFit.fill,
            placeHolder: iconsProfilePlaceholderS),
        TextView(
          text: "${data?.name}",
          textStyle: textStyleBodyMedium().copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: font_16),
        ).paddingOnly(left: margin_12),
        const Spacer(),
        SizedBox(
          height: height_20,
          width: width_20,
          child: Checkbox(
            side: MaterialStateBorderSide.resolveWith(
                    (states) => const BorderSide(color: AppColors.DustyGray)),
            activeColor: AppColors.gradientColorSecondary,
            shape: const CircleBorder(),
            value: data?.isSelected,
            onChanged: (bool? value) {
              controller.onSelectionChange(index, data?.sId);
            },
          ),
        )
      ],
    ).paddingSymmetric(vertical: margin_8),
  );

}
