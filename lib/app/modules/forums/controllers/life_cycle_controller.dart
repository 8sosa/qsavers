import 'package:get/get.dart';
import 'package:flutter/widgets.dart';

class LifecycleController extends GetxController with WidgetsBindingObserver {
  var isAppInBackground = false.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    isAppInBackground.value = state == AppLifecycleState.paused;
  }
}
