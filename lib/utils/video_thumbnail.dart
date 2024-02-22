import 'dart:developer';

import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

Future<String?> getVideoThumbnail(String videoUrl) async {
  try {
    final filePath = await VideoThumbnail.thumbnailFile(
      video: videoUrl,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.WEBP,
    );
    return filePath;
  } catch (e) {
    log(e.toString(), name: "Video Thumbnail - error");

    return null;
  }
}
