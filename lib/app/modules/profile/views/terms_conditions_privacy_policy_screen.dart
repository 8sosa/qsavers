import 'package:html/dom.dart';
import 'package:quantity_savers/app/export.dart';

import '../controllers/terms_conditions_privacy_policy_controller.dart';
import 'package:flutter_html/flutter_html.dart';

class TermsCondAndPvtPolicy extends StatelessWidget {
  final controller = Get.put(TermsCondAndPvtPolicyController());

  TermsCondAndPvtPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (context) {
          return Scaffold(
            appBar: CustomAppBar(
              appBarTitleText: controller.title,
            ),
            body: Shimmer(
                child: ShimmerLoading(
                    isLoading: controller.isLoading,
                    isImage: true,
                    child: bodyWidget())),
          );
        });
  }

  Widget bodyWidget() => SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
            child: Html(
              data: controller.listContentDataModel?.description ?? '',
            )),
      );
}
