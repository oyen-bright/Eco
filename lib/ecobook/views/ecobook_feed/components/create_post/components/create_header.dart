import 'package:emr_005/extensions/context.dart';
import 'package:flutter/material.dart';

class CreatePostHeader extends StatelessWidget {
  const CreatePostHeader({super.key});

  @override
  Widget build(BuildContext context) {
   return Column(
     children: [
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           const SizedBox(),
           Text(
             'Create',
             style: context.textTheme.titleLarge!.copyWith(
               color: context.colorScheme.onBackground,
             ),
           ),
           GestureDetector(
             onTap: () {
               Navigator.pop(context);
             },
             child: const Icon(Icons.close),
           ),
         ],
       ),
       Divider(color: context.colorScheme.onBackground),
     ],
   );
  }

}