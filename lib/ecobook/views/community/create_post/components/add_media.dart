part of create_community_post;

class AddMediaToPost extends StatefulWidget {
  final void Function() onImageTap;

  const AddMediaToPost(
      {super.key,
      required this.onImageTap,
     });

  @override
  State<AddMediaToPost> createState() => AddMediaToPostState();
}

class AddMediaToPostState extends State<AddMediaToPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppConstants.contentPadding,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          color: AppColors.postBackgroundColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Strings.addToYourPost,
            style: context.textTheme.titleSmall!
                .copyWith(color: AppColors.lowOpacityTextColor),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Material(
                color: Colors.transparent,
                child: Ink.image(
                  image: const AssetImage(AppImages.addImageIcon),
                  height: 25,
                  width: 25,
                  child: InkWell(onTap: widget.onImageTap),
                ),
              ),
              // Material(
              //   color: Colors.transparent,
              //   child: Ink.image(
              //     image: const AssetImage(AppImages.addVideoIcon),
              //     height: 25,
              //     width: 25,
              //     child: InkWell(onTap: widget.onVideoTap),
              //   ),
              // ),
              // Material(
              //   color: Colors.transparent,
              //   child: Ink.image(
              //     image: const AssetImage(AppImages.tagPeopleIcon),
              //     height: 25,
              //     width: 25,
              //     child: InkWell(onTap: widget.onTag),
              //   ),
              // ),
              // Material(
              //   color: Colors.transparent,
              //   child: Ink.image(
              //     image: const AssetImage(AppImages.moreOption),
              //     height: 25,
              //     width: 25,
              //     child: InkWell(onTap: widget.onMore),
              //   ),
              // ),
            ],
          )
        ],
      ),
    );
  }
}
