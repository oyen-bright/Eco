part of '../showcase_vehicle_view.dart';

class SelectImagesVideos extends StatefulWidget {
  final VehicleModel vehicleInputData;
  const SelectImagesVideos({
    super.key,
    required this.vehicleInputData,
  });

  @override
  State<SelectImagesVideos> createState() => _SelectImagesVideosState();
}

class _SelectImagesVideosState extends State<SelectImagesVideos> {
  List<XFile?> images = [null, null, null, null, null, null];
  List<XFile?> otherImages = [null, null, null, null];
  List<XFile?> videos = [null];

  void _selectImage(BuildContext context, List<XFile?> files, int index) async {
    try {
      final image = await appImageVideoPicker(context,
          showOptions: false, source: ImageSource.gallery);
      files[index] = image;

      setState(() {});
    } on PlatformException catch (e) {
      if (mounted) {
        context.showSnackBar((e).message);
      }
    }
  }

  void _selectVideo(BuildContext context, List<XFile?> files, int index) async {
    try {
      final XFile? selectedVideo = await appImageVideoPicker(context,
          source: ImageSource.gallery,
          videoData: (
            maxDuration: AppConstants.vehicleVideoDuration,
            isVideo: true
          ));

      if (selectedVideo != null) {
        final compressedVideo = await _compressSelectedVideo(selectedVideo);
        int fileSizeInBytes = await compressedVideo.length();

        if (fileSizeInBytes <=
            AppConstants.maximumVideoFileSizeMB * 1024 * 1024) {
          files[index] = (XFile(compressedVideo.path));
          setState(() {});
        } else {
          if (mounted) {
            context.showSnackBar(Strings.videoSizeErrorText, BarType.error);
          }
        }
      }
    } on PlatformException catch (e) {
      if (mounted) {
        context.showSnackBar((e).message);
      }
    }
  }

  Future<File> _compressSelectedVideo(XFile file) async {
    context
        .read<LoadingCubit>()
        .loading(message: Strings.processingVideoPrompt);
    final response = await videoCompressor(file.path);
    if (mounted) {
      context.read<LoadingCubit>().loaded();
    }

    return response ?? File(file.path);
  }

  void _onProceed() async {
    if (!images.any((element) => element == null)) {
      final vehicleImages =
          images.nonNulls.toList() + otherImages.nonNulls.toList();
      final vehicleVideos = videos.nonNulls.toList();
      final vehicleData = widget.vehicleInputData;

      final response = await context.read<VehicleCubit>().listVehicle(
            vehicleData: vehicleData,
            vehicleImages: vehicleImages.isEmpty ? null : vehicleImages,
            vehicleVideos: vehicleVideos.isEmpty ? null : vehicleVideos,
          );

      if (mounted) {
        if (response.error == null) {
          context.showSnackBar(Strings.vehicleListedSuccess);
          AppRouter.router.push(
            EcomotoRoutes.vehicleListingListed,
          );
        } else {
          context.showSnackBar(response.error, BarType.error);
        }
      }
    } else {
      context.showSnackBar(
          Strings.andPictureErrorText,
          BarType.action,
          SnackBarAction(
              label: Strings.andPictureErrorButtonText,
              onPressed: () =>
                  ShowImageGuidelines.imageGuidelineView(context)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                const ShowImageGuidelines(),
                const SizedBox(
                  height: AppSizes.size10,
                ),
                _buildImageGrid(),
                const SizedBox(
                  height: AppSizes.size10,
                ),
                _buildOtherImageGrid(),
                const SizedBox(
                  height: AppSizes.size20,
                ),
                _buildVideoGrid(context),
                const SizedBox(
                  height: AppSizes.size20,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Expanded(
                child: AppElevatedButtonWithIcon(
                  onPressed: () => context.pop(),
                  navigateBackward: true,
                ),
              ),
              const SizedBox(
                width: AppSizes.size10,
              ),
              Expanded(
                child: AppElevatedButtonWithIcon(
                  onPressed: _onProceed,
                  navigateForward: true,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _closeButton(int index, BuildContext context, void Function()? onTap) {
    return Positioned(
      top: 10,
      right: 10,
      child: Material(
        elevation: 2,
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: CircleAvatar(
            foregroundColor: Colors.white,
            backgroundColor: context.colorScheme.primary.withOpacity(0.9),
            radius: 10,
            child: const Icon(
              Icons.remove_circle_outline,
              size: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _gridBuilder(
      {required Widget? Function(BuildContext, int) itemBuilder,
      required int length}) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: length,
        itemBuilder: itemBuilder,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          childAspectRatio: 1.2,
        ));
  }

  Widget _buildImageGrid() {
    return SizedBox(
      width: double.infinity,
      child: _gridBuilder(
        length: 6,
        itemBuilder: (context, index) {
          final imageFile = images[index];

          final prompts = [
            Strings.frontImagePrompt,
            Strings.leftImagePrompt,
            Strings.backImagePrompt,
            Strings.rightImagePrompt,
            Strings.frontInteriorImagePrompt,
            Strings.backInteriorImagePrompt
          ];

          return Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: imageFile != null
                      ? Colors.white
                      : AppColors.darkGreyColor2,
                ),
                child: imageFile != null
                    ? _buildImageAvailable(imageFile)
                    : _buildNoResourceAvailable(
                        prompts, index, context, images),
              ),
              if (imageFile != null)
                _closeButton(index, context, () {
                  images[index] = null;
                  setState(() {});
                }),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOtherImageGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          Strings.otherImagesHeader,
          style: context.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: AppSizes.size10,
        ),
        SizedBox(
          width: double.infinity,
          child: _gridBuilder(
            length: 4,
            itemBuilder: (context, index) {
              final imageFile = otherImages[index];

              final prompts = [
                Strings.otherImagesPrompt,
                Strings.otherImagesPrompt,
                Strings.otherImagesPrompt,
                Strings.otherImagesPrompt,
              ];

              return Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: imageFile != null
                          ? Colors.white
                          : AppColors.darkGreyColor2,
                    ),
                    child: imageFile != null
                        ? _buildImageAvailable(imageFile)
                        : _buildNoResourceAvailable(
                            prompts, index, context, otherImages),
                  ),
                  if (imageFile != null)
                    _closeButton(index, context, () {
                      otherImages[index] = null;
                      setState(() {});
                    }),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildVideoGrid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.addVideoText,
          style: context.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          Strings.addVideoGuidelineText,
          style: context.textTheme.bodySmall,
        ),
        const SizedBox(height: AppSizes.size10),
        SizedBox(
          width: double.infinity,
          child: _gridBuilder(
            length: 1,
            itemBuilder: (context, index) {
              final videoFile = videos[index];

              return Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: videoFile != null
                          ? Colors.black.withOpacity(0.9)
                          : AppColors.darkGreyColor2,
                    ),
                    child: videoFile != null
                        ? _buildVideoAvailable(videoFile)
                        : _buildNoResourceAvailable(
                            [Strings.noVideoPrompt], index, context, videos,
                            isVideo: true),
                  ),
                  if (videoFile != null)
                    _closeButton(index, context, () {
                      videos[index] = null;
                      setState(() {});
                    }),
                ],
              );
            },
          ),
        )
      ],
    );
  }

  Image _buildImageAvailable(XFile imageFile) {
    return Image.file(
      File(imageFile.path),
      fit: BoxFit.cover,
    );
  }

  AppVideoPlayer _buildVideoAvailable(XFile videoFile) {
    return AppVideoPlayer.file(
      videoFile.path,
    );
  }

  Padding _buildNoResourceAvailable(
      List<String> prompts, int index, BuildContext context, List<XFile?> files,
      {bool isVideo = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.uploadImageIcon,
          ),
          AutoSizeText(
            prompts[index],
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall
                ?.copyWith(fontSize: 13, fontWeight: FontWeight.w500),
            maxLines: 2,
          ),
          Flexible(
              child: SizedBox(
            width: double.infinity,
            child: TextButton(
                style: TextButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                onPressed: () async {
                  !isVideo
                      ? _selectImage(context, files, index)
                      : _selectVideo(context, files, index);
                },
                child: const Text(
                  Strings.selectImagePrompt,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.primaryColor,
                  ),
                )),
          ))
        ],
      ),
    );
  }
}
