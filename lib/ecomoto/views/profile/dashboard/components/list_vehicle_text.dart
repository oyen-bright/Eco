import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:flutter/material.dart';

class ListVehicleText extends StatelessWidget {
  const ListVehicleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConstants.contentPadding,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          "Listing your car is simple and usually takes about few mintues",
          textAlign: TextAlign.center,
          style: context.textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
