import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../export.dart";

class ImagePreviewWidget extends StatefulWidget {
  const ImagePreviewWidget({Key? key, required this.imageProvider, this.turnValue = 4});

  final int turnValue;
  final String imageProvider;

  @override
  _ImagePreviewWidgetState createState() => _ImagePreviewWidgetState();
}

class _ImagePreviewWidgetState extends State<ImagePreviewWidget> {
  late int _turnValue;
  double _currentScale = 1.0;
  double _previousScale = 1.0;

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

  void _handleZoom(String zoomType) {
    setState(() {
      if (zoomType == "zoom_in") {
        _currentScale = (_currentScale * 1.2).clamp(1.0, 8.0);
      } else {
        _currentScale = (_currentScale / 1.2).clamp(1.0, 8.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black),
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
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onScaleStart: (details) {
                    _previousScale = _currentScale;
                  },
                  onScaleUpdate: (details) {
                    setState(() {
                      _currentScale = (_previousScale * details.scale).clamp(1.0, 8.0);
                    });
                  },
                  child: InteractiveViewer(
                    panEnabled: true,
                    boundaryMargin: const EdgeInsets.all(double.infinity),
                    minScale: 1.08,
                    maxScale: 8,
                    scaleEnabled: true,
                    child: RotatedBox(
                      quarterTurns: _turnValue,
                      child: Transform.scale(
                        scale: _currentScale,
                        child: NetworkImageWidget(
                          imageUrl: widget.imageProvider ?? "",
                          imageHeight: height_200,
                          imageWidth: Get.width,
                          imageFitType: BoxFit.contain,
                          placeHolder: iconsProfilePlaceholderS,
                        ),
                      ),
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
                  SizedBox(width: margin_8),
                  InkWell(
                    onTap: () {
                      _handleOnImageRotate("rotate_right");
                    },
                    child: const Icon(
                      Icons.rotate_right,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: margin_8),
                  InkWell(
                    onTap: () {
                      _handleZoom("zoom_in");
                    },
                    child: const Icon(
                      Icons.zoom_in,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  SizedBox(width: margin_8),
                  InkWell(
                    onTap: () {
                      _handleZoom("zoom_out");
                    },
                    child: const Icon(
                      Icons.zoom_out,
                      color: Colors.white,
                      size: 32,
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
