import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:quantity_savers/app/core/utils/time_conversion.dart";
import "package:quantity_savers/app/modules/forums/models/create_group_model.dart";
import "../../../export.dart";

class GroupInfoScreen extends StatelessWidget {
  final themeController = Get.put(ThemeController());
  final controller = Get.put(GroupInfoController());

  GroupInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GroupInfoController>(
      init: GroupInfoController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(
            appBarTitleText: controller.isDefaultGroup == true
                ? strForumInfo.toUpperCase()
                : strGroupInfo.toUpperCase(),
          ),
          body:controller.isLoading==true?const Center(child: CircularProgressIndicator(color: AppColors.gradient2nd,)): controller.isSearchedForum == true &&
                  controller.groupInfoResponseModel?.data?.isJoined == 0
              ? _publicGroupInfo()
              : controller.isDefaultGroup == true
                  ? Column(
                      children: [
                        quantitySaverGroupDetails(),
                        mediaInfo(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextView(
                                text:
                                    "Members (${controller.groupInfoResponseModel?.data?.groupMembers?.length ?? 0})",
                                textStyle: textStyleBodyLarge().copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: font_18)),
                            const Spacer(),
                            // TextView(
                            //     text:
                            //         "${controller.totalOnlineCount} members online",
                            //     textStyle: textStyleBodyLarge().copyWith(
                            //         color: AppColors.categoriesgrey,
                            //         fontWeight: FontWeight.w600,
                            //         fontSize: font_14)),
                          ],
                        ).paddingOnly(bottom: margin_16),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.groupInfoResponseModel?.data
                                    ?.groupMembers?.length ??
                                0,
                            itemBuilder: (context, index) {
                              return _forumsMembersList(controller
                                  .groupInfoResponseModel
                                  ?.data
                                  ?.groupMembers?[index]);
                            },
                          ),
                        )
                      ],
                    ).paddingAll(margin_16)
                  : ListView(
                      children: [
                        _groupDetails(),
                        mediaInfo(),
                        _groupMembers(),
                        ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return _campaignInfo(index);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider(
                                color: AppColors.textfieldborder,
                              );
                            },
                            itemCount: controller.groupCampaignResponseModel
                                    .data?.data?.length ??
                                0)
                      ],
                    ).paddingAll(margin_16),
        );
      },
    );
  }

  _groupDetails() {
    var item = controller.groupInfoResponseModel?.data;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
          text: strGroupDetails,
          textStyle: textStyleBodyMedium().copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: font_18),
        ).paddingOnly(bottom: margin_8),
        _groupListItem(
            strName,
            "${item?.groupName}",
            [
              InkWell(
                onTap: () {
                  controller.groupNameEditingController.text = item?.groupName;
                  controller.update();
                  Get.dialog(_updateGroupScreen(
                      title: "Enter the name of the group",
                      updateWidget: TextFieldWidget(
                        textController: controller.groupNameEditingController,
                        focusNode: controller.groupNameFocusNode,
                        hint: "Group Name",
                        formatter: const [],
                        inputAction: TextInputAction.next,
                        validate: (value) => FieldChecker.fieldChecker(
                            value: value, message: strFieldRequired),
                      ).paddingOnly(bottom: margin_16, top: margin_8)));
                },
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: const AssetSVGWidget(
                    iconsPencil,
                    color: AppColors.gradientColorPrimary,
                  ),
                ),
              )
            ],
            null),
        _groupListItem(strVisibility, "${item?.groupType}".capitalize ?? "", [
          InkWell(
            onTap: () {
              Get.dialog(_updateGroupScreen(
                  title: "Select the group visibility",
                  updateWidget: _groupPrivacyScreen()));
            },
            child: SizedBox(
              width: 20,
              height: 20,
              child: const AssetSVGWidget(
                iconsPencil,
                color: AppColors.gradientColorPrimary,
              ),
            ),
          )
        ], [
          AssetSVGWidget(
            item?.groupType == strPrivate ? iconsIconsLockClose : iconsLockOpen,
            imageHeight: height_18,
          ).paddingOnly(right: margin_4)
        ]),
        _groupListItem(
            "Created By",
            " ${item?.createdBy?.name} ${controller.userLoggedInId == item?.createdBy?.sId ? "(You)" : ""}",
            null, [
          NetworkImageWidget(
            imageUrl: item?.createdBy?.profilePic ?? '',
            radiusAll: radius_50,
            imageHeight: height_30,
            imageWidth: height_30,
            imageFitType: BoxFit.cover,
            placeHolder: iconsProfilePlaceholderL,
          )
        ]),
        const Divider(
          color: AppColors.textfieldborder,
        ).marginOnly(top: margin_12)
      ],
    );
  }

  quantitySaverGroupDetails() {
    var item = controller.groupInfoResponseModel?.data;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
          text: strGroupDetails,
          textStyle: textStyleBodyMedium().copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: font_18),
        ).paddingOnly(bottom: margin_8),
        _groupListItem(strName, "${item?.groupName}", [], null),
        _groupListItem(
            strVisibility, "${item?.groupType}".capitalize ?? "", [], [
          AssetSVGWidget(
            item?.groupType == strPrivate ? iconsIconsLockClose : iconsLockOpen,
            imageHeight: height_18,
          ).paddingOnly(right: margin_4)
        ]),
        _groupListItem("Created By", "Admin", null, []),
        const Divider(
          color: AppColors.textfieldborder,
        ).marginOnly(top: margin_12)
      ],
    );
  }

  mediaInfo() {
    return InkWell(
      onTap: ()
      {
        Get.toNamed(AppRoutes.forumMediaRoute, arguments: {
          argGroupId: controller.groupInfoResponseModel?.data?.sId
        });
      },
      child: Column(
        children: [
          Row(
            children: [
              TextView(
                text: "Media,Links and Docs",
                textStyle: textStyleBodyMedium().copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: font_18),
              ),
              Spacer(),
              controller.forumMediaResponseModel.data?.count==0?SizedBox():TextView(
                text: "${controller.forumMediaResponseModel.data?.count}",
                textStyle: textStyleBodyMedium().copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: font_16),
              ),
              IconButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.forumMediaRoute, arguments: {
                      argGroupId: controller.groupInfoResponseModel?.data?.sId
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.black87,
                    size: 20,
                  ))
            ],
          ),
          const Divider(
            color: AppColors.textfieldborder,
          ).marginOnly(bottom: margin_12)
        ],
      ),
    );
  }

  _groupPrivacyScreen() => ListView.separated(
        shrinkWrap: true,
        itemCount: CreateGroupModel().groupPrivacy.length,
        itemBuilder: (context, index) {
          return GetBuilder<GroupInfoController>(
            builder: (controller) {
              return RadioListTile<int>(
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
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            color: AppColors.textfieldborder,
          );
        },
      ).paddingOnly(bottom: margin_16, top: margin_8);

  _updateGroupScreen({required String title, required Widget updateWidget}) {
    return CustomDialogWidget(
      confirmBtnBgColor: AppColors.gradientColorSecondary,
      cancelBtnBorder: Border.all(color: AppColors.textfieldborder),
      cancelTitleColor: AppColors.lightBlackColor,
      textWidget: Column(
        children: [
          TextView(
            text: title,
            textStyle: textStyleBodyMedium().copyWith(
                color: AppColors.categoriesgrey,
                fontWeight: FontWeight.w500,
                fontSize: font_16),
          ),
          updateWidget
        ],
      ),
      confirmTitle: strUpdate,
      cancelTitle: strNo,
      onTapConfirm: () {
        if (controller.groupNameEditingController.text == "") {
          showToast(message: "Please enter a valid group name");
        } else {
          Get.back();
          controller.hitUpdateGroupApi();
        }
      },
      isImage: false,
      isCloseBtn: true,
    );
  }

  _groupListItem(String detailType, String detailValue, List<Widget>? icon,
          List<Widget>? prefixIcon) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextView(
                text: "${detailType.capitalize}:",
                textStyle: textStyleBodyMedium().copyWith(
                    color: AppColors.categoriesgrey,
                    fontWeight: FontWeight.w400,
                    fontSize: font_14),
              ),
              const Spacer(),
              ...?prefixIcon,
              detailType == strEndDateAndTime
                  ? Container(
                      decoration: BoxDecoration(
                        color: AppColors.catBackgroundColor,
                        borderRadius:
                            BorderRadius.all(Radius.circular(radius_6)),
                      ),
                      child: TextView(
                        text: detailValue,
                        textStyle: textStyleBodyLarge().copyWith(
                            color: AppColors.gradientColorSecondary,
                            fontWeight: FontWeight.w600,
                            fontSize: font_12),
                      ).paddingSymmetric(
                          vertical: margin_4, horizontal: margin_8),
                    )
                  : TextView(
                      text: detailValue,
                      textStyle: textStyleBodyMedium().copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: font_14),
                    ).paddingOnly(right: margin_4),
              if (controller.userLoggedInId ==
                  controller.groupInfoResponseModel?.data?.createdBy?.sId)
                ...?icon
            ],
          )
        ],
      ).paddingSymmetric(vertical: margin_8);

  _groupMembers() {
    var item = controller.groupInfoResponseModel?.data;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextView(
              text: "$strGroupMembers (${item?.groupMembers?.length ?? 0})",
              textStyle: textStyleBodyMedium().copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: font_18),
            ),
            if (item?.isOrganiser == true) ...[
              const Spacer(),
              IconButton(
                  onPressed: () async {
                    var result = await Get.toNamed(AppRoutes.createGroupRoute,
                        arguments: {argIsRouteFromGroupInfo: true});
                    controller.selectedMembersIds = result;
                    controller.update();
                    controller.hitUpdateGroupApi();
                  },
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: AppColors.gradientColorSecondary,
                  ))
            ]
          ],
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: item?.groupMembers?.length ?? 0,
          itemBuilder: (context, index) {
            return _membersList(item?.groupMembers?[index]);
          },
        ),
        const Divider(
          color: AppColors.textfieldborder,
        ).marginOnly(top: margin_12)
      ],
    ).paddingSymmetric(vertical: margin_16);
  }

  _membersList(dynamic groupMember) {
    return Row(
      children: [
        NetworkImageWidget(
            imageUrl: groupMember.profilePic ?? "",
            imageHeight: height_30,
            imageWidth: height_30,
            radiusAll: radius_50,
            imageFitType: BoxFit.fill,
            placeHolder: iconsProfilePlaceholderS),
        TextView(
          text:
              "${groupMember?.name}${controller.userLoggedInId == groupMember.sId ? " (You)" : ""}",
          textStyle: textStyleBodyMedium().copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: font_16),
        ).paddingOnly(left: margin_12),
        const Spacer(),
        if (groupMember?.role == "ORGANISER") ...[
          Container(
            decoration: BoxDecoration(
              color: AppColors.catBackgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(radius_6)),
            ),
            child: TextView(
              text: "Organizer",
              textStyle: textStyleBodyLarge().copyWith(
                  color: AppColors.gradientColorSecondary,
                  fontWeight: FontWeight.w500,
                  fontSize: font_12),
            ).paddingSymmetric(vertical: margin_4, horizontal: margin_8),
          )
        ],
        if ((controller.groupInfoResponseModel?.data?.isOrganiser == false) ||
            groupMember?.role == "MEMBER") ...[
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            surfaceTintColor: Colors.transparent,
            color: Colors.white,
            itemBuilder: (context) {
              return [
                if (controller.groupInfoResponseModel?.data?.isOrganiser ==
                    true) ...[
                  PopupMenuItem(
                    onTap: () {
                      Get.dialog(_manageMembersPopup(
                          groupMember: groupMember, manageType: "ORGANISER"));
                    },
                    height: height_40,
                    child: TextView(
                      text: strMakeGroupOrganizer,
                      textStyle: textStyleBodyMedium().copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: font_14),
                    ),
                  ),
                ],
                if (controller.groupInfoResponseModel?.data?.isOrganiser ==
                    true) ...[
                  PopupMenuItem(
                      height: height_2,
                      child: const Divider(
                        color: AppColors.textfieldborder,
                      )),
                ],
                if (controller.groupInfoResponseModel?.data?.isOrganiser ==
                    true) ...[
                  if (groupMember?.isBlocked == true) ...[
                    PopupMenuItem(
                      onTap: () {
                        Get.dialog(_manageMembersPopup(
                            groupMember: groupMember, manageType: "UNBLOCK"));
                      },
                      height: height_40,
                      child: TextView(
                        text: "Unblock Member",
                        textStyle: textStyleBodyMedium().copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: font_14),
                      ),
                    ),
                  ] else ...[
                    PopupMenuItem(
                      onTap: () {
                        Get.dialog(_manageMembersPopup(
                            groupMember: groupMember, manageType: "BLOCK"));
                      },
                      height: height_40,
                      child: TextView(
                        text: strBlockMember,
                        textStyle: textStyleBodyMedium().copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: font_14),
                      ),
                    ),
                  ],
                ],
                if (controller.groupInfoResponseModel?.data?.isOrganiser ==
                    true) ...[
                  PopupMenuItem(
                      height: height_2,
                      child: const Divider(
                        color: AppColors.textfieldborder,
                      )),
                ],
                PopupMenuItem(
                  onTap: () {
                    Get.dialog(_manageReportMembersPopup(
                        groupMember: groupMember, manageType: "REPORT"));
                  },
                  height: height_40,
                  child: TextView(
                    text: strReportMember,
                    textStyle: textStyleBodyMedium().copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: font_14),
                  ),
                ),
                if (controller.groupInfoResponseModel?.data?.isOrganiser ==
                    true) ...[
                  PopupMenuItem(
                      height: height_2,
                      child: const Divider(
                        color: AppColors.textfieldborder,
                      )),
                ],
                if (controller.groupInfoResponseModel?.data?.isOrganiser ==
                    true) ...[
                  PopupMenuItem(
                    onTap: () {
                      Get.dialog(_manageMembersPopup(
                          groupMember: groupMember, manageType: "REMOVE"));
                    },
                    height: height_40,
                    child: TextView(
                      text: strRemoveFromGroup,
                      textStyle: textStyleBodyMedium().copyWith(
                          color: AppColors.lightRedColor,
                          fontWeight: FontWeight.w500,
                          fontSize: font_14),
                    ),
                  ),
                ],
              ];
            },
          )
        ]
      ],
    ).paddingSymmetric(vertical: margin_8);
  }

  _manageMembersPopup({required groupMember, required manageType}) {
    return CustomDialogWidget(
      title:
          "$strWantTo ${manageType == "ORGANISER" ? "make " : manageType == "REMOVE" ? "remove " : manageType == "BLOCK" ? "block " : manageType == "UNBLOCK" ? "unblock" : ""} ${groupMember?.name} ${manageType == "ORGANISER" ? strGroupOrganizer : manageType == "REMOVE" ? strFromTheGroup : manageType == "BLOCK" ? strFromTheGroup : ""}",
      confirmTitle: manageType == "ORGANISER"
          ? strYes
          : manageType == "REMOVE"
              ? strYesRemove
              : strYes,
      cancelTitle: strNo,
      confirmBtnBgColor: manageType == "ORGANISER"
          ? AppColors.gradientColorSecondary
          : Colors.red,
      cancelBtnBorder: Border.all(color: AppColors.textfieldborder),
      cancelTitleColor: AppColors.lightBlackColor,
      onTapConfirm: () {
        Get.back();
        controller.memberId = groupMember?.sId;
        controller.editMemberType = manageType;
        controller.update();
        controller.hitEditMemberApi();
      },
    );
  }

  _manageReportMembersPopup({required groupMember, required manageType}) {
    return CustomDialogWidget(
      title:
          "$strWantTo ${manageType == "REPORT" ? "report" : ""} ${groupMember?.name} from the group.",
      confirmTitle: strYes,
      cancelTitle: strNo,
      confirmBtnBgColor: manageType == "ORGANISER"
          ? AppColors.gradientColorSecondary
          : Colors.red,
      cancelBtnBorder: Border.all(color: AppColors.textfieldborder),
      cancelTitleColor: AppColors.lightBlackColor,
      onTapConfirm: () {
        Get.back();
        Get.toNamed(AppRoutes.reportMember,
            arguments: {argMemberId: groupMember?.sId});
      },
    );
  }

  _forumsMembersList(dynamic groupMember) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        NetworkImageWidget(
            imageUrl: groupMember.profilePic ?? "",
            imageHeight: height_30,
            imageWidth: height_30,
            radiusAll: radius_50,
            imageFitType: BoxFit.fill,
            placeHolder: iconsProfilePlaceholderS),
        TextView(
          text: "${groupMember?.name}",
          textStyle: textStyleBodyMedium().copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: font_16),
        ).paddingOnly(left: margin_12, right: margin_8),
        if (groupMember?.isOnline == 1) ...[
          const AssetSVGWidget(Assets.iconsOnlineStatus)
        ]
      ],
    ).paddingSymmetric(vertical: margin_8);
  }

  Color getColor(Set<MaterialState> states) {
    return AppColors.gradientColorPrimary;
  }

  _campaignInfo(int index) {
    var data = controller.groupCampaignResponseModel.data?.data?[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TextView(
              text: strCampaignInfo,
              textStyle: textStyleBodyMedium().copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: font_18),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(radius_4)),
                  border: Border.all(color: AppColors.gradientColorPrimary)),
              padding: EdgeInsets.symmetric(
                  vertical: margin_4, horizontal: margin_8),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.campaignDetailsScreenRoute,
                      arguments: {argCampaignId: data?.sId});
                },
                child: TextView(
                  text: strSeeDetails,
                  textStyle: textStyleBodyMedium().copyWith(
                      color: AppColors.gradientColorPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: font_12),
                ),
              ),
            ),
          ],
        ).paddingOnly(bottom: margin_8),
        _groupListItem(strName, "${data?.campaignName}", null, null),
        _groupListItem(strEndDateAndTime, "10d : 20h : 10m: 05s", null, null),
        _groupListItem(
            strDuration,
            "${millisecondsToCustomDateFormat(data?.startDate)}\n- ${millisecondsToCustomDateFormat(data?.endDate)}",
            null,
            null),
        _groupListItem(strRemaining, "${data?.quantity}", null, null),
        _groupListItem(
            strUserJoinedCampaign, "${data?.userJoined}", null, null),
      ],
    ).paddingOnly(top: margin_8);
  }

  _publicGroupInfo() => Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(margin_16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _groupDetails(),
                  TextView(
                    text: strRequests,
                    textStyle: textStyleBodyMedium().copyWith(
                        color: AppColors.categoriesgrey,
                        fontWeight: FontWeight.w400,
                        fontSize: font_14),
                  ).paddingSymmetric(vertical: margin_8),
                  TextView(
                    text: controller.groupInfoResponseModel?.data?.request,
                    textStyle: textStyleBodyMedium().copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: font_14),
                  )
                ],
              ),
            ),
          ),
        ],
      );
}
