import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/ui/components/headers_footers/ecobook_header.dart';
import 'package:flutter/material.dart';

class EcobookWrapper extends StatelessWidget {
  final Widget? body;
  const EcobookWrapper({super.key, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const EcobookHeader(),
      ),
      body: body,
    );
  }
}
