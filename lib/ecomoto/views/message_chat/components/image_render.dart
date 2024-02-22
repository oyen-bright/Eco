part of '../message_chat.dart';

class ImageRender extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final double borderWidth;
  final Color borderColor;
  final String heroTag;

  const ImageRender(
      {Key? key,
      required this.imageUrl,
      this.width = 200,
      this.height = 200,
      this.borderWidth = 2.5,
      this.borderColor = Colors.black,
      this.heroTag = "fullscreen"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await AppRouter.router.push(
          EcomotoRoutes.ecomotoFullImageView,
          extra: [imageUrl, heroTag],
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor,
              width: borderWidth,
            ),
          ),
          child: Hero(
            tag: heroTag,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: width,
              height: height,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: width,
                  height: height,
                  color: Colors.white,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}
