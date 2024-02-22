import 'package:emr_005/ecobook/models/create_community.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CommunityHeaderImage extends StatefulWidget {
    final CommunityInput communityInput;
    const CommunityHeaderImage({Key? key,  required this.communityInput}) : super(key: key);

  @override
  CommunityHeaderImageState createState() => CommunityHeaderImageState();
}

class CommunityHeaderImageState extends State<CommunityHeaderImage> {

   XFile? image;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
    InkWell(
      borderRadius: BorderRadius.circular(context.viewSize.width*.15),
      onTap: ()async{
      image ??= await _showActionSheet(context);
        setState(() {

        });
      },
      child: Container(
          height: context.viewSize.width*.30,
          width: context.viewSize.width*.30,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: context.colorScheme.primary)
          ),
          child: ClipOval(
              child: image !=null
                  ? Image.file(
                File(image!.path),
                fit: BoxFit.cover,


              )
                  : Image.asset(AppImages.uploadCommunityImage,
              )
          )
      ),
    ),
        if (image != null)
          Positioned(
            bottom: 0,
            right: 5,
            child: InkWell(
              borderRadius: BorderRadius.circular(12.5),
              child: Image.asset(
                AppImages.editImage,
                height: 25,
                width: 25,
              ),
              onTap: () async {
                final tempImage = await _showActionSheet(context);
                if (tempImage != null) {
                  setState(() {
                    image = tempImage;
                  });
                }
              },
            ),
          ),

      ],
    );
  }

  Future<XFile?> _showActionSheet(BuildContext context) {
    if (Platform.isAndroid) {
      return showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Column
              (
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: const Text('Photo Gallery'),
                  onTap: () async {
                    final res = await _handleGallerySelection();
                    if (context.mounted) {
                      Navigator.pop(context, res);
                    }
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text('Camera'),
                  onTap: () async {
                    final res = await _handleCameraSelection();
                    if (context.mounted) {
                      Navigator.pop(context, res);
                    }
                  },
                ),
              ],
            ).withViewPadding,
          );
        },
      );
    } else {
      return showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            actions: <Widget>[
              CupertinoActionSheetAction(
                onPressed: () async {
                  final res = await _handleGallerySelection();
                  if (context.mounted) {
                    Navigator.pop(context, res);
                  }
                },
                child: const Text('Photo Gallery'),
              ),
              CupertinoActionSheetAction(
                onPressed: () async {
                  final res = await _handleCameraSelection();
                  if (context.mounted) {
                    Navigator.pop(context, res);
                  }
                },
                child: const Text('Camera'),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context); // Close the action sheet
              },
              child: const Text('Cancel'),
            ),
          );
        },
      );
    }
  }

  Future<XFile?> _handleGallerySelection() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      widget.communityInput.imageFile = image;
      print(widget.communityInput.imageFile);
    });

    return image;
  }

  Future<XFile?> _handleCameraSelection() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      widget.communityInput.imageFile = image;
      print(widget.communityInput.imageFile);
    });

    return image;
  }

   Image _buildImageAvailable(XFile imageFile) {
     return Image.file(
       File(imageFile.path),
       fit: BoxFit.cover,
     );
   }
}
