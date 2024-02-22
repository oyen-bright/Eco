import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/ui/components/inputs/text_field_input.dart';
import 'package:flutter/material.dart';

import '../../../../../../themes/sizes.dart';

class CommunityDescForm extends StatefulWidget {
  final TextEditingController descController;
    const CommunityDescForm({super.key, required this.descController});

  @override
  CommunityDescFormState createState() => CommunityDescFormState();


}

class CommunityDescFormState extends State<CommunityDescForm> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
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
        Text('Description',
          style: context.textTheme.titleMedium!.copyWith(
              fontSize: 20
          ),),

        const SizedBox(height: AppSizes.size6,),

        SingleChildScrollView(
          controller: scrollController,
          scrollDirection: Axis.vertical,
          child: Scrollbar
            (
              controller: scrollController,
              thumbVisibility: true,
              child: AppTextField(
                controller: widget.descController,
                maxLines: 8,
                hintText: 'Community Description',
              )),
        )
      ],
    );
  }

}