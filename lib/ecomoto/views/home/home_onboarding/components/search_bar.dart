import 'package:emr_005/config/app_constants.dart';
import 'package:flutter/material.dart';

import '../constants/strings.dart';

class RentalSearchBar extends StatelessWidget {
  const RentalSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5F7FA),
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
        child: const TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: Strings.searchBarHintText,
              prefixIcon: Icon(Icons.search)),
        ));
  }
}
