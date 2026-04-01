import 'package:path_provider/path_provider.dart';
import 'package:quantity_savers/app/core/widget/video_player_widget/media_file.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import "../../../export.dart";

Future<File?> getThumbnail({MediaFile? file}) async {
  if (file == null) {
    throw 'no file';
  }

  final File? thumbnail =
      await _generateThumbnail(file).onError((error, stackTrace) {
    throw 'error';
  });
  return thumbnail;
}

Future<File?> _generateThumbnail(MediaFile file) async {
  File? generatedFile;

  if (file.localPath != null) {
    Uint8List? data = await VideoThumbnail.thumbnailData(
      video: file.localPath!,
      imageFormat: ImageFormat.PNG,
    );
    if (data == null) {
      throw 'error';
    }

    final tempDir = await getTemporaryDirectory();
    generatedFile = await File(
            '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png')
        .create();
    generatedFile.writeAsBytesSync(data);
  } else {
    final cacheDirectory = (await getApplicationCacheDirectory()).path;
    final fileBaseName = file.networkPath!.split('/').last;
    final File existingFile = File(
        '$cacheDirectory/${fileBaseName.substring(0, fileBaseName.lastIndexOf('.'))}.png');
    if (await existingFile.exists()) {
      generatedFile = existingFile;
    } else {
      String? stringPath = await VideoThumbnail.thumbnailFile(
        video: '$videoBaseUrl${file.networkPath!}',
        imageFormat: ImageFormat.PNG,
      );
      if (stringPath == null) {
        throw 'error';
      }
      generatedFile = File(stringPath);
    }
  }

  return generatedFile;
}
