/*
import 'package:flutter/material.dart';
import 'package:quantity_savers/app/core/values/app_colors.dart';

class ProgressDialog extends StatelessWidget {
  final ValueNotifier<double> progressNotifier;

  const ProgressDialog({Key? key, required this.progressNotifier}) : super(key: key);

  static void show(BuildContext context, ValueNotifier<double> progressNotifier) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ProgressDialog(progressNotifier: progressNotifier);
      },
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ValueListenableBuilder<double>(
          valueListenable: progressNotifier,
          builder: (context, progress, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 70,
                      height: 70,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 6.0,
                        color:AppColors.gradient2nd,
                      ),
                    ),
                    Text("${(progress * 100).toInt()}%"),
                  ],
                ),
                SizedBox(height: 16),
              ],
            );
          },
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../values/app_colors.dart';

class ProgressDialog extends StatelessWidget {
  final double progress;

  ProgressDialog({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),),

      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 6.0,
                  color:AppColors.gradient2nd,
                ),
                Text("${(progress * 100).toInt()}%",style: const TextStyle(color: Colors.white),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

