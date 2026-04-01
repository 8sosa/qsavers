import 'package:quantity_savers/app/modules/home/controllers/sub_categor_controller.dart';

import '../../../export.dart';

class SubCategoryBindings extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<SubCategoryController>(
          () => SubCategoryController(),
    );
  }

}