import 'package:get/get.dart';

class ProgressController extends GetxController {
  var isVisible = false.obs;
  var progress = 0.0.obs;

  void show() {
    isVisible.value = true;
  }

  void hide() {
    isVisible.value = false;
  }

  void updateProgress(double value) {
    progress.value = value;
  }
}
