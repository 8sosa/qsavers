import "package:loading_animation_widget/loading_animation_widget.dart";

import "../../../export.dart";

class ForumsScreen extends StatelessWidget {
  final themeController = Get.put(ThemeController());
  final controller = Get.put(ForumsController());

  ForumsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForumsController>(
        init: ForumsController(),
        builder: (controller) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: CustomAppBar(
                appBarTitleText: strForums.toUpperCase(),
                isDrawerIcon: true,
                onTap: () {
                  if (controller.loginDataModel.email != null) {
                    Get.toNamed(AppRoutes.searchOnHomeScreenRoute,
                        arguments: {argIsForForumsSearch: true});
                  }
                },
                menuIcon: iconsSearch,
                actionWidget: [
                  Row(children: [
                    IconButton(
                      onPressed: () {
                        if (controller.loginDataModel.email != null) {
                          Get.toNamed(
                            AppRoutes.createGroupRoute,
                          );
                        }
                      },
                      icon: const AssetSVGWidget(iconsAdd),
                    ),
                  ])
                ],
                isBottomWidget: true,
                bottomWidget: TabBar(
                  onTap: (index) {
                    if (controller.loginDataModel.email != null) {
                      if (index == 1) {
                        controller.hitGetForumRequestApiCall();
                      } else {
                        controller.hitGetGroupListSocket();
                      }
                    }
                  },
                  dividerColor: Colors.white,
                  indicatorColor: Colors.white,
                  tabs: [
                    TextView(
                      text: strForums.toUpperCase(),
                      textStyle: textStyleBodyMedium().copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: font_13),
                    ).paddingOnly(bottom: margin_4),
                    TextView(
                      text: strRequests.toUpperCase(),
                      textStyle: textStyleBodyMedium().copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: font_13),
                    ).paddingOnly(bottom: margin_4),
                  ],
                ),
              ),
              body: TabBarView(children: [
                _forumsList(),
                controller.loginDataModel.email != null
                    ? _requestsList()
                    : const SizedBox()
              ]),
            ),
          );
        });
  }

  _forumsList() => ListView.separated(
        shrinkWrap: true,
        itemCount: controller.groupListResponseModel.data?.length ?? 0,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
              await Get.toNamed(AppRoutes.forumsChatRoute, arguments: {
                argForumGroupType:
                    controller.groupListResponseModel.data?[index].groupType,
                argGroupId: controller.groupListResponseModel.data?[index].sId,
                argIsSearchedForum: false,
              });
              controller.groupListResponseModel.data?[index].unreadMessages =
                  null;
              controller.update();
            },
            child: _forumsListItem(index),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            color: AppColors.textfieldborder,
          ).paddingOnly(left: margin_20);
        },
      );

  _forumsListItem(int index) {
    var item = controller.groupListResponseModel.data?[index];
    int unreadMessageCount = 0;
    if (controller.groupListResponseModel.data?[index].unreadMessages != 0) {
      unreadMessageCount =
          controller.groupListResponseModel.data?[index].unreadMessages ?? 0;
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AssetSVGWidget(
          item?.groupType == strPrivate ? iconsIconsLockClose : iconsLockOpen,
          imageHeight: height_45,
        ).paddingOnly(right: margin_12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextView(
                    text: "${item?.groupName}",
                    textStyle: textStyleBodyMedium().copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: font_16),
                  ),
                  const Spacer(),
                  TextView(
                    text: item?.updatedAt != null
                        ? formatDateTime(DateTime.fromMillisecondsSinceEpoch(
                            int.parse(item?.updatedAt)))
                        : "",
                    textStyle: textStyleBodyMedium().copyWith(
                        color: AppColors.bottombarColor,
                        fontWeight: FontWeight.w500,
                        fontSize: font_12),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (controller
                          .groupListResponseModel.data?[index].lastMessage !=
                      null) ...[
                    Expanded(
                      child: TextView(
                        maxLines: 1,
                        text: controller.groupListResponseModel.data?[index]
                                .lastMessage ??
                            '',
                        textStyle: textStyleBodyMedium().copyWith(
                            color: AppColors.categoriesgrey,
                            fontWeight: FontWeight.w500,
                            fontSize: font_14),
                      ),
                    )
                  ],
                  if (unreadMessageCount > 0) ...[
                    const Spacer(),
                    Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              colors: [
                                AppColors.gradient1st,
                                AppColors.gradient2nd
                              ])),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(margin_4),
                          child: TextView(
                            text:
                                "${unreadMessageCount > 9 ? "9+" : unreadMessageCount}",
                            textStyle: textStyleBodyMedium().copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: font_12),
                          ).paddingAll(margin_4),
                        ),
                      ),
                    ),
                  ]
                ],
              )
            ],
          ),
        ),
      ],
    ).paddingSymmetric(vertical: margin_15, horizontal: margin_20);
  }

  _requestsList() => Column(children: [
        _requestNavigation(),
        if (controller.forumRequestResponseModel.data?.length == 0) ...[
          Expanded(
            child: Center(
              child: TextView(
                text: "No Request Found!",
                textStyle: textStyleBodyMedium().copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: font_16),
              ),
            ),
          )
        ] else ...[
          controller.isLoading == true
              ? Expanded(
                  child: Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                        color: AppColors.gradientColorPrimary, size: 50),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                      itemCount:
                          controller.forumRequestResponseModel.data?.length ??
                              0,
                      itemBuilder: (context, index) {
                        return _requestListItem(index);
                      }),
                )
        ],
      ]).paddingAll(margin_16);

  _requestNavigation() => Container(
        padding: EdgeInsets.all(margin_8),
        decoration: BoxDecoration(
            color: AppColors.dividerColor,
            borderRadius: BorderRadius.all(Radius.circular(radius_8))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  controller.currentPage = 0;
                  controller.update();
                  controller.hitGetForumRequestApiCall();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: margin_6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(radius_6)),
                    gradient: (controller.currentPage == 0)
                        ? const LinearGradient(
                            begin: Alignment.centerLeft,
                            colors: [
                              AppColors.gradient1st,
                              AppColors.gradient2nd
                            ],
                          )
                        : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextView(
                        textAlign: TextAlign.center,
                        text: strReceived.toUpperCase(),
                        textStyle: textStyleBodyMedium().copyWith(
                            color: (controller.currentPage == 0)
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: font_14),
                      ).paddingOnly(right: margin_4),
                      if (controller.isLoading == false &&
                          controller.currentPage == 0 &&
                          controller.forumRequestResponseModel.data?.length !=
                              0) ...[
                        TextView(
                          textAlign: TextAlign.center,
                          text:
                              "(${controller.forumRequestResponseModel.data?.length})",
                          textStyle: textStyleBodyMedium().copyWith(
                              color: (controller.currentPage == 0)
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: font_14),
                        )
                      ],
                      IconButton(
                          onPressed: () {
                            showDialog(
                              context: Get.context!,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Received request'),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  content: const Text(
                                      'This is the list of the requests which the user gets when someone wants to join our private group'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                      },
                                      child: const Text(
                                        'Close',
                                        style: TextStyle(
                                            color: AppColors.gradient2nd),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.help_outline,
                            color: (controller.currentPage == 0)
                                ? Colors.white
                                : Colors.black,
                            size: 28,
                          )),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                child: InkWell(
              onTap: () {
                controller.currentPage = 1;
                controller.update();
                controller.hitGetForumRequestApiCall();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(radius_6)),
                  gradient: (controller.currentPage == 1)
                      ? const LinearGradient(
                          begin: Alignment.centerLeft,
                          colors: [
                            AppColors.gradient1st,
                            AppColors.gradient2nd
                          ],
                        )
                      : null,
                ),
                padding: EdgeInsets.symmetric(vertical: margin_6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextView(
                      textAlign: TextAlign.center,
                      text: strSent.toUpperCase(),
                      textStyle: textStyleBodyMedium().copyWith(
                          color: (controller.currentPage == 1)
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: font_14),
                    ).paddingOnly(right: margin_4),
                    if (controller.isLoading == false &&
                        controller.currentPage == 1 &&
                        controller.forumRequestResponseModel.data?.length !=
                            0) ...[
                      TextView(
                        textAlign: TextAlign.center,
                        text:
                            "(${controller.forumRequestResponseModel.data?.length ?? 0})",
                        textStyle: textStyleBodyMedium().copyWith(
                            color: (controller.currentPage == 1)
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: font_12),
                      )
                    ],
                    IconButton(
                        onPressed: () {
                          showDialog(
                            context: Get.context!,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Sent request'),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                content: const Text(
                                    'This is the list of the requests when user wants to join any of the private group.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                    child: const Text(
                                      'Close',
                                      style: TextStyle(
                                          color: AppColors.gradient2nd),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(
                          Icons.help_outline,
                          color: (controller.currentPage == 1)
                              ? Colors.white
                              : Colors.black,
                          size: 28,
                        )),
                  ],
                ),
              ),
            ))
          ],
        ),
      );

  _requestListItem(int index) => controller.currentPage == 0
      ? Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor),
              borderRadius: BorderRadius.all(Radius.circular(margin_8))),
          padding: EdgeInsets.all(margin_16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                text: strGroupNameWithoutColon.toUpperCase(),
                textStyle: textStyleBodyMedium().copyWith(
                    color: AppColors.DustyGray,
                    fontWeight: FontWeight.w500,
                    fontSize: font_12),
              ),
              Row(
                children: [
                  const AssetSVGWidget(iconsIconsLockClose)
                      .paddingOnly(right: margin_6),
                  TextView(
                    text:
                        "${controller.forumRequestResponseModel.data?[index].groupName}",
                    textStyle: textStyleBodyMedium().copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: font_14),
                  )
                ],
              ).paddingOnly(top: margin_4, bottom: margin_12),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView(
                        text: (controller.forumRequestResponseModel.data?[index]
                                        .groupMembersCount !=
                                    null &&
                                controller.forumRequestResponseModel
                                        .data![index].groupMembersCount! <=
                                    1)
                            ? 'MEMBER'
                            : 'MEMBERS',
                        textStyle: textStyleBodyMedium().copyWith(
                            color: AppColors.DustyGray,
                            fontWeight: FontWeight.w500,
                            fontSize: font_12),
                      ),
                      TextView(
                        text:
                            "${controller.forumRequestResponseModel.data?[index].groupMembersCount}",
                        textStyle: textStyleBodyMedium().copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: font_14),
                      )
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextView(
                        text: (controller.forumRequestResponseModel.data?[index]
                                        .groupReqCount !=
                                    null &&
                                controller.forumRequestResponseModel
                                        .data![index].groupReqCount! <=
                                    1)
                            ? 'REQUEST'
                            : 'REQUESTS',
                        textStyle: textStyleBodyMedium().copyWith(
                            color: AppColors.DustyGray,
                            fontWeight: FontWeight.w500,
                            fontSize: font_12),
                      ),
                      TextView(
                        text:
                            "${controller.forumRequestResponseModel.data?[index].groupReqCount}",
                        textStyle: textStyleBodyMedium().copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: font_14),
                      )
                    ],
                  )
                ],
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.viewRequestsRoute, arguments: {
                    argIsRequestTypeSent: false,
                    argIsSearchedForum: true,
                    argGroupName: controller
                        .forumRequestResponseModel.data?[index].groupName,
                    argGroupId:
                        controller.forumRequestResponseModel.data?[index].sId
                  });
                },
                child: _requestButton(),
              )
            ],
          ),
        ).paddingSymmetric(vertical: margin_12)
      : Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor),
              borderRadius: BorderRadius.all(Radius.circular(margin_8))),
          padding: EdgeInsets.all(margin_16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                text: strGroupNameWithoutColon.toUpperCase(),
                textStyle: textStyleBodyMedium().copyWith(
                    color: AppColors.DustyGray,
                    fontWeight: FontWeight.w500,
                    fontSize: font_12),
              ),
              Row(
                children: [
                  const AssetSVGWidget(iconsIconsLockClose)
                      .paddingOnly(right: margin_6),
                  TextView(
                    text:
                        "${controller.forumRequestResponseModel.data?[index].groupId?.groupName}",
                    textStyle: textStyleBodyMedium().copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: font_14),
                  )
                ],
              ).paddingOnly(top: margin_4, bottom: margin_12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: strMessage.toUpperCase(),
                    textStyle: textStyleBodyMedium().copyWith(
                        color: AppColors.DustyGray,
                        fontWeight: FontWeight.w500,
                        fontSize: font_12),
                  ),
                  TextView(
                    text:
                        "${controller.forumRequestResponseModel.data?[index].message}",
                    textStyle: textStyleBodyMedium().copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: font_14),
                  )
                ],
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.forumsChatRoute, arguments: {
                    argIsRouteFromRequest: true,
                    argIsRequestTypeSent: true,
                    argGroupName: controller.forumRequestResponseModel
                        .data?[index].groupId?.groupName,
                    argGroupRequestId:
                        controller.forumRequestResponseModel.data?[index].sId,
                    argGroupId: controller
                        .forumRequestResponseModel.data?[index].groupId?.sId
                  });
                },
                child: _requestButton(),
              )
            ],
          ),
        ).paddingSymmetric(vertical: margin_12);

  _requestButton() => Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: margin_8),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.gradientColorPrimary),
            borderRadius: BorderRadius.all(Radius.circular(radius_4))),
        child: TextView(
          textAlign: TextAlign.center,
          text: strViewRequests.toUpperCase(),
          textStyle: textStyleBodyMedium().copyWith(
              color: AppColors.gradient2nd,
              fontWeight: FontWeight.w700,
              fontSize: font_12),
        ),
      ).paddingOnly(top: margin_12);

  String formatDateTime(DateTime dateTime) {
    final DateFormat dateFormat = DateFormat('hh:mm a');
    return dateFormat.format(dateTime);
  }

  Widget _buildRowWithBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Icon(Icons.circle, size: 12),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              text,
            ),
          ),
        ],
      ),
    );
  }
}
