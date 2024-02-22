import 'package:carousel_slider/carousel_slider.dart';
import 'package:emr_005/ui/components/widgets/cached_image.dart';
import 'package:emr_005/ui/components/widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppCarousel<T> extends StatelessWidget {
  final List<T> items;
  final bool autoPlay;
  final double aspectRatio;
  final double viewportFraction;
  final CarouselOptions? carouselOptions;
  final CarouselController? carouselController;
  final dynamic Function(int, CarouselPageChangedReason)? onPageChanged;
  final Widget Function(BuildContext, int, int) itemBuilder;

  const AppCarousel({
    Key? key,
    required this.itemBuilder,
    required this.items,
    this.autoPlay = true,
    this.onPageChanged,
    this.carouselController,
    this.aspectRatio = 2.0,
    this.carouselOptions,
    this.viewportFraction = 0.8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: items.length,
      carouselController: carouselController,
      options: carouselOptions ??
          CarouselOptions(
            onPageChanged: onPageChanged,
            autoPlay: autoPlay,
            autoPlayAnimationDuration: 1.seconds,
            aspectRatio: aspectRatio,
            viewportFraction: viewportFraction,
            enlargeCenterPage: false,
          ),
      itemBuilder: itemBuilder,
    );
  }

  static AppCarousel<String> forImages({
    required List<String> items,
    bool autoPlay = true,
    double aspectRatio = 1,
    double viewportFraction = 1,
    CarouselOptions? carouselOptions,
    CarouselController? carouselController,
    dynamic Function(int, CarouselPageChangedReason)? onPageChanged,
  }) {
    return AppCarousel<String>(
      itemBuilder: (context, index, realIndex) {
        return AppCachedImage(imageUrl: items[index]);
      },
      items: items,
      carouselController: carouselController,
      onPageChanged: onPageChanged,
      autoPlay: autoPlay,
      aspectRatio: aspectRatio,
      viewportFraction: viewportFraction,
      carouselOptions: carouselOptions,
    );
  }

  static AppCarousel<Map> forPinataImages({
    required List<Map> items,
    bool autoPlay = true,
    BoxFit? fit = BoxFit.cover,
    double aspectRatio = 1,
    double viewportFraction = 1,
    CarouselOptions? carouselOptions,
    CarouselController? carouselController,
    dynamic Function(int, CarouselPageChangedReason)? onPageChanged,
  }) {
    return AppCarousel<Map>(
      itemBuilder: (context, index, realIndex) {
        String? imageUrl = (items[index])['imageUrl'];
        String? videoUrl = (items[index])['videoUrl'];

        if (imageUrl == null) {
          return Container(
            color: Colors.black,
            child: SizedBox.expand(
              child: AppVideoPlayer.network(
                videoUrl!,
                withPinata: true,
              ),
            ),
          );
        }
        return SizedBox.expand(
            child: AppCachedImage(
          withPinata: true,
          imageUrl: imageUrl,
          fit: fit,
        ));
      },
      items: items,
      autoPlay: autoPlay,
      carouselController: carouselController,
      onPageChanged: onPageChanged,
      aspectRatio: aspectRatio,
      viewportFraction: viewportFraction,
      carouselOptions: carouselOptions,
    );
  }
}
