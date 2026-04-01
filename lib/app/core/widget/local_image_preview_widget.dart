import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import 'dart:io';

import "../../export.dart";

class LocalImagePreviewWidget extends StatefulWidget {
  const LocalImagePreviewWidget(
      {Key? key, required this.imageProvider, this.isNetworkImage = true, this.turnValue = 4});

  final int turnValue;
  final String imageProvider;
  final bool isNetworkImage;

  @override
  _LocalImagePreviewWidgetState createState() => _LocalImagePreviewWidgetState();
}

class _LocalImagePreviewWidgetState extends State<LocalImagePreviewWidget> {
  late int _turnValue;

  @override
  void initState() {
    super.initState();
    _turnValue = widget.turnValue;
  }

  void _handleOnImageRotate(String rotateType) {
    setState(() {
      if (rotateType == "rotate_left") {
        _turnValue = _turnValue - 1;
      } else {
        _turnValue = _turnValue + 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
      child: Padding(
        padding: EdgeInsets.all(margin_16),
        child: Center(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: InteractiveViewer(
                  panEnabled: false,
                  boundaryMargin: const EdgeInsets.all(double.infinity),
                  minScale: 1.08,
                  maxScale: 8,
                  scaleEnabled: true,
                  child: RotatedBox(
                    quarterTurns: _turnValue,
                    child: widget.isNetworkImage
                        ? NetworkImageWidget(
                      imageUrl: widget.imageProvider,
                      imageHeight: height_200,
                      imageWidth: Get.width,
                      imageFitType: BoxFit.contain,
                      placeHolder: iconsProfilePlaceholderS,
                    )
                        : Image.file(
                      File(widget.imageProvider),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      _handleOnImageRotate("rotate_left");
                    },
                    child: const Icon(
                      Icons.rotate_left,
                      color: Colors.white,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _handleOnImageRotate("rotate_right");
                    },
                    child: const Icon(
                      Icons.rotate_right,
                      color: Colors.white,
                    ),
                  ),
                ],
              ).paddingOnly(top: margin_4),
            ],
          ),
        ),
      ),
    );
  }
}
