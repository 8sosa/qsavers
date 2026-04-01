import 'dart:async';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quantity_savers/app/core/values/app_values.dart';
import 'package:video_player/video_player.dart';

void openVideoPlayer({
  required String url,
  bool isNetwork = true,
  double? height,
  double? width,
  double? paddingConatiner,
}) {
  Get.dialog(VideoPlayerWidget(
    url: url,
    isNetwork: isNetwork,
    height: height,
    width: width,
    padding: paddingConatiner,
  ));
}

class VideoPlayerWidget extends StatefulWidget {
  final String url;
  final bool isNetwork;
  final double? height;
  final double? width;
  final double? padding;

  VideoPlayerWidget({
    super.key,
    required this.url,
    this.isNetwork = true,
    this.height,
    this.padding,
    this.width,
  });

  @override
  State<VideoPlayerWidget> createState() => VideoPlayerWidgetState();
}

class VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  ChewieController? _chewieController;
  bool showButton = false;
  Timer? _timer;

  @override
  void initState() {
    _initPlayer();
    super.initState();
  }

  void _initPlayer() {
    try {
      _controller = (widget.isNetwork
          ? VideoPlayerController.networkUrl(Uri.parse(widget.url))
          : VideoPlayerController.file(File(widget.url)))
        ..initialize().then((_) {
          _initChewie();
        });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _initChewie() {
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: true,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
      ],
      deviceOrientationsOnEnterFullScreen: [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight
      ],allowPlaybackSpeedChanging: false,
      cupertinoProgressColors: ChewieProgressColors(
        backgroundColor: Colors.black,
        handleColor: Colors.white,
      ),
      materialProgressColors: ChewieProgressColors(
        backgroundColor: Colors.black,
        handleColor: Colors.white,
      ),
      showOptions: false,
      aspectRatio: _controller.value.aspectRatio,
      fullScreenByDefault: false,
      // Start in normal mode
    );
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _showButtonsTemporarily() {
    setState(() {
      showButton = true;
    });
    _timer?.cancel(); // Cancel any previous timer
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          showButton = false;
        });
      }
    });
  }

  void _skipForward() {
    final currentPosition = _controller.value.position;
    final newPosition = currentPosition + const Duration(seconds: 5);
    if (newPosition < _controller.value.duration) {
      _controller.seekTo(newPosition);
    } else {
      _controller.seekTo(_controller.value.duration);
    }
    _showButtonsTemporarily();
  }

  void _skipBackward() {
    final currentPosition = _controller.value.position;
    final newPosition = currentPosition - const Duration(seconds: 5);
    if (newPosition > Duration.zero) {
      _controller.seekTo(newPosition);
    } else {
      _controller.seekTo(Duration.zero);
    }
    _showButtonsTemporarily();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _playerWidget().paddingOnly(top: widget.padding ?? 0.0),
      ],
    );
  }

  Container _playerWidget() {
    return Container(
      height: widget.height ?? height_180,
      width: widget.width ?? Get.width,
      decoration: const BoxDecoration(color: Colors.black),
      child: Stack(
        children: [
          _controller.value.isInitialized && _chewieController != null
              ? Chewie(controller: _chewieController!)
              : const Center(child: CircularProgressIndicator()),
          Positioned(
            top: 8.0,
            right: 8.0,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 70.0,
            left: 10.0,
            child: Row(
              children: [
                GestureDetector(
                  onTap: _showButtonsTemporarily,
                  child: Container(
                    color: Colors.transparent,
                    height: 80,
                    width: 150,
                    child: showButton
                        ? Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(margin_50),
                            color: Colors.black.withOpacity(0.10)
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.replay_5, color: Colors.white),
                            onPressed: _skipBackward,
                          ).paddingOnly(left: margin_50),
                        ),
                      ],
                    )
                        : null,
                  ),
                ),
                const SizedBox(width: 80,),
                GestureDetector(
                  onTap: _showButtonsTemporarily,
                  child: Container(
                    color: Colors.transparent,
                    height: 80,
                    width: 150,
                    child: showButton
                        ? Row(
                      children: [
                        const SizedBox(width: 40,),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(margin_50),
                            color: Colors.black.withOpacity(0.10)
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.forward_5, color: Colors.white),
                            onPressed: _skipForward,
                          ),
                        ),
                      ],
                    )
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
