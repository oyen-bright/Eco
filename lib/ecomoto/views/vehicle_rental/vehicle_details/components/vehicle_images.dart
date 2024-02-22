part of vehicle_details;

class VehicleImagesViewer extends StatefulWidget {
  final Vehicle vehicle;

  const VehicleImagesViewer({Key? key, required this.vehicle})
      : super(key: key);

  @override
  VehicleImagesViewerState createState() => VehicleImagesViewerState();
}

class VehicleImagesViewerState extends State<VehicleImagesViewer> {
  late final CarouselController carouselController;

  @override
  void initState() {
    super.initState();
    carouselController = CarouselController();
  }

  @override
  void dispose() {
// TODO:dispose carousel controller
    super.dispose();
  }

  String? selectedImage;
  int? selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildImageViewer(context),
        const SizedBox(
          height: AppSizes.size10,
        ),
        _buildImagePreViewer(context)
      ],
    );
  }

  SizedBox _buildImagePreViewer(BuildContext context) {
    return SizedBox(
      height: context.viewSize.height * 0.12,
      width: context.viewSize.width,
      child: SizedBox(
        child: GridView.builder(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.viewPaddingHorizontal),
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: context.viewSize.height * .15,
              crossAxisCount: 1,
              mainAxisSpacing: AppSizes.size10),
          itemCount: widget.vehicle.carImages.length,
          itemBuilder: (context, index) {
            final isSelected = selectedIndex == index;

            final String? imageURL =
                widget.vehicle.carImages[index]['imageUrl'];
            final String? videoUrl =
                widget.vehicle.carImages[index]['videoUrl'];
            return GestureDetector(
              onTap: () {
                carouselController.animateToPage(index);
                if (selectedIndex != index) {
                  setState(() {
                    selectedIndex = index;
                  });
                }
              },
              child: Container(
                padding: isSelected ? const EdgeInsets.all(5) : null,
                decoration: BoxDecoration(
                    border: isSelected
                        ? Border.all(color: context.colorScheme.primary)
                        : null),
                child: imageURL != null
                    ? AppCachedImage(
                        withPinata: true,
                        imageUrl: imageURL,
                        fit: BoxFit.cover,
                      )
                    : VideoThumbnailBuilder(
                        videoURL: videoUrl ?? "",
                        withPinata: true,
                      ),
              ),
            );
          },
        ),
      ),
    );
  }

  GestureDetector _buildImageViewer(BuildContext context) {
    return GestureDetector(
      onTap: () => AppRouter.router.push(EcomotoRoutes.vehicleImageViewer,
          extra: [widget.vehicle, selectedIndex ?? 0]),
      child: Container(
        width: context.viewSize.width,
        height: context.viewSize.height * 0.30,
        // padding: EdgeInsets.symmetric(
        //     horizontal: AppConstants.viewPaddingHorizontal),
        decoration: const BoxDecoration(color: Colors.white),
        child: widget.vehicle.carImages.isEmpty
            ? Image.asset(AppImages.noVehicleImage)
            : AppCarousel.forPinataImages(
                onPageChanged: (p0, p1) {
                  if (selectedIndex != p0) {
                    setState(() {
                      selectedIndex = p0;
                    });
                  }
                },
                carouselController: carouselController,
                autoPlay: false,
                items: widget.vehicle.carImages,
                fit: BoxFit.cover),
      ),
    );
  }
}
