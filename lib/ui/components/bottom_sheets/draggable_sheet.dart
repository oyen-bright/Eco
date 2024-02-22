import 'package:flutter/material.dart';

class AppDraggableSheet extends StatelessWidget {
  final Widget child;
  final ScrollController? draggableController;


  const AppDraggableSheet({Key? key, required this.child, this.draggableController})

      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {

        final controller = scrollController ?? ScrollController();


        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: child,
        );
      },
    );
  }
}
