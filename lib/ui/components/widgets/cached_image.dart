import 'package:cached_network_image/cached_network_image.dart';
import 'package:emr_005/data/http/endpoints.dart';
import 'package:emr_005/ui/components/widgets/shimmer.dart';
import 'package:flutter/material.dart';

class AppCachedImage extends StatelessWidget {
  final String? imageUrl;
  final BoxFit? fit;
  final bool withPinata;
  final Widget Function(BuildContext, String)? placeholder;
  final Widget Function(BuildContext, String, Object)? errorWidget;
  final Widget Function(BuildContext, String, DownloadProgress)?
      progressIndicatorBuilder;

  const AppCachedImage({
    Key? key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.withPinata = false,
    this.placeholder,
    this.errorWidget,
    this.progressIndicatorBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl == null
        ? AppShimmer(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(color: Colors.grey),
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ),
          )
        : CachedNetworkImage(
            imageUrl:
                withPinata ? Endpoint.pinataImageFetch + imageUrl! : imageUrl!,
            fit: fit,
            // placeholder: progressIndicatorBuilder == null
            //     ? placeholder ??
            //         (context, url) => AppShimmer(
            //               child: Container(
            //                 width: double.infinity,
            //                 height: double.infinity,
            //                 decoration: const BoxDecoration(color: Colors.grey),
            //               ),
            //             )
            //     : null,
            errorWidget: errorWidget ??
                (context, url, error) => AppShimmer(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: const BoxDecoration(color: Colors.grey),
                        alignment: Alignment.center,
                        child: const Icon(Icons.error),
                      ),
                    ),
            progressIndicatorBuilder: progressIndicatorBuilder ??
                (context, url, downloadProgress) => AppShimmer(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: const BoxDecoration(color: Colors.grey),
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                    ),
          );
  }
}
