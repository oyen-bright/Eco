part of rental_date;

class ConfirmVehicleCheckout extends StatefulWidget {
  final Vehicle vehicle;
  final VehicleRentalModel rentalData;

  const ConfirmVehicleCheckout(
      {Key? key, required this.vehicle, required this.rentalData})
      : super(key: key);
  @override
  ConfirmVehicleCheckoutState createState() => ConfirmVehicleCheckoutState();
}

class ConfirmVehicleCheckoutState extends State<ConfirmVehicleCheckout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.viewPaddingHorizontal,
          vertical: AppConstants.viewPaddingVertical),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            Strings.summaryText,
            style: context.textTheme.titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: AppSizes.size20,
          ),
          _buildDetails(context),
          const SizedBox(
            height: AppSizes.size10,
          ),
          const Divider(
            thickness: 0.2,
          ),
          const SizedBox(
            height: AppSizes.size10,
          ),
          _RentalCheckoutDialog(
            vehicle: widget.vehicle,
            rentalData: widget.rentalData,
          ),
          const SizedBox(
            height: AppSizes.size20,
          ),
          _buildButtons(context),
        ],
      ),
    );
  }

  SizedBox _buildDetails(BuildContext context) {
    DateTime? rentalStart = widget.rentalData.rentalStartDateTime;
    DateTime? rentalEnd = widget.rentalData.rentalEndDateTime;

    final dateFormat = DateFormat('dd MMM yyyy');
    final timeFormat = DateFormat('hh:mm a');

    final formattedStart = rentalStart == null
        ? ""
        : '${dateFormat.format(rentalStart)} ${timeFormat.format(rentalStart)}';
    final formattedEnd = rentalEnd == null
        ? ""
        : '${dateFormat.format(rentalEnd)} ${timeFormat.format(rentalEnd)}';

    return SizedBox(
      height: context.viewSize.height * .15,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: context.viewSize.height * .15,
            width: context.viewSize.width * .40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              child: widget.vehicle.carImages.isNotEmpty
                  ? AppCachedImage(
                      withPinata: true,
                      imageUrl: '${widget.vehicle.carImages[0]['imageUrl']}',
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      AppImages.noVehicleImage,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(
            width: AppSizes.size10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AutoSizeText(
                  widget.vehicle.make,
                  maxLines: 1,
                  style: context.textTheme.titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                AutoSizeText(
                  widget.vehicle.model,
                  maxLines: 1,
                  style: context.textTheme.titleSmall!.copyWith(fontSize: 14),
                ),
                const SizedBox(
                  height: 4,
                ),
                ...[
                  // (icon: Icons.location_on_outlined, data: locationName),
                  (icon: Icons.calendar_month, data: formattedStart),
                  (icon: Icons.time_to_leave, data: formattedEnd),
                ]
                    .map((e) => Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: [
                                Icon(
                                  e.icon,
                                  size: AppSizes.size18,
                                ),
                                const SizedBox(
                                  width: AppSizes.size4,
                                ),
                                Expanded(
                                  child: AutoSizeText(
                                    e.data,
                                    maxLines: 1,
                                    style: context.textTheme.titleSmall!
                                        .copyWith(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _buildButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: AppElevatedButton(
            title: Strings.editButtonText,
            titleColor: context.colorScheme.primary,
            borderColor: context.colorScheme.primary,
            backgroundColor: context.colorScheme.onPrimary,
            onPressed: () {
              context.pop();
            },
          ),
        ),
        const SizedBox(
          width: AppSizes.size6,
        ),
        Expanded(
          child: AppElevatedButton(
            onPressed: () async {
              await AppRouter.router.push(
                  EcomotoRoutes.vehicleRentalAgreementView,
                  extra: [widget.vehicle, widget.rentalData]);
              if (context.mounted) {
                context.pop();
              }
            },
            title: Strings.continueButtonText,
          ),
        ),
      ],
    );
  }
}

class _RentalCheckoutDialog extends StatelessWidget {
  final Vehicle vehicle;
  final VehicleRentalModel rentalData;

  const _RentalCheckoutDialog(
      {required this.vehicle, required this.rentalData});

  @override
  Widget build(BuildContext context) {
    const int driverInsuranceAmount = 100;
    final totalPrice =
        double.tryParse(rentalData.amountToPay)! + driverInsuranceAmount;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        color: context.colorScheme.secondary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeText(
            vehicle.make,
            style: context.textTheme.titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: AppSizes.size10,
          ),
          _checkoutRow(
              context: context,
              title: "${rentalData.rentalDays} days",
              data: rentalData.amountToPay),
          const SizedBox(
            height: AppSizes.size2,
          ),
          _checkoutRow(
              context: context,
              title: Strings.extraDriverInsText,
              data: '$driverInsuranceAmount'),
          const SizedBox(
            height: AppSizes.size4,
          ),
          DashedDivider(
            height: 1,
            color: context.theme.dividerTheme.color?.withOpacity(0.5) ??
                Colors.black,
            dashWidth: 10,
          ),
          const SizedBox(
            height: AppSizes.size4,
          ),
          _checkoutRow(
              context: context,
              title: Strings.totalPriceText,
              data: "$totalPrice"),
          const SizedBox(
            height: AppSizes.size4,
          ),
        ],
      ),
    );
  }

  Widget _checkoutRow({
    required BuildContext context,
    required String title,
    required String data,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: AutoSizeText(
            title,
            style: context.textTheme.titleSmall,
          ),
        ),
        Expanded(
          child: AutoSizeText('\$$data',
              textAlign: TextAlign.right,
              style: context.textTheme.titleMedium!
                  .copyWith(fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}
