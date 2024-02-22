import 'package:emr_005/ecobook/bloc/community/community_bloc.dart';
import 'package:emr_005/ecobook/models/create_community.dart';
import 'package:emr_005/ecobook/views/community/create_community/general_details/components/community_description_form.dart';
import 'package:emr_005/ecobook/views/community/create_community/general_details/components/community_header_image.dart';
import 'package:emr_005/ecobook/views/community/create_community/general_details/components/community_name_form.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../bloc/feed/feed_bloc.dart';

class CommunityGeneralDetailsView extends StatelessWidget {
  final CommunityInput communityInputData;
  const CommunityGeneralDetailsView({super.key, required this.communityInputData});



  @override
  Widget build(BuildContext context) {

    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController nameController = TextEditingController();




    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Community'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  CommunityHeaderImage(communityInput: communityInputData),
                  CommunityNameForm(nameController: nameController),
                  const Divider(thickness: .2,),
                  CommunityDescForm(descController: descriptionController)
                ],
              ),
            )),
            AppElevatedButton(
              title: 'Create Community',
              onPressed: () {
                // _onCreate(context);

                communityInputData.name = nameController.text;
                communityInputData.description = descriptionController.text;

                onCreate(context);
                print(communityInputData.name);
                print(communityInputData.description);
                print(communityInputData.imageFile);
                // print(communityInputData.headerImage);
              }
            )
          ],
        ).withViewPadding,
      ),
    );
  }

  void performEvent(BuildContext context)  {
    context.read<CommunityBloc>().add(CommunityEvent.createCommunity(communityInput: communityInputData));
    Navigator.pop(context);
  }

  Future<void> onCreate(BuildContext context) async {
    context.removeFocus;

    final List<XFile> imageFile = [communityInputData.imageFile!];
    if (communityInputData.name !=null && communityInputData.description !=null) {
      final response = await context.read<FeedBloc>().uploadMedia(
          imageFiles: imageFile);

      print(response.imageCids);
      communityInputData.headerImage = response.imageCids.join().replaceAll('[', '').replaceAll(']', '');
      if (context.mounted)
      {      performEvent(context);
      }
    }

  }
}
