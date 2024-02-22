import 'dart:io';

import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/ui/components/headers_footers/logo_header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthViewWrapper extends StatelessWidget {
  final Widget body;
  final bool showCancelButton;
  const AuthViewWrapper(
      {super.key, required this.body, this.showCancelButton = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        titleSpacing: 0,
        actions: !showCancelButton
            ? null
            : [
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text('cancel'),
                ),
                const SizedBox(
                  width: 10,
                )
              ],
        title: const LogoHeader(),
      ),
      body: Platform.isIOS ? body : body,
    );
  }
}
