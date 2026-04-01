import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../export.dart';

class MultipleImagePreviewWidget extends StatefulWidget {
  const MultipleImagePreviewWidget({
    Key? key,
    required this.imageProviders,
    this.initialIndex = 0,
    this.turnValue = 4,
  }) : super(key: key);

  final List<String> imageProviders;
  final int initialIndex;
  final int turnValue;

  @override
  _MultipleImagePreviewWidgetState createState() =>
      _MultipleImagePreviewWidgetState();
}

class _MultipleImagePreviewWidgetState
    extends State<MultipleImagePreviewWidget> with SingleTickerProviderStateMixin {
  late int _turnValue;
  late int _currentIndex;
  late PageController _pageController;
  final TransformationController _transformationController = TransformationController();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  double _currentScale = 1.0;
  double _targetScale = 1.0;
  bool _isZooming = false;

  @override
  void initState() {
    super.initState();
    _turnValue = widget.turnValue;
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _handleOnImageRotate(String rotateType) {
    setState(() {
      if (rotateType == "rotate_left") {
        _turnValue -= 1;
      } else {
        _turnValue += 1;
      }
    });
  }

  void _handleZoom(String zoomType) {
    setState(() {
      double scaleFactor = (zoomType == "zoom_in") ? 1.2 : 1 / 1.2;
      _targetScale = (_currentScale * scaleFactor).clamp(1.0, 8.0);

      _scaleAnimation = Tween<double>(begin: _currentScale, end: _targetScale).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ),
      );

      _animationController.reset();
      _animationController.forward();

      _animationController.addListener(() {
        double scale = _scaleAnimation.value;
        _transformationController.value = Matrix4.identity()
          ..translate(Get.width / 2, Get.height / 2)
          ..scale(scale)
          ..translate(-Get.width / 2, -Get.height / 2);
      });

      _currentScale = _targetScale;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.imageProviders.length,
            onPageChanged: (index) {
              if (!_isZooming) {
                setState(() {
                  _currentIndex = index;
                  _currentScale = 1.0;
                  _transformationController.value = Matrix4.identity();
                });
              }
            },
            itemBuilder: (context, index) {
              return InteractiveViewer(
                transformationController: _transformationController,
                panEnabled: true,
                scaleEnabled: true,
                minScale: 1.0,
                maxScale: 8.0,
                boundaryMargin: EdgeInsets.zero,
                child: RotatedBox(
                  quarterTurns: _turnValue,
                  child: Transform.scale(
                    scale: _currentScale,
                    child: NetworkImageWidget(
                      imageUrl: widget.imageProviders[index],
                      imageHeight: height_200,
                      imageWidth: Get.width,
                      imageFitType: BoxFit.contain,
                      placeHolder: iconsProfilePlaceholderS,
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.imageProviders.length, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  width: 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: _currentIndex == index ? Colors.white : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.rotate_left, color: Colors.white),
              onPressed: () => _handleOnImageRotate("rotate_left"),
            ),
            IconButton(
              icon: const Icon(Icons.rotate_right, color: Colors.white),
              onPressed: () => _handleOnImageRotate("rotate_right"),
            ),
            IconButton(
              icon: const Icon(Icons.zoom_in, color: Colors.white, size: 32),
              onPressed: () => _handleZoom("zoom_in"),
            ),
            IconButton(
              icon: const Icon(Icons.zoom_out, color: Colors.white, size: 32),
              onPressed: () => _handleZoom("zoom_out"),
            ),
          ],
        ),
      ),
    );
  }
}
