// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_model.dart';
import 'package:emr_005/ecomoto/views/vehicle_rental/models/rental_input_data.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/buttons/elevated_button_with_icon.dart';
import 'package:emr_005/ui/components/widgets/elevated_container.dart';
import 'package:flutter/material.dart';

class RentalPriceCard extends StatelessWidget {
  final Vehicle vehicle;
  final VehicleRentalModel rentalData;
  final void Function()? onPressed;
  final String? buttonTitle;

  const RentalPriceCard({
    Key? key,
    required this.vehicle,
    required this.rentalData,
    this.onPressed,
    this.buttonTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildPriceInfo(context),
            const Divider(),
            const SizedBox(
              height: AppSizes.size10,
            ),
            _buildProceedButton(context)
          ],
        ),
      ),
    );
  }

  AppElevatedButtonWithIcon _buildProceedButton(BuildContext context) {
    return AppElevatedButtonWithIcon(
      title: buttonTitle,
      navigateForward: true,
      onPressed: onPressed,
    );
  }

  Widget _buildPriceInfo(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: rentalData.amountToPayNotifier,
      builder: (BuildContext context, String? value, Widget? child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AutoSizeText(
                    vehicle.make,
                    style: context.textTheme.titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  AutoSizeText(
                    '\$${vehicle.pricePerHour}/Day x ${rentalData.rentalDays} Day(s)',
                    style: context.textTheme.titleSmall!.copyWith(
                      color: AppColors.primaryLight,
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              child: AutoSizeText(
                '\$${rentalData.amountToPay}',
                maxLines: 1,
                textAlign: TextAlign.right,
                style: context.textTheme.titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            )
          ],
        );
      },
    );
  }
}
