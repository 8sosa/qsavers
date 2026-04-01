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

import '../core/base/socket_file.dart';
import '../export.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    RepositoryBindings().dependencies();
    LocalSourceBindings().dependencies();
    SplashBinding().dependencies();
  }
}
