import "package:quantity_savers/app/modules/profile/controllers/earnings_controller.dart";

import "../../../export.dart";

class EarningsScreen extends StatelessWidget {
  final themeController = Get.put(ThemeController());
  final controller = Get.put(EarningsController());
  EarningsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EarningsController>(
        init: EarningsController(),
        builder: (context) {
          return Scaffold(
            appBar: CustomAppBar(
              appBarTitleText: strEarnings,
            ),
            body: _bodyWidget(),
          );
        });
  }

  _bodyWidget() => controller.isLoading == true
      ? const Center(
          child: CircularProgressIndicator(
          color: AppColors.gradient2nd,
        ))
      : controller.campaignEarningResponseModel.data?.count != 0
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: margin_20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _totalEarnings(
                        '${(controller.campaignEarningResponseModel.data?.totalEarning ?? 0).toStringAsFixed(2)}'),
                    _amountAvailable(
                        '${(controller.campaignEarningResponseModel.data?.moneyAvilable ?? 0).toStringAsFixed(2)}'),
                    _tranactions(controller),
                  ],
                ),
              ),
            )
          : _noCouponScreen();

  _noCouponScreen() => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AssetSVGWidget(iconsNotPurchased)
                .paddingOnly(bottom: margin_20),
            TextView(
              text: "No Earnings",
              textStyle: textStyleBodyMedium().copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: font_16),
            ).paddingOnly(bottom: margin_16),
          ],
        ),
      );

  _totalEarnings(var totalEarn) => Container(
        width: Get.width,
        margin: EdgeInsets.only(top: margin_25),
        padding:
            EdgeInsets.symmetric(horizontal: margin_25, vertical: margin_25),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
                colors: [AppColors.gradient1st, AppColors.gradient2nd])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              text: strTotalEarnings,
              textStyle: textStyleBodyLarge().copyWith(color: Colors.white),
            ),
            SizedBox(
              height: height_18,
            ),
            TextView(
              text: '\$$totalEarn',
              textStyle: textStyleDisplayLarge().copyWith(
                color: Colors.white,
              ),
            )
          ],
        ),
      );

  _amountAvailable(var amtAvail) {
    return Container(
      width: Get.width,
      margin: EdgeInsets.only(top: margin_20),
      padding: EdgeInsets.symmetric(horizontal: margin_25, vertical: margin_25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 0.5,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            text: strAmtAvailToWdrw,
            textStyle: textStyleBodyLarge(),
          ),
          SizedBox(
            height: height_18,
          ),
          TextView(
            text: '\$$amtAvail',
            textStyle: textStyleDisplayLarge(),
          ),
          SizedBox(
            height: height_18,
          ),
          MaterialButton(
              minWidth: Get.width,
              color: AppColors.gradient2nd,
              padding: EdgeInsets.zero,
              onPressed: () {
                var price =
                    controller.campaignEarningResponseModel.data?.moneyAvilable;
                if (price == 0) {
                  showToast(message: "No Amount to withdraw");
                } else {
                  controller.hitPayOutApi();
                }
              },
              child: TextView(
                text: strWdrwReq,
                textStyle: textStyleBodyMedium().copyWith(color: Colors.white),
              ))
        ],
      ),
    );
  }

  _tranactions(EarningsController controller) => Container(
        margin: EdgeInsets.only(top: height_20),
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              text: strTransactions,
              textStyle: textStyleDisplaySmall().copyWith(fontSize: font_16),
            ),
            SizedBox(
              height: height_20,
            ),
            _transactionsList(controller)
          ],
        ),
      );

  _transactionsList(EarningsController controller) => ListView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.campaignEarningResponseModel.data?.count ?? 0,
      itemBuilder: (context, index) {
        var element =
            controller.campaignEarningResponseModel.data?.data?[index];
        var profit = element?.isMoneyTransfer == false ? true : false;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AssetSVGWidget((profit) ? iconsErning : iconsLosss),
                SizedBox(width: width_5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: element?.campaignName ?? "",
                      textStyle: textStyleBodyMedium()
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextView(
                      text: DateFormat('dd/MM/yyyy').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              int.tryParse(element?.updatedAt ?? "") ?? 8)),
                      textStyle:
                          textStyleBodyMedium().copyWith(color: Colors.grey),
                    )
                  ],
                ),
                Spacer(),
                TextView(
                  text:
                      '${(profit) ? '+' : '-'}\$${element?.priceMoneyAmount ?? ""}',
                  textStyle: textStyleBodyMedium().copyWith(
                      fontWeight: FontWeight.bold,
                      color: (profit) ? Colors.green : Colors.red),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: margin_10),
              child: Divider(
                color: Colors.black.withOpacity(0.1),
              ),
            )
          ],
        );
      });
}
