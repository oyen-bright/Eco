import 'dart:io';

import 'package:emr_005/data/http/endpoints.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AppVideoPlayer extends StatefulWidget {
  final String? videoFilePath;
  final String? videoNetworkUrl;
  final bool withPinata;

  const AppVideoPlayer._(
      {Key? key,
      this.videoFilePath,
      this.videoNetworkUrl,
      this.withPinata = false})
      : super(key: key);

  factory AppVideoPlayer.file(
    String videoFilePath,
  ) {
    return AppVideoPlayer._(
      videoFilePath: videoFilePath,
    );
  }

  factory AppVideoPlayer.network(String videoNetworkUrl,
      {bool withPinata = false}) {
    return AppVideoPlayer._(
        videoNetworkUrl: videoNetworkUrl, withPinata: withPinata);
  }

  @override
  State<AppVideoPlayer> createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer>
    with WidgetsBindingObserver {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    if (widget.videoFilePath != null) {
      _controller = VideoPlayerController.file(
        File(widget.videoFilePath!),
      );
    } else if (widget.videoNetworkUrl != null) {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.withPinata
            ? Endpoint.pinataImageFetch + widget.videoNetworkUrl!
            : widget.videoNetworkUrl!),
      );
    } else {
      throw ArgumentError(
          'Either videoFilePath or videoNetworkUrl must be provided.');
    }

    _controller.initialize().then((_) {
      setState(() {});
    });

    // _controller.addListener(_controllerListener);

    WidgetsBinding.instance.addObserver(this);
  }

  void _controllerListener() {
    if (!_controller.value.isPlaying) {
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _controller.value.isPlaying
              ? _controller.pause()
              : _controller.play();
        });
      },
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : const Center(child: CircularProgressIndicator()),
            _buildPlayPauseButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayPauseButton() {
    return _controller.value.isPlaying
        ? Container()
        : Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.5),
              ),
              child: IconButton(
                icon: const Icon(Icons.play_arrow),
                iconSize: 50,
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    _controller.play();
                  });
                },
              ),
            ),
          );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.pause();
    _controller.dispose();
    _controller.removeListener(_controllerListener);

    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused) {
      _controller.pause();
    } else if (state == AppLifecycleState.resumed) {
      if (_controller.value.isPlaying) {
        _controller.play();
      }
    }
  }
}
