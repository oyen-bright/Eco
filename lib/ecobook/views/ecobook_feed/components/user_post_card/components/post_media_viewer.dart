import 'package:emr_005/extensions/context.dart';
import 'package:flutter/material.dart';

import '../../../../../../ui/components/widgets/cached_image.dart';

class PostMediaViewer extends StatefulWidget {
  final int itemCount;
  final List<String> imageUrl;
  final int mediaLength;

  const PostMediaViewer({
    Key? key,
    required this.itemCount,
    required this.imageUrl,
    required this.mediaLength,
  }) : super(key: key);

  @override
  PostMediaViewerState createState() => PostMediaViewerState();
}

class PostMediaViewerState extends State<PostMediaViewer>
    with SingleTickerProviderStateMixin {
  int currentPage = 0;
  bool isSingleImage = false;

  @override
  void initState() {
    super.initState();
    updateIndicatorVisibility();
    _transformationController = TransformationController();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700))
      ..addListener(() => _transformationController.value = animation!.value)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          removeOverlay();
        }
      });
    isSingleImage = widget.imageUrl.length == 1;
  }

  @override
  void didUpdateWidget(PostMediaViewer oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      isSingleImage = widget.imageUrl.length == 1;
      updateIndicatorVisibility();
    });
  }

  void removeOverlay() {
    if (entry != null) {
      setState(() {
        entry!.remove();
        entry = null;
      });
    }
  }

  void resetAnimation() {
    animation = Matrix4Tween(
            begin: _transformationController.value, end: Matrix4.identity())
        .animate(CurvedAnimation(
            parent: animationController, curve: Curves.bounceOut));
  }

  @override
  void dispose() {
    _transformationController.dispose();
    animationController.dispose();
    super.dispose();
  }

  void showOverlay(BuildContext context) {
    removeOverlay();

    entry = OverlayEntry(builder: (context) {
      return Positioned(
          child: Scaffold(
        backgroundColor: Colors.black.withOpacity(.50),
        body: Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: double.infinity,
              child: buildImageViewer(index: currentPage),
            )),
      ));
    });
    final overlay = Overlay.of(context, rootOverlay: true);
    overlay.insert(entry!);
  }

  final double minScale = .50;
  final double maxScale = 4;
  OverlayEntry? entry;
  late TransformationController _transformationController;
  late AnimationController animationController;
  Animation<Matrix4>? animation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        buildViewer(),
        if (!isSingleImage)
          Positioned(
            right: 10.0,
            top: 0,
            child: buildIndicatorVisibility(),
          ),
        if (!isSingleImage)
          Positioned(
            bottom: 10.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(

                (widget.mediaLength),
                    (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 1.0),
                  width: currentPage % (widget.mediaLength) == index ? 8.0 : 5.0,
                  height: currentPage % (widget.mediaLength) == index ? 8.0 : 5.0,

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPage % (widget.mediaLength) == index
                        ? context.colorScheme.background
                        : context.colorScheme.background.withOpacity(.50),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget buildViewer() {
    return PageView.builder(
      onPageChanged: (index) {
        setState(() {
          currentPage = index;
          shouldShowIndicator = true;
          updateIndicatorVisibility();
          resetTransformationState();
        });
      },
      clipBehavior: Clip.none,
      controller: PageController(),
      itemCount: widget.itemCount,
      itemBuilder: (context, index) {
        return ClipRRect(
          child: buildImageViewer(index: index),
        );
      },
    );
  }

  Widget buildImageViewer({required int index}) {
    return InteractiveViewer(
      minScale: minScale,
      maxScale: maxScale,
      transformationController: _transformationController,
      onInteractionStart: (details) {
        print('Interaction started');
        showOverlay(context);
      },
      onInteractionEnd: (details) {
        setState(() {
          resetTransformationState();
          resetAnimation();
        });
        removeOverlay();
      },

      child: AppCachedImage(
        withPinata: true,
        imageUrl: widget.imageUrl[index],

        fit: BoxFit.contain,
      ),
    );
  }


  Widget buildIndicatorVisibility() {
    return Visibility(
      visible: shouldShowIndicator,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.black,
        ),
        child: Text(
          "${currentPage + 1}/${widget.mediaLength}",
          style: context.textTheme.labelSmall!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 8,
            color: context.colorScheme.background,
          ),
        ),
      )
    );
  }


  bool shouldShowIndicator = true;

  void updateIndicatorVisibility() {
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          shouldShowIndicator = false;
        });
      }
    });
  }



  void resetTransformationState() {
    _transformationController.value = Matrix4.identity();
  }
}
