import "../../../export.dart";

class ScheduledLiveBroadcastScreen extends StatelessWidget {
  final themeController = Get.put(ThemeController());
  final controller = Get.put(ScheduledLiveBroadcastController());

  ScheduledLiveBroadcastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScheduledLiveBroadcastController>(
      init: ScheduledLiveBroadcastController(),
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        colors: [
                      AppColors.gradient1st,
                      AppColors.gradient2nd
                    ])),
              ),
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const AssetSVGWidget(iconsAppBarback),
              ),
              centerTitle: true,
              title: Text(
                strScheduledLiveBroadcast.toUpperCase(),
                style:
                    TextStyle(fontSize: font_16, fontWeight: FontWeight.w600),
              ),
            ),
            // body: _broadcastListItem(),
            body:
                controller.getScheduleLiveBroadCastResponseModel.data?.count ==
                        0
                    ? _noCouponScreen()
                    : Container(
                        padding: EdgeInsets.all(margin_16),
                        child: ListView.builder(
                          itemCount: controller
                                  .getScheduleLiveBroadCastResponseModel
                                  .data
                                  ?.count ??
                              0,
                          itemBuilder: (context, index) {
                            return _broadcastListItem(index);
                          },
                        ),
                      ));
      },
    );
  }

  _noCouponScreen() => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AssetSVGWidget(iconsNotPurchased)
                .paddingOnly(bottom: margin_20),
            TextView(
              text: "No Data Found",
              textStyle: textStyleBodyMedium().copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: font_16),
            ).paddingOnly(bottom: margin_16),
          ],
        ),
      );

  Widget _broadcastListItem(int index) {
    String dateTimeString = controller.getScheduleLiveBroadCastResponseModel
            .data?.data?[index].liveStartDate ??
        '';
    String formattedDate = dateTimeString.substring(0, 10);

    var endDuration = controller
            .getScheduleLiveBroadCastResponseModel.data?.data?[index].endDate ??
        0;
    DateTime endDate = DateTime.fromMillisecondsSinceEpoch(endDuration!);
    return Container(
      padding: EdgeInsets.all(margin_16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius_12)),
          border: Border.all(color: AppColors.borderColor)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              NetworkImageWidget(
                imageUrl: controller.getScheduleLiveBroadCastResponseModel.data
                        ?.data?[index].image ??
                    "",
                imageHeight: height_45,
                imageWidth: width_50,
                imageFitType: BoxFit.fitWidth,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text:
                        "${controller.getScheduleLiveBroadCastResponseModel.data?.data?[index].campaignName}",
                    textStyle: textStyleBodyMedium().copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: font_16),
                  ).paddingOnly(bottom: margin_6),
                  TextView(
                    text:
                        "$formattedDate at ${controller.getScheduleLiveBroadCastResponseModel.data?.data?[index].liveStartTime}",
                    textStyle: textStyleBodyMedium().copyWith(
                        color: AppColors.categoriesgrey,
                        fontWeight: FontWeight.w500,
                        fontSize: font_12),
                  ),
                ],
              ).paddingOnly(left: margin_8),
            ],
          ).paddingOnly(bottom: margin_8),
          Row(
            children: [
              Expanded(
                child: _broadcastManageBtn(
                    iconsPencil, strEdits, index, endDate, formattedDate),
              ),
              SizedBox(
                width: width_12,
              ),
              Expanded(
                  child: _broadcastManageBtn(
                      iconsDelete, strDelete, index, endDate, formattedDate))
            ],
          ),
        ],
      ),
    ).paddingOnly(bottom: margin_16);
  }

  _broadcastManageBtn(
          iconPrefix, btnName, int index, DateTime providedDate, String date) =>
      GestureDetector(
        onTap: () {
          if (btnName == strEdit) {
            showScheduleLiveBroadcastDialog(
                Get.context!, index, providedDate, date);
          } else if (btnName == strDelete) {
            Get.dialog(CustomDialogWidget(
              title: strEndLiveStreamSchedule,
              confirmTitle: strYes,
              cancelTitle: strNo,
              confirmBtnBgColor: Colors.red,
              cancelTitleColor: AppColors.gradientColorSecondary,
              cancelBtnBorder:
                  Border.all(color: AppColors.borderColor, width: 1),
              cancelBtnBgColor: Colors.transparent,
              onTapConfirm: () {
                controller.hitDeleteSocket(controller
                    .getScheduleLiveBroadCastResponseModel
                    .data
                    ?.data?[index]
                    .sId);
                Get.back();
              },
              isImage: false,
              isCloseBtn: true,
            ));
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: margin_8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius_4),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: btnName == strDelete
                      ? [Colors.red, Colors.red]
                      : [AppColors.gradient1st, AppColors.gradient2nd])),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AssetSVGWidget(iconPrefix).paddingOnly(right: margin_2),
                Text(btnName,
                    style: TextStyle(
                      fontSize: font_12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ))
              ],
            ),
          ),
        ).paddingOnly(top: margin_8),
      );
  void showScheduleLiveBroadcastDialog(
      BuildContext context, int index, DateTime providedDate, String date) {
    DateTime? selectedDate;
    TimeOfDay? selectedTime;
    DateTime? initialDate;

    if (date != null && date.isNotEmpty) {
      initialDate = DateFormat('yyyy-MM-dd').parse(date);
      selectedDate = initialDate;
    }

    Get.dialog(
      StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Schedule Live Broadcast'),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(Icons.close),
                ),
              ],
            ),
            contentPadding: const EdgeInsets.only(
                left: 16.0, right: 10.0, top: 10.0, bottom: 0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  color: Colors.grey,
                ),
                const Text('Select Date').paddingOnly(top: 10),
                GestureDetector(
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData(
                            colorScheme: ColorScheme.light(
                              primary: AppColors.gradient2nd, // header background color
                              onPrimary: Colors.white, // header text color
                              onSurface: AppColors.gradient2nd, // body text color
                            ),
                            dialogBackgroundColor: Colors.white, // background color
                          ),
                          child: child!,
                        );
                      },
                      initialDate: initialDate ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: providedDate.subtract(const Duration(days: 0)),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(selectedDate != null
                            ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                            : initialDate != null
                                ? DateFormat('yyyy-MM-dd').format(initialDate!)
                                : 'yyyy-mm-dd'),
                        const Icon(Icons.calendar_today,
                            color: AppColors.gradient2nd),
                      ],
                    ),
                  ),
                ).paddingOnly(top: 10),
                const SizedBox(height: 10.0),
                const Text('Select Time'),
                GestureDetector(
                  onTap: () async {
                    final currentTime = TimeOfDay.now();
                    final pickedTime = await showTimePicker(
                      context: context,
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData(
                            colorScheme: ColorScheme.light(
                              primary: AppColors.gradient2nd, // header background color
                              onPrimary: Colors.white, // header text color
                              onSurface: AppColors.gradient2nd, // body text color
                            ),
                            dialogBackgroundColor: Colors.white, // background color
                          ),
                          child: child!,
                        );
                      },
                      initialTime: TimeOfDay.now(),
                    );

                    if (pickedTime != null) {
                      if (selectedDate != null &&
                          selectedDate!.isAtSameMomentAs(DateTime.now())) {
                        if (pickedTime.hour < currentTime.hour ||
                            (pickedTime.hour == currentTime.hour &&
                                pickedTime.minute < currentTime.minute)) {
                          showToast(
                              message: "Please select a time in the future");
                        } else {
                          setState(() {
                            selectedTime = pickedTime;
                          });
                        }
                      } else {
                        setState(() {
                          selectedTime = pickedTime;
                        });
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(selectedTime != null
                            ? selectedTime!.format(context)
                            : '--:--'),
                        const Icon(Icons.access_time,
                            color: AppColors.gradient2nd),
                      ],
                    ),
                  ),
                ).paddingOnly(top: 10),
              ],
            ),
            actions: [
              MaterialButtonWidget(
                onPressed: () {
                  if (selectedDate != null && selectedTime != null) {
                    controller.hitEditScheduleLiveBroadCast(
                        controller.getScheduleLiveBroadCastResponseModel.data
                            ?.data?[index].sId,
                        selectedDate.toString(),
                        selectedTime!.format(context).toString());
                    Get.back();
                  } else {
                    if (selectedTime == null && selectedDate == null) {
                      showToast(message: "Please Select Date and Time");
                    } else if (selectedDate == null) {
                      showToast(message: "Please Select Date");
                    } else if (selectedTime == null) {
                      showToast(message: "Please Select Time");
                    }
                  }
                },
                buttonText: "SCHEDULE LIVE BROADCAST ",
                buttonBgColor: AppColors.gradient2nd,
                minHeight: height_40,
                textColor: Colors.white,
                buttonTextStyle: const TextStyle(fontSize: 10),
              ).paddingOnly(top: 16)
            ],
          );
        },
      ),
    );
  }
}
