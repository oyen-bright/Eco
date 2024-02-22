import 'dart:io';

import 'package:emr_005/ui/components/widgets/shimmer.dart';
import 'package:emr_005/utils/video_thumbnail.dart';
import 'package:flutter/material.dart';

import '../../../data/http/endpoints.dart';

class VideoThumbnailBuilder extends StatefulWidget {
  final String videoURL;
  final bool withPinata;
  const VideoThumbnailBuilder(
      {super.key, required this.videoURL, this.withPinata = false});

  @override
  State<VideoThumbnailBuilder> createState() => _VideoThumbnailBuilderState();
}

class _VideoThumbnailBuilderState extends State<VideoThumbnailBuilder> {
  @override
  void initState() {
    super.initState();
    _loadVideoThumbnail();
  }

  String? thumbnailFilePart;

  void _loadVideoThumbnail() async {
    final response = await getVideoThumbnail(widget.withPinata
        ? Endpoint.pinataImageFetch + widget.videoURL
        : widget.videoURL);
    if (response != null) {
      if (mounted) {
        setState(() {
          thumbnailFilePart = response;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: (thumbnailFilePart == null
                ? AppShimmer(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(color: Colors.grey),
                      alignment: Alignment.center,
                    ),
                  )
                : Image.file(
                    File(thumbnailFilePart!),
                    fit: BoxFit.cover,
                  ))),
        const Positioned(
          top: 5,
          right: 5,
          child: Icon(
            Icons.play_circle_fill,
          ),
        )
      ],
    );
  }
}
