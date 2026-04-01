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


import 'package:quantity_savers/app/modules/Details/controllers/all_faqs_controller.dart';

import '../../../export.dart';
import '../controllers/all_product_faq_controller.dart';

class AllProductFAQsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AllProductFAQsController>(
          () => AllProductFAQsController(),
    );
  }
}
