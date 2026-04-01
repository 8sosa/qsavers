import 'dart:async';
import 'dart:io';
import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

import '../../export.dart';
import '../values/app_values.dart';
import '../values/text_styles.dart';

class CustomVideoPlayerWidget extends StatefulWidget {
  final String? videoUrl;
  final String? name;
  final String? time;
  final String? tag;
  final bool isNetwork;  // Add this field to distinguish between network and local video

  CustomVideoPlayerWidget({
    required this.videoUrl,
    this.tag,
    this.name,
    this.time,
    this.isNetwork = true,  // Default to true for network video
  });

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<CustomVideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _showControls = false;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
    timer = Timer.periodic(
      const Duration(seconds: 5),
          (timer) {
        if (_showControls) {
          if (mounted) {
            setState(() {
              _showControls = false;
            });
          }
        }
      },
    );
  }

  void _initializeVideoPlayer() {
    _videoPlayerController = widget.isNetwork
        ? VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl!))
        : VideoPlayerController.file(File(widget.videoUrl!));

    _videoPlayerController.initialize().then((_) {
      setState(() {});
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: _videoPlayerController.value.aspectRatio,
        autoPlay: true,
        looping: true,
        showControls: false,
      );
    });
  }

  @override
  void dispose() {
    if (_chewieController != null && _chewieController!.isPlaying) {
      _chewieController?.dispose();
    }
    _videoPlayerController.dispose();
    timer.cancel();
    super.dispose();
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  void _skipForward() {
    final currentPosition = _videoPlayerController.value.position;
    final newPosition = currentPosition + const Duration(seconds: 5);
    if (newPosition < _videoPlayerController.value.duration) {
      _videoPlayerController.seekTo(newPosition);
    } else {
      _videoPlayerController.seekTo(_videoPlayerController.value.duration);
    }
  }

  void _skipBackward() {
    final currentPosition = _videoPlayerController.value.position;
    final newPosition = currentPosition - const Duration(seconds: 5);
    if (newPosition > Duration.zero) {
      _videoPlayerController.seekTo(newPosition);
    } else {
      _videoPlayerController.seekTo(Duration.zero);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: _chewieController != null &&
              _chewieController!.videoPlayerController.value.isInitialized
              ? Stack(
            children: [
              GestureDetector(
                onTap: _toggleControls,
                child: Chewie(
                  controller: _chewieController!,
                ),
              ),
              if (_showControls)
                AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  bottom: _showControls ? 50 : -50.0,
                  left: 10,
                  right: 10,
                  child: CustomVideoProgressIndicator(
                    controller: _videoPlayerController,
                  ),
                ),
              if (_showControls)
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(margin_50),
                          color: Colors.black.withOpacity(0.10),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.replay_5, color: Colors.white),
                          onPressed: _skipBackward,
                        ),
                      ).paddingOnly(right: margin_40),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(margin_50),
                          color: Colors.black.withOpacity(0.10),
                        ),
                        child: IconButton(
                          icon: Icon(
                            _videoPlayerController.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                            size: 50.0,
                          ),
                          onPressed: () {
                            setState(() {
                              _videoPlayerController.value.isPlaying
                                  ? _videoPlayerController.pause()
                                  : _videoPlayerController.play();
                            });
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(margin_50),
                          color: Colors.black.withOpacity(0.10),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.forward_5, color: Colors.white),
                          onPressed: _skipForward,
                        ),
                      ).paddingOnly(left: margin_40),
                    ],
                  ),
                ),
              if (_showControls)
                Align(
                  alignment: Alignment.topCenter,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.1), BlendMode.darken),
                    child: Container(
                      height: height_50,
                      color: Colors.black.withOpacity(0.1),
                      width: Get.width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.white),
                            onPressed: () {
                              timer.cancel();
                              _videoPlayerController.pause();
                              _videoPlayerController.dispose();
                              _chewieController?.dispose();
                              Get.back();
                            },
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (widget.name != null) ...[
                                  Text(
                                    "${widget.name}",
                                    style: textStyleDisplayLarge()
                                        .copyWith(
                                        color: Colors.white,
                                        fontSize: font_16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                                if (widget.time != null) ...[
                                  Text(
                                    "${widget.time}",
                                    style: textStyleDisplayLarge()
                                        .copyWith(
                                        color: Colors.white,
                                        fontSize: font_12,
                                        fontWeight: FontWeight.w400),
                                  ).marginOnly(top: margin_2),
                                ]
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          )
              : const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class CustomVideoProgressIndicator extends StatelessWidget {
  final VideoPlayerController controller;

  CustomVideoProgressIndicator({required this.controller});

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return [
      if (hours > 0) twoDigits(hours),
      twoDigits(minutes),
      twoDigits(seconds),
    ].join(':');
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, VideoPlayerValue value, child) {
        final position = value.position;
        final duration = value.duration;
        final remaining = duration - position;

        return Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _formatDuration(position),
                    style: TextStyle(color: Colors.white),
                  ).marginOnly(right: margin_10, top: margin_3),
                  Expanded(
                    child: VideoProgressIndicator(
                      controller,
                      allowScrubbing: true,
                      colors: VideoProgressColors(
                        playedColor: AppColors.gradient2nd,
                        bufferedColor: Colors.white,
                        backgroundColor: Colors.grey,
                      ),
                    ),
                  ),
                  Text(
                    '${_formatDuration(remaining)}',
                    style: TextStyle(color: Colors.white),
                  ).marginOnly(left: margin_10, top: margin_3),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
