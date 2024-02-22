import 'dart:io';

import 'package:emr_005/ecobook/bloc/feed/feed_model.dart';
import 'package:emr_005/ecobook/views/ecobook_feed/components/edit_post/components/edit_post_header.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../config/app_constants.dart';
import '../../../../../themes/sizes.dart';
import '../../../../../ui/components/buttons/elevated_button.dart';
import '../../../../bloc/feed/feed_bloc.dart';
import '../../../../models/post_model.dart';
import '../create_post/create_post_view.dart';

class EditPostView extends StatefulWidget {
  final FeedPost feedPost;
  const EditPostView({super.key, required this.feedPost});

  @override
  State<EditPostView> createState() => EditPostViewState();
}

class EditPostViewState extends State<EditPostView> {
  late final TextEditingController _contentController;
  List<String> existingImages = [];
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollbarController = ScrollController();

  Color selectedColorFromPicker = Colors.transparent;

  List<String> imagesCid = [];
  List<String> videoCid = [];
  final postInputData = PostModel();

  @override
  void initState() {
    super.initState();
    existingImages = widget.feedPost.imageUrl!;
    _contentController = TextEditingController(text: widget.feedPost.content);
  }

  void _onEdit() async {
    context.removeFocus;

    final response =
        await context.read<FeedBloc>().uploadMedia(imageFiles: _imageFileList);

    setState(() {
      imagesCid = response.imageCids as List<String>;
      videoCid = response.imageCids as List<String>;
    });

    List<String> finalImages = [...existingImages, ...imagesCid];
    postInputData.content = _contentController.text;
    postInputData.imageUrl = finalImages;
    postInputData.videoUrl = videoCid;

    _performEvent();
  }

  void _performEvent() {
    context.read<FeedBloc>().add(FeedEvent.editPost(
        postModel: postInputData, postId: widget.feedPost.id!));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        EditPostHeader(feedPost: widget.feedPost),
        Expanded(
            child: Column(
          children: [
            // ConstrainedBox(
            //   constraints:
            //   BoxConstraints(maxHeight: _imageFileList!.isNotEmpty ? context.viewSize.height * .30 : context.viewSize.height * .30),
            //   child: Scrollbar(
            //     trackVisibility: true,
            //     radius: const Radius.circular(AppConstants.borderRadius),
            //     controller: _scrollbarController,
            //     interactive: true,
            //     thickness: 5,
            //     thumbVisibility: true,
            //     child: SingleChildScrollView(
            //       controller: _scrollbarController,
            //       child: TextFormField(
            //         controller: _contentController,
            //         decoration: const InputDecoration(
            //           contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
            //           border: InputBorder.none,
            //         ),
            //         keyboardType: TextInputType.multiline,
            //         maxLines: null,
            //         textInputAction: TextInputAction.newline,
            //       ),
            //     ),
            //   ),
            // ),

            SizedBox(
              height: (_imageFileList == null || _imageFileList!.isEmpty) &&
                      (widget.feedPost.imageUrl == null ||
                          widget.feedPost.imageUrl!.isEmpty)
                  ? context.viewSize.height * 0.62
                  : (_imageFileList != null && _imageFileList!.isNotEmpty) &&
                          (widget.feedPost.imageUrl != null &&
                              widget.feedPost.imageUrl!.isNotEmpty)
                      ? context.viewSize.height * 0.35
                      : context.viewSize.height * 0.48,
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

            existingImages.isNotEmpty ? _buildImageGrid() : const SizedBox(),

            _imageFileList!.isNotEmpty
                ? _buildNewImageGrid()
                : const SizedBox(),
          ],
        )),
        AddMediaToPost(onVideoTap: () {}, onImageTap: _selectImages),
        const SizedBox(
          height: 10,
        ),
        AppElevatedButton(title: 'Save Changes', onPressed: _onEdit)
      ],
    ).withHorViewPadding;
  }

  Widget _buildImageGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Existing Images :'),
        SizedBox(
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
                itemCount: existingImages.length,
                itemBuilder: (context, index) {
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: context.colorScheme.onBackground
                                .withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Image.network(
                          "https://gateway.pinata.cloud/ipfs/${existingImages[index]}",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: CircleAvatar(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              context.colorScheme.error.withOpacity(0.9),
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
                              _removeImage(index);
                              print(widget.feedPost.imageUrl);
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ))
      ],
    );
  }

  Widget _buildNewImageGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Additional Images :'),
        SizedBox(
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
                            color: context.colorScheme.onBackground
                                .withOpacity(0.3),
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
                              _removeSelectedImages();
                              _toggleSelection(index);
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ))
      ],
    );
  }

  void _selectImages() async {
    final List<XFile> selectedImages = await _picker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      _imageFileList?.addAll(selectedImages);
      debugPrint("Image List Length : ${_imageFileList!.length}");
    }
    setState(() {});
  }

  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFileList = [];
  final Set<int> _selectedIndices = <int>{};

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

  void _toggleSelection(int index) {
    setState(() {
      if (_selectedIndices.contains(index)) {
        _selectedIndices.remove(index);
      } else {
        _selectedIndices.add(index);
      }
    });
  }

  void _removeImage(int index) {
    setState(() {
      existingImages.removeAt(index);
    });
  }
}
