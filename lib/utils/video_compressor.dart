import 'dart:developer';
import 'dart:io';

import 'package:video_compress/video_compress.dart';

Future<File?> videoCompressor(String filePath) async {
  try {
    final mediaInfo = await VideoCompress.compressVideo(
      filePath,
      includeAudio: false,
      quality: VideoQuality.MediumQuality,
      deleteOrigin: true,
    );

    return mediaInfo?.file;
  } catch (e) {
    log(e.toString(), name: "Video Compressor - error");
    return null;
  }
}
