import "package:quantity_savers/app/modules/bank/controllers/bank_account_controller.dart";

import "../../../export.dart";

class BankAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BankAccountController>(() => BankAccountController());
  }
}
