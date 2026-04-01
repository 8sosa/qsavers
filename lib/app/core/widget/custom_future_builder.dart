

/*
 *
 *  * @copyright : Henceforth Pvt. Ltd. <info@henceforthsolutions.com>
 *  * @author     : Gaurav Negi
 *  * All Rights Reserved.
 *  * Proprietary and confidential :  All information contained herein is, and remains
 *  * the property of Henceforth Pvt. Ltd. and its partners.
 *  * Unauthorized copying of this file, via any medium is strictly prohibited.
 *  *
 *
 */

import 'package:quantity_savers/app/export.dart';


class CustomFutureBuilder extends StatelessWidget {
  const CustomFutureBuilder(
      {Key? key,
      this.future,
      required this.ResponseModel,
      required this.widget})
      : super(key: key);
  final Future? future;
  final ResponseModel;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, result) {
        log.e(result);

        switch (result.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.active:
            return Container();
          case ConnectionState.done:
            {
              if (result.hasData) {
                return ResponseModel?.list != null &&
                        ResponseModel?.list?.length != 0
                    ? widget
                    : Center(
                        child: Container(
                        margin: const EdgeInsets.only(top: 40.0, bottom: 40.0),
                        child: Text('No Data Found'.tr),
                      ));
              } else {
                return Center(
                    child: Container(
                  margin: const EdgeInsets.only(top: 40.0, bottom: 40.0),
                  child: Text('No Data Found'.tr),
                ));
              }
            }
          case ConnectionState.none:
            return Container();
          default:
            return Container();
        }
      },
    );
  }
}
