import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/inputs/text_field_input.dart';
import 'package:flutter/material.dart';


class CommunityNameForm extends StatefulWidget {
   final TextEditingController nameController;
   const CommunityNameForm({super.key, required this.nameController});

  @override
  CommunityNameFormState createState() => CommunityNameFormState();

  
}

class CommunityNameFormState extends State<CommunityNameForm> {

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const SizedBox(height: AppSizes.size12,),
        Text('Name',
          style: context.textTheme.titleMedium!.copyWith(
            fontSize: 20
          ),),

        const SizedBox(height: AppSizes.size6,),

        AppTextField(
          controller: widget.nameController,
          hintText: 'Community Name',
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
        ),

        const SizedBox(height: AppSizes.size12,),

      ],
    );
  }
  
}