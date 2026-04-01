import 'package:quantity_savers/app/core/widget/video_player_widget/get_video_thumbnail.dart';
import 'package:quantity_savers/app/core/widget/video_player_widget/media_file.dart';
import 'package:quantity_savers/app/core/widget/video_player_widget/video_player_widget.dart';

import '../../../export.dart';
import '../videoPlayerWidget.dart';

class VideoPreviewWidget extends StatefulWidget {
  final MediaFile? mediaFile;
  final double? height;
  final double? width;
  final double? radius;
  final bool autoplay;
  final String? userName;
  final String? time;
  final bool loader;
  final Function()? onTap;
  final double? playerHeight;
  final double? playerWidth;
  final double? padding;
  final bool videoType;

  const VideoPreviewWidget({
    Key? key,
    this.mediaFile,
    this.width,
    this.onTap,
    this.height,
    this.radius,
    this.playerHeight,
    this.playerWidth,
    this.autoplay = true,
    this.userName,
    this.time,
    this.loader = false,
    this.videoType = false,
    this.padding = 0.0,
  }) : super(key: key);

  @override
  State<VideoPreviewWidget> createState() => _VideoPreviewWidgetState();
}

class _VideoPreviewWidgetState extends State<VideoPreviewWidget> {
  File? thumbnail;

  Future<File?>? future;

  @override
  void initState() {
    debugPrint("mediaurl local${widget.mediaFile?.localPath}");
    debugPrint("mediaurl nentwork  ${widget.mediaFile?.networkPath}");
    future = getThumbnail(file: widget.mediaFile);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: widget.height ?? height_100,
          width: widget.width ?? Get.width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.radius ?? radius_10),
            child: FutureBuilder<File?>(
              future: future,
              builder: (context, state) {
                if (state.connectionState == ConnectionState.waiting) {
                  if (widget.loader == false) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    );
                  }
                }
                if (state.hasError) {
                  return AssetImageWidget(
                    iconsAdd,
                    imageFitType: BoxFit.cover,
                    radiusAll: radius_12,
                    imageHeight: widget.height,
                    imageWidth: widget.width,
                  );
                }
                thumbnail = state.data;
                return GestureDetector(
                  onTap: widget.onTap ??
                      () {
                        if (widget.autoplay) {
                          if (widget.videoType == false) {
                            openVideoPlayer(
                                url: widget.mediaFile?.localPath != null
                                    ? (widget.mediaFile?.localPath ?? '')
                                    : '$videoBaseUrl${(widget.mediaFile?.networkPath ?? '')}',
                                isNetwork:
                                    (widget.mediaFile?.localPath == null),
                                height: widget.playerHeight,
                                width: widget.playerWidth,
                                paddingConatiner: widget.padding);
                          } else {
                            debugPrint(
                                'Local Path Video is On Video ${widget.mediaFile?.localPath}');
                            Get.to(CustomVideoPlayerWidget(
                              videoUrl: widget.mediaFile?.localPath != null
                                  ? (widget.mediaFile?.localPath ?? '')
                                  : '$videoBaseUrl${widget.mediaFile?.networkPath}',
                              name: widget.userName,
                              time: widget.time,
                              isNetwork: (widget.mediaFile?.localPath == null),
                            ));
                          }
                        }
                      },
                  child: _thumbnailPreview(state.data),
                );
              },
            ),
          ),
        ),
        if (widget.autoplay) // Only show the play icon if autoplay is true
          GestureDetector(
            onTap: () {
              if (widget.videoType == false) {
                openVideoPlayer(
                    url: widget.mediaFile?.localPath != null
                        ? (widget.mediaFile?.localPath ?? '')
                        : '$videoBaseUrl${(widget.mediaFile?.networkPath ?? '')}',
                    isNetwork: (widget.mediaFile?.localPath == null),
                    height: widget.playerHeight,
                    width: widget.playerWidth,
                    paddingConatiner: widget.padding);
              } else {
                debugPrint(
                    'Local Path Video is On Video ${widget.mediaFile?.localPath}');
                Get.to(CustomVideoPlayerWidget(
                    videoUrl: widget.mediaFile?.localPath != null
                        ? (widget.mediaFile?.localPath ?? '')
                        : '$videoBaseUrl${widget.mediaFile?.networkPath}',
                    name: widget.userName,
                    time: widget.time,isNetwork: (widget.mediaFile?.localPath == null),));
              }
            },
            child: AssetSVGWidget(
              iconsViddeo,
              imageHeight: height_30,
              imageWidth: height_30,
            ),
          ),
      ],
    );
  }

  Container _thumbnailPreview(File? file) {
    return Container(
      height: widget.height ?? height_100,
      width: widget.width ?? Get.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FileImage(file ?? File('')),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
