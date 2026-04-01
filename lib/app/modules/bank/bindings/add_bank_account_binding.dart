import "package:quantity_savers/app/modules/bank/controllers/add_bank_account_controller.dart";

import "../../../export.dart";

class AddBankAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddBankAccountController>(() => AddBankAccountController());
  }
}
