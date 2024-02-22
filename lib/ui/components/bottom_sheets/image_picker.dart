import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile?> appImageVideoPicker(BuildContext context,
    {({
      Duration? maxDuration,
      bool isVideo
    }) videoData = (maxDuration: null, isVideo: false),
    showOptions = true,
    ImageSource source = ImageSource.gallery}) async {
  if (!showOptions) {
    final ImagePicker picker = ImagePicker();

    if (videoData.isVideo) {
      final XFile? selectedVideo = await picker.pickVideo(
          source: source, maxDuration: videoData.maxDuration);
      return selectedVideo;
    }
    final XFile? selectedImage = await picker.pickImage(source: source);
    return selectedImage;
  }

  if (Platform.isAndroid) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: const Text('Photo Gallery'),
                  onTap: () async {
                    final res = await _handleGallerySelection();
                    if (context.mounted) {
                      Navigator.pop(context, res);
                    }
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text('Camera'),
                  onTap: () async {
                    final res = await _handleCameraSelection();
                    if (context.mounted) {
                      Navigator.pop(context, res);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  } else {
    return showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: <Widget>[
            CupertinoActionSheetAction(
              onPressed: () async {
                final res = await _handleGallerySelection(videoData: videoData);
                if (context.mounted) {
                  Navigator.pop(context, res);
                }
              },
              child: const Text('Photo Gallery'),
            ),
            CupertinoActionSheetAction(
              onPressed: () async {
                final res = await _handleCameraSelection(videoData: videoData);
                if (context.mounted) {
                  Navigator.pop(context, res);
                }
              },
              child: const Text('Camera'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
        );
      },
    );
  }
}

Future<XFile?> _handleGallerySelection(
    {({
      Duration? maxDuration,
      bool isVideo
    }) videoData = (maxDuration: null, isVideo: false)}) async {
  final ImagePicker picker = ImagePicker();
  final file = videoData.isVideo
      ? await picker.pickVideo(
          source: ImageSource.gallery, maxDuration: videoData.maxDuration)
      : await picker.pickImage(source: ImageSource.gallery);

  return file;
}

Future<XFile?> _handleCameraSelection(
    {({
      Duration? maxDuration,
      bool isVideo
    }) videoData = (maxDuration: null, isVideo: false)}) async {
  final ImagePicker picker = ImagePicker();
  final file = videoData.isVideo
      ? await picker.pickVideo(
          source: ImageSource.camera, maxDuration: videoData.maxDuration)
      : await picker.pickImage(source: ImageSource.camera);

  return file;
}
