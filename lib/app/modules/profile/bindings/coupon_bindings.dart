import 'package:quantity_savers/app/modules/profile/controllers/coupon_controller.dart';

import '../../../export.dart';

class CouponBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CouponController>(
          () => CouponController(),
    );
  }
}