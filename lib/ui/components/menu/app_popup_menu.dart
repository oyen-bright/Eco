import 'package:emr_005/extensions/context.dart';
import 'package:flutter/material.dart';

// class _MorePopUpMenu extends StatelessWidget {
//   final Trip tripDetails;

//   const AppPopUpMenu(this.tripDetails);

//   @override
//   Widget build(BuildContext context) {
//     final options = tripDetails.rentalStatus != null &&
//             tripDetails.rentalStatus == RentalStatus.active
//         ? [
//             ('end_rent', 'End Rent', Colors.red),
//             ('edit_rent', 'Edit Rent', null),
//             ('download_invoice', 'Download Invoice', null),
//             ('share_vehicle', 'Share Vehicle', null),
//             ('share_trips', 'Share Trips', null),
//             ('message_lessor', 'Message Lessor', null),
//             ('message_ecomoto', 'Message Ecomoto', null)
//           ]
//         : [
//             ('end_rent', 'End Rent', Colors.red),
//             ('download_invoice', 'Download Invoice', null),
//             ('share_vehicle', 'Share Vehicle', null),
//             ('share_trips', 'Share Trips', null)
//           ];

//     return SizedBox(
//       height: 20,
//       child: PopupMenuButton<String>(
//         // constraints: BoxConstraints.tight(const Size.fromHeight(5)),
//         offset: const Offset(-5, 20),
//         padding: EdgeInsets.zero,
//         elevation: 1,
//         itemBuilder: (context) {
//           return options
//               .map(
//                 (e) => PopupMenuItem<String>(
//                   height: kMinInteractiveDimension - 5,
//                   value: e.$1,
//                   child: Text(
//                     e.$2,
//                     style: context.textTheme.labelLarge?.copyWith(color: e.$3),
//                   ),
//                 ),
//               )
//               .toList();
//         },
//         onSelected: (value) {
//           if (value == "end_rent") {
//             _CancelRide(
//               tripDetails: tripDetails,
//             ).asDialog(context);
//           }
//           if (value == "message_lessor") {
//             print(tripDetails.lessor); //lessor id
//             print(context.read<UserCubit>().state.userID); //Lessee id
//             print(tripDetails.id); //Rental Id
//             //TODO:navigate to the chat screen
//           }

//           if (value == "message_ecomoto") {
//             //TODO:navigate to the chat screen
//           }
//         },
//       ),
//     );
//   }
// }

class AppPopUpMenu extends StatelessWidget {
  final List<(String, String, MaterialColor?)> options;
  final Function(String)? onSelected;
  final bool isVertical;
  const AppPopUpMenu({
    super.key,
    this.isVertical = false,
    required this.options,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: PopupMenuButton<String>(
        position: PopupMenuPosition.under,
        icon: isVertical ? const Icon(Icons.more_vert) : null,
        offset: const Offset(-5, 10),
        padding: EdgeInsets.zero,
        elevation: 5,
        itemBuilder: (context) {
          return options
              .map(
                (option) => PopupMenuItem<String>(
                  height: kMinInteractiveDimension - 5,
                  value: option.$1,
                  child: Text(
                    option.$2,
                    style: context.textTheme.labelLarge
                        ?.copyWith(color: option.$3),
                  ),
                ),
              )
              .toList();
        },
        onSelected: onSelected,
      ),
    );
  }
}
