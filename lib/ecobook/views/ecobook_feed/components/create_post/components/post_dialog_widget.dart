part of create_post;

class PostDialogWidget extends StatefulWidget {
  const PostDialogWidget({super.key});

  @override
  State<PostDialogWidget> createState() => PostDialogWidgetState();
}

class PostDialogWidgetState extends State<PostDialogWidget> {

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
      final response = await context.read<FeedBloc>().uploadMedia(
          imageFiles: _imageFileList);
      print(response.imageCids);
      postInputData.imageUrl = response.imageCids as List<String>;
      postInputData.videoUrl = response.videoCids as List<String>;
      postInputData.content = _contentController.text;
       _performEvent();
    }
  }

  void _performEvent()  {
    context.read<FeedBloc>().add(FeedEvent.createPost(postModel: postInputData));
    Navigator.pop(context);
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
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Padding(
                        padding:
                        const EdgeInsets.only(right: AppSizes.size4),
                        child: NameAvatar(
                          data: state.usernameInitials,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(state.when<String>(
                            details: (user) => user.username,
                          ),
                          style: context.textTheme.titleMedium!.copyWith(

                          ),)
                          // InkWell(
                          //   onTap: () {
                          //     showModalBottomSheet(
                          //       context: context,
                          //       builder: (BuildContext context) {
                          //         return PostPrivacy(
                          //           onPrivacySelected: (selected) {
                          //             setState(() {
                          //               selectedPrivacy = selected;
                          //             });
                          //           },
                          //         );
                          //       },
                          //     );
                          //   },
                          //   child: Row(
                          //     children: [
                          //       Text(
                          //         selectedPrivacy,
                          //         style: context.textTheme.bodySmall!
                          //             .copyWith(
                          //                 color: context
                          //                     .colorScheme.primary),
                          //       ),
                          //       const Icon(Icons.arrow_drop_down_sharp),
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                    ],
                  );

                }),
            const SizedBox(height: 10,),
            SizedBox(
              height: _imageFileList!.isEmpty ? context.viewSize.height*.60 : context.viewSize.height*.50,
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

            if (_imageFileList!.isNotEmpty || _videoFileList.isNotEmpty)
              Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                trackVisibility: true,
                radius: const Radius.circular(AppConstants.borderRadius),
                thickness: 5,
                interactive: true,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _imageFileList!.isNotEmpty
                          ? _buildImageGrid()
                          :  const SizedBox(),

                      videoFile!=null
                          ? _buildVideoGrid()
                          : const SizedBox(),
                    ],
                  ),
                ),)


          ],
        ).withContentPadded,
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Expanded(child: AddMediaToPost(
              onVideoTap: ()async {_selectVideo(context);},
              onImageTap: _selectImages,

            ),),
            Align(alignment: Alignment.centerLeft,
              child: IconButton(
                  onPressed: _buildColorPicker,
                  icon: Image.asset(AppImages.colorPickerIcon)),),
            const SizedBox(height: 12),

          ],
        ),
        AppElevatedButton(title: 'Post', onPressed: _onPost)

      ],
    ).withContentPadded;
  }

  AppVideoPlayer _buildVideoAvailable(XFile videoFile) {
    return AppVideoPlayer.file(
      videoFile.path,
    );
  }

  Widget _buildImageGrid() {
    return SizedBox(
        height: context.viewSize.height * 0.12,
        width: context.viewSize.width,

        child:GridView.builder(
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
        ));
  }
  Widget _buildVideoGrid() {
    return SizedBox(
        height: context.viewSize.height * 0.12,
        width: context.viewSize.width,

        child:GridView.builder(
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: context.viewSize.height * .15,
          crossAxisCount: 1,
          mainAxisSpacing: AppSizes.size10),
      itemCount: _videoFileList.length,
      itemBuilder: (context, index) {
        final videoFile = _videoFileList[index];
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
              child: AppVideoPlayer.file(videoFile!.path)
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
        ));
  }


  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFileList = [];
  final List<XFile?> _videoFileList = [];
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

  void _selectVideos() async {
    final XFile? selectedVideo = await _picker.pickVideo(
        source: ImageSource.gallery,
    maxDuration: AppConstants.vehicleVideoDuration);

    if (selectedVideo !=null) {
      _videoFileList.addAll(selectedVideo as Iterable<XFile>);
      debugPrint("Image List Length : ${_imageFileList!.length}");
    }
    setState(() {});
  }

  XFile? videoFile;

  void _selectVideo(BuildContext context) async {
    try {
      final XFile? selectedVideo = await _picker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: AppConstants.vehicleVideoDuration,
      );

      if (selectedVideo != null) {
        final compressedVideo = await _compressSelectedVideo(selectedVideo);
        int fileSizeInBytes = await compressedVideo.length();

        if (fileSizeInBytes <= AppConstants.maximumVideoFileSizeMB * 1024 * 1024) {
          setState(() {
            videoFile = XFile(compressedVideo.path);
          });
        } else {
          if (mounted) {
            context.showSnackBar('Video Size Error', BarType.error);
          }
        }
      }
    } on PlatformException catch (e) {
      if (mounted) {
        context.showSnackBar(e.message);
      }
    }
  }

  Future<File> _compressSelectedVideo(XFile file) async {
    context
        .read<LoadingCubit>()
        .loading(message: 'Processing Video');
    final response = await videoCompressor(file.path);
    if (mounted) {
      context.read<LoadingCubit>().loaded();
    }

    return response ?? File(file.path);
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
