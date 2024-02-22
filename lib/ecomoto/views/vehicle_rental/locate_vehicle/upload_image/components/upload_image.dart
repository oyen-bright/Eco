part of '../upload_image_view.dart';

class UploadRentalImages extends StatefulWidget {
  final List<XFile?> images;
  const UploadRentalImages({super.key, required this.images});

  @override
  UploadRentalImagesState createState() => UploadRentalImagesState();
}

class UploadRentalImagesState extends State<UploadRentalImages> {
  @override
  Widget build(BuildContext context) {
    return _buildImageGrid();
  }

  Widget _gridBuilder({
    required Widget? Function(BuildContext, int) itemBuilder,
  }) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: widget.images.length,
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
        itemBuilder: (context, index) {
          final imageFile = widget.images[index];
          final prompts = [
            Strings.frontImagePrompt,
            Strings.leftImagePrompt,
            Strings.backImagePrompt,
            Strings.rightImagePrompt,
            Strings.insideFrontImagePrompt,
            Strings.insideBackImagePrompt
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
                    : _buildNoImageAvailable(prompts, index, context),
              ),
              if (imageFile != null)
                _closeButton(index, context, () {
                  widget.images[index] = null;
                  setState(() {});
                }),
            ],
          );
        },
      ),
    );
  }

  Image _buildImageAvailable(XFile imageFile) {
    return Image.file(
      File(imageFile.path),
      fit: BoxFit.cover,
    );
  }

  Padding _buildNoImageAvailable(
      List<String> prompts, int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
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
                  widget.images[index] = await appImageVideoPicker(context);
                  setState(() {});
                },
                child: const Text(
                  Strings.uploadImagePrompt,
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
}
