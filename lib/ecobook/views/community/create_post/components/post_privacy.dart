part of create_community_post;

class PostPrivacy extends StatefulWidget {
  final void Function(String) onPrivacySelected;
  const PostPrivacy({super.key, required this.onPrivacySelected});

  @override
  State<PostPrivacy> createState() => PostPrivacyState();
}

class PostPrivacyState extends State<PostPrivacy> {
  final ScrollController _scrollController = ScrollController();

  bool publicChecked = true;
  bool friendsChecked = false;
  bool friendsExceptChecked = false;
  bool privateChecked = false;

  void setPrivacyOptions(
      {required bool isPublic,
      required bool isFriends,
      required bool isFriendsExcept,
      required bool isPrivate}) {
    setState(() {
      publicChecked = isPublic;
      friendsChecked = isFriends;
      friendsExceptChecked = isFriendsExcept;
      privateChecked = isPrivate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: AppConstants.contentPadding,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.arrow_back),
              Text(
                'Post Audience',
                style: context.textTheme.titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox()
            ],
          ),
          Divider(
            color: context.colorScheme.onBackground,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              Strings.postPrivacyTitle,
              style: context.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.lowOpacityTextColor),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              Strings.privacyDescText,
              style: context.textTheme.bodyMedium!
                  .copyWith(color: AppColors.lowOpacityTextColor),
            ),
          ),
          const SizedBox(
            height: AppSizes.size10,
          ),
          SizedBox(
            height: 190,
            child: Scrollbar(
                thumbVisibility: true,
                thickness: 10,
                interactive: true,
                radius: const Radius.circular(AppConstants.borderRadius),
                controller: _scrollController,
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    controller: _scrollController,
                    child: Column(
                      children: [
                        privacyRow(
                            imageString: AppImages.publicIcon,
                            headingText: 'Public',
                            descText: 'Everyone on Ecobook',
                            isChecked: publicChecked,
                            privacyText: 'Public',
                            onPressed: () {
                              setPrivacyOptions(
                                  isPublic: true,
                                  isFriends: false,
                                  isFriendsExcept: false,
                                  isPrivate: false);
                            }),
                        privacyRow(
                            imageString: AppImages.friendsIcon,
                            headingText: 'Friends',
                            privacyText: 'Friends',
                            descText: 'Your friends on Ecobook',
                            isChecked: friendsChecked,
                            onPressed: () {
                              setPrivacyOptions(
                                  isPublic: false,
                                  isFriends: true,
                                  isFriendsExcept: false,
                                  isPrivate: false);
                            }),
                        privacyRow(
                            imageString: AppImages.exceptFriendsIcon,
                            headingText: 'Friends Except',
                            privacyText: 'Friends Except',
                            descText: 'Your friends except',
                            isChecked: friendsExceptChecked,
                            onPressed: () {
                              setPrivacyOptions(
                                  isPublic: false,
                                  isFriends: false,
                                  isFriendsExcept: true,
                                  isPrivate: false);
                            }),
                        privacyRow(
                            imageString: AppImages.privateIcon,
                            headingText: 'Only me',
                            privacyText: 'Only me',
                            descText: 'Only you',
                            isChecked: privateChecked,
                            onPressed: () {
                              setPrivacyOptions(
                                  isPublic: false,
                                  isFriends: false,
                                  isFriendsExcept: false,
                                  isPrivate: true);
                            }),
                      ],
                    ))),
          ),
          const Spacer(),
          AppElevatedButton(
            title: 'Save Changes',
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    ));
  }

  Widget privacyRow({
    required String imageString,
    required String headingText,
    required String descText,
    required bool isChecked,
    required VoidCallback onPressed,
    required String privacyText,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        color: isChecked ? AppColors.privacyBackgroundColor : null,
      ),
      child: InkWell(
          onTap: () {
            onPressed();
            widget.onPrivacySelected(privacyText);
          },
          child: Padding(
            padding: const EdgeInsets.only(
                top: 3,
                bottom: 3,
                left: AppConstants.viewPaddingHorizontal,
                right: AppConstants.viewPaddingHorizontal),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(imageString),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          headingText,
                          style: context.textTheme.titleSmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(descText,
                            style: context.textTheme.bodySmall!.copyWith(
                                color: AppColors.lowOpacityTextColor)),
                      ],
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: context.colorScheme.primary,
                      width: 1.0,
                    ),
                  ),
                  child: isChecked
                      ? Icon(Icons.circle,
                          size: 15, color: context.colorScheme.primary)
                      : const SizedBox(
                          width: 15,
                          height: 15,
                        ),
                ),
              ],
            ),
          )),
    );
  }
}
