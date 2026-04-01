import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/progress_controller.dart';

class ProgressDialog extends StatelessWidget {
  final ProgressController controller = Get.put(ProgressController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProgressController>(
      builder: (_) => Visibility(
        visible: controller.isVisible.value,
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    value: controller.progress.value / 100,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "${controller.progress.value.toInt()}%",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
