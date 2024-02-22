part of create_community_post;

class CommunityPostDialogWidget extends StatefulWidget {
  final Community community;
  const CommunityPostDialogWidget({super.key, required this.community});

  @override
  State<CommunityPostDialogWidget> createState() => CommunityPostDialogWidgetState();
}

class CommunityPostDialogWidgetState extends State<CommunityPostDialogWidget> {

  late final TextEditingController _contentController;
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollbarController = ScrollController();

  Color selectedTextColor = Colors.black;
  String selectedPrivacy = 'Public';

  Color selectedColorFromPicker = Colors.transparent;

  final postInputData = PostModel();



  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController();
  }



  void _onPost() async {
    context.removeFocus;

    if (_contentController.text.isNotEmpty || _imageFileList!.isNotEmpty) {
      final response = await context.read<CommunityBloc>().uploadMedia(
          imageFiles: _imageFileList);
      print(response.imageCids);
      postInputData.imageUrl = response.imageCids as List<String>;
      postInputData.videoUrl = response.videoCids as List<String>;

      postInputData.content = _contentController.text;

      print(postInputData);
      setState(() {
        _performEvent();
      });
    }

  }

  void _performEvent()  {
    print(postInputData);
    print(widget.community.id);
    context.read<CommunityBloc>().add(CommunityEvent.createCommunityPost(postModel: postInputData, communityId: widget.community.id!));
    Navigator.pop(context);
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const CreatePostHeader(),
        Column(
          children: [

            BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding:
                          const EdgeInsets.only(right: AppSizes.size4),
                          child: NameAvatar(
                            data: state.usernameInitials,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NameText(
                              data: state.when<String>(
                                details: (user) => user.username,
                              ),
                              fontWeight: FontWeight.bold,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: context.colorScheme.primary
                              ),
                              child: Text(' ${widget.community.name} ',
                                  maxLines: 1,
                                  style: context.textTheme.bodySmall!.copyWith(
                                      color: context.colorScheme.background,
                                      fontSize: 10)),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }),

            const SizedBox(height: 10,),

            SizedBox(
              height: _imageFileList!.isEmpty ? context.viewSize.height*.58 : context.viewSize.height*.50,
              child: Scrollbar(
                trackVisibility: true,
                radius: const Radius.circular(AppConstants.borderRadius),
                controller: _scrollbarController,
                interactive: true,
                thickness: 5,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: _scrollbarController,
                  child: TextFormField(
                    controller: _contentController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      hintText: Strings.whatsOnYourMindText,
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    textInputAction: TextInputAction.newline,
                  ),
                ),
              ),

            ),

            _imageFileList!.isNotEmpty
                ? _buildImageGrid()
                : const SizedBox(),


          ],
        ).withContentPadded,

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Expanded(child: AddMediaToPost(
              // onVideoTap: ()async {_selectVideo(context);},
              onImageTap: _selectImages,

            ),),
            Align(alignment: Alignment.centerLeft,
              child: IconButton(
                  onPressed: _buildColorPicker,
                  icon: Image.asset(AppImages.colorPickerIcon)),),
            const SizedBox(height: 12),

          ],
        ),

        AppElevatedButton(title: 'Post', onPressed: _onPost).withContentPadded

      ],
    ).withContentPadded;
  }

  Widget _buildImageGrid() {
    return SizedBox(
      height: context.viewSize.height * 0.12,
      width: context.viewSize.width,

      child: Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        trackVisibility: true,
        radius: const Radius.circular(AppConstants.borderRadius),
        thickness: 5,
        interactive: true,
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: context.viewSize.height * .15,
              crossAxisCount: 1,
              mainAxisSpacing: AppSizes.size10),
          itemCount: _imageFileList?.length ?? 0,
          itemBuilder: (context, index) {
            final imageFile = _imageFileList![index];
            return Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: context.colorScheme.onBackground.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Image.file(
                    File(imageFile.path),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: CircleAvatar(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        context.colorScheme.primary.withOpacity(0.9),
                    radius: 14,
                    child: IconButton(
                      style: IconButton.styleFrom(
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact),
                      icon: const Icon(
                        Icons.close_rounded,
                        size: 14,
                      ),
                      onPressed: () {
                        _toggleSelection(index);
                        _removeSelectedImages();
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      )
    );
  }

  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFileList = [];
  final Set<int> _selectedIndices = <int>{};

  void _toggleSelection(int index) {
    setState(() {
      if (_selectedIndices.contains(index)) {
        _selectedIndices.remove(index);
      } else {
        _selectedIndices.add(index);
      }
    });
  }

  void _removeSelectedImages() {
    final List<XFile> newImageList = [];
    for (int i = 0; i < _imageFileList!.length; i++) {
      if (!_selectedIndices.contains(i)) {
        newImageList.add(_imageFileList![i]);
      }
    }

    setState(() {
      _imageFileList = newImageList;
      _selectedIndices.clear();
    });
  }

  void _selectImages() async {
    final List<XFile> selectedImages = await _picker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      _imageFileList?.addAll(selectedImages);
      debugPrint("Image List Length : ${_imageFileList!.length}");
    }
    setState(() {});
  }

  void _buildColorPicker() {
    ColorPicker(
      color: selectedColorFromPicker,
      onColorChanged: (Color color) {
        setState(() {
          selectedColorFromPicker = color;
        });
      },
    ).showPickerDialog(
      context,
    );
  }
}
