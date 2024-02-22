import 'package:auto_size_text/auto_size_text.dart';
import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/cubits/user_cubit/user_cubit.dart';
import 'package:emr_005/ecomoto/cubit/trips_cubit/trip_model.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/menu/app_popup_menu.dart';
import 'package:emr_005/ui/components/widgets/cached_image.dart';
import 'package:emr_005/ui/components/widgets/shimmer.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:emr_005/utils/get_initials.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../buttons/elevated_button.dart';

class TripCard extends StatelessWidget {
  const TripCard({
    super.key,
    required this.tripDetails,
  });

  final Trip tripDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.viewPaddingHorizontal,
          vertical: AppConstants.viewPaddingVertical),
      width: double.infinity,
      height: context.viewSize.height * .41,
      child: Column(
        children: [
          _buildTripIdOptions(context),
          const SizedBox(
            height: AppSizes.size10,
          ),
          const Divider(),
          const SizedBox(
            height: AppSizes.size10,
          ),
          _buildLessorDetails(context).withHorViewPadding,
          const SizedBox(
            height: AppSizes.size10,
          ),
          _buildTripVehicleImageDetails(context),
          const SizedBox(
            height: AppSizes.size10,
          ),
          const Divider(),
          const SizedBox(
            height: AppSizes.size10,
          ),
          _buildTripStatus(context).withHorViewPadding
        ],
      ),
    );
  }

  Row _buildTripStatus(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.max, children: [
      Expanded(
          child: AutoSizeText(
              "${tripDetails.carDetails.make} ${tripDetails.carDetails.model}")),
      Container(
        decoration: BoxDecoration(
            color: tripDetails.rentalStatus != null &&
                    tripDetails.rentalStatus == RentalStatus.active
                ? AppColors.rentActiveColor
                : AppColors.rentCompletedColorLight,
            borderRadius:
                BorderRadius.circular(AppConstants.borderRadiusSmall)),
        padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.size10, vertical: AppSizes.size6),
        child: Text(
          (tripDetails.rentalStatus?.value ?? "N/A").toString(),
          style: context.textTheme.bodySmall?.copyWith(
            color: tripDetails.rentalStatus != null &&
                    tripDetails.rentalStatus == RentalStatus.active
                ? AppColors.rentActiveColor
                : AppColors.rentCompletedColor,
          ),
        ),
      ),
    ]);
  }

  Expanded _buildTripVehicleImageDetails(BuildContext context) {
    return Expanded(
        child: Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            child: (tripDetails.carDetails.carImages.isNotEmpty)
                ? AppCachedImage(
                    imageUrl: (tripDetails.carDetails.carImages..shuffle())
                        .first['imageUrl'],
                    withPinata: true,
                  )
                : Image.asset(
                    AppImages.noVehicleImage,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        const SizedBox(
          width: AppConstants.viewPaddingHorizontal,
        ),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.lightGreyColor),
              borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              {
                'title': 'Hours',
                'data': '160',
              },
              {
                'title': 'Hours',
                'data': '160',
              }
            ]
                .map((e) => Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(left: AppSizes.size10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                            child: AutoSizeText(
                              "160",
                              style: context.textTheme.titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: AutoSizeText(
                              "Hours",
                              maxLines: 1,
                              style: context.textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    )))
                .toList(),
          ),
        ))
      ],
    ).withHorViewPadding);
  }

  Container _buildLessorDetails(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.size6,
        horizontal: AppSizes.size6,
      ),
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              side: const BorderSide(color: AppColors.lightGreyColor),
              borderRadius: BorderRadius.circular(AppConstants.borderRadius))),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: context.colorScheme.secondary,
            radius: 17,
            child: Text(getInitials(tripDetails.lessor?['username'])),
          ),
          const SizedBox(
            width: AppSizes.size10,
          ),
          Flexible(
              child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: AutoSizeText(
                  (tripDetails.lessor?['firstName'] != null
                          ? (tripDetails.lessor?['firstName'] +
                              ' ' +
                              (tripDetails.lessor?['lastName'] ?? ""))
                          : tripDetails.lessor?['email']) ??
                      "",
                  maxLines: 1,
                ),
              ),
              SizedBox(
                  width: double.infinity,
                  child: AutoSizeText(
                    "4.8 Rating",
                    style: context.textTheme.bodySmall,
                    maxLines: 1,
                  )),
            ],
          ))
        ],
      ),
    );
  }

  Row _buildTripIdOptions(BuildContext context) {
    final options = tripDetails.rentalStatus != null &&
            tripDetails.rentalStatus == RentalStatus.active
        ? [
            ('end_rent', 'End Rent', Colors.red),
            ('edit_rent', 'Edit Rent', null),
            ('download_invoice', 'Download Invoice', null),
            ('share_vehicle', 'Share Vehicle', null),
            ('share_trips', 'Share Trips', null),
            ('message_lessor', 'Message Lessor', null),
            ('message_ecomoto', 'Message Ecomoto', null)
          ]
        : [
            ('end_rent', 'End Rent', Colors.red),
            ('download_invoice', 'Download Invoice', null),
            ('share_vehicle', 'Share Vehicle', null),
            ('share_trips', 'Share Trips', null)
          ];

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Text("#${tripDetails.id}")),
        AppPopUpMenu(
            options: options,
            onSelected: (value) async {
              if (value == "end_rent") {
                _CancelRide(
                  tripDetails: tripDetails,
                ).asDialog(context);
              }
              if (value == "message_lessor") {
                print(tripDetails.lessor); //lessor id
                print(context.read<UserCubit>().state.userID); //Lessee id
                print(tripDetails.id); //Rental Id
                // context.read<MessagesCubit>().loadMessages(context.read<UserCubit>().state.userID, tripDetails.id);
                await AppRouter.router.push(EcomotoRoutes.ecomotoMessageChat,
                    extra: [
                      context.read<UserCubit>().state.userID,
                      tripDetails.lessor!["id"]
                    ]);
                /*if (context.mounted) {
                context.pop();
              }*/
                //TODO:navigate to the chat screen
              }

              if (value == "message_ecomoto") {
                //TODO:navigate to the chat screen
              }
            })
      ],
    );
  }

  static Widget get shimmer {
    return AppShimmer(
      child: TripCard(
        tripDetails: Trip.dummy(),
      ),
    );
  }
}

class _CancelRide extends StatelessWidget {
  final Trip tripDetails;
  const _CancelRide({required this.tripDetails});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.viewPaddingHorizontal),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 330,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: AppSizes.size4,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Expanded(
                    child: AutoSizeText(
                  "Are you sure you want to cancel",
                  textAlign: TextAlign.center,
                )),
                IconButton(
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.close))
              ],
            ),
            const Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(AppConstants.borderRadius),
                    child: (tripDetails.carDetails.carImages.isNotEmpty)
                        ? AppCachedImage(
                            imageUrl: (tripDetails.carDetails.carImages)
                                .first['imageUrl'],
                            withPinata: true,
                          )
                        : Image.asset(
                            AppImages.noVehicleImage,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(
                  width: AppSizes.size20,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AutoSizeText(
                        tripDetails.carDetails.make,
                        maxLines: 1,
                        style: context.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: AppSizes.size4,
                      ),
                      ...[
                        {"title": "Booking ID", "data": tripDetails.id},
                        {"title": "Booking ID", "data": "sxxxxxxxx"},
                      ]
                          .map((e) => Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                      child: AutoSizeText(
                                    e['title'] ?? "N/A",
                                    style: context.textTheme.bodySmall,
                                  )),
                                  Expanded(
                                      child: AutoSizeText(
                                    e['data'] ?? "N/A",
                                    maxLines: 1,
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ))
                                ],
                              ))
                          .toList()
                    ],
                  ),
                )
              ],
            ).withHorViewPadding,
            const Spacer(),
            const Divider(),
            Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [("Go Back", () {}, false), ("End", () {}, true)]
                        .map(
                          (e) => Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: e.$3 ? 0 : AppSizes.size10,
                                  left: !e.$3 ? 0 : AppSizes.size10),
                              child: AppElevatedButton(
                                padding: EdgeInsets.zero,
                                titleColor:
                                    e.$3 ? null : context.colorScheme.primary,
                                borderColor: context.colorScheme.primary,
                                backgroundColor:
                                    e.$3 ? null : context.colorScheme.onPrimary,
                                title: e.$1,
                                onPressed: e.$2,
                              ),
                            ),
                          ),
                        )
                        .toList())
                .withHorViewPadding,
            const SizedBox(
              height: AppSizes.size4,
            ),
          ],
        ),
      ),
    );
  }
}
