import 'package:cached_network_image/cached_network_image.dart';
import 'package:emr_005/data/http/endpoints.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/ui/components/headers_footers/app_bar.dart';
import 'package:emr_005/ui/components/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class VehicleDetailsImagesView extends StatefulWidget {
  final List<Map> vehicleImages;
  final int selectedIndex;

  const VehicleDetailsImagesView(
      {super.key, required this.vehicleImages, required this.selectedIndex});

  @override
  State<VehicleDetailsImagesView> createState() => _VehicleImagesViewState();
}

class _VehicleImagesViewState extends State<VehicleDetailsImagesView> {
  int currentIndex = 0;
  double _dragDistance = 0.0;
  late final List<Map> vehicleImages;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    vehicleImages =
        widget.vehicleImages.where((e) => e['imageUrl'] != null).toList();
    currentIndex = widget.selectedIndex;
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppViewBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          _buildImageGallery(context),
          _buildImagePreview(context),
        ],
      ),
    );
  }

  SafeArea _buildImagePreview(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: vehicleImages.map((e) {
              final index = vehicleImages.indexOf(e);
              return GestureDetector(
                onTap: () {
                  _pageController.animateToPage(index,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeIn);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  height: context.viewSize.height * 0.12,
                  width: context.viewSize.height * 0.14,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2,
                          color: currentIndex != index
                              ? context.colorScheme.primary
                              : Colors.white)),
                  child: AppCachedImage(
                    withPinata: true,
                    imageUrl: widget.vehicleImages[index]['imageUrl'],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  GestureDetector _buildImageGallery(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        setState(() {
          _dragDistance += details.delta.dy;
        });
      },
      onVerticalDragEnd: (details) {
        if (_dragDistance > 90.0) {
          context.pop();
        }
        setState(() {
          _dragDistance = 0.0;
        });
      },
      child: PhotoViewGallery.builder(
        pageController: _pageController,
        itemCount: widget.vehicleImages.length,
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: CachedNetworkImageProvider(
                Endpoint.pinataImageFetch + vehicleImages[index]['imageUrl']),
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
            initialScale: PhotoViewComputedScale.contained,
          );
        },
        scrollPhysics: const BouncingScrollPhysics(),
        loadingBuilder: (context, event) => const Center(
          child: CircularProgressIndicator(),
        ),
        onPageChanged: (index) => setState(() {
          currentIndex = index;
        }),
        backgroundDecoration: const BoxDecoration(color: Colors.black),
      ),
    );
  }
}
