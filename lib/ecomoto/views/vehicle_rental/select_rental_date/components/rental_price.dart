part of rental_date;

class TotalRentalPrice extends StatelessWidget {
  final Vehicle vehicle;
  final bool Function() validate;
  final VehicleRentalModel rentalData;

  const TotalRentalPrice({
    super.key,
    required this.validate,
    required this.vehicle,
    required this.rentalData,
  });

  @override
  Widget build(BuildContext context) {
    return RentalPriceCard(
        vehicle: vehicle,
        rentalData: rentalData,
        onPressed: () {
          if (validate()) {
            ConfirmVehicleCheckout(
              vehicle: vehicle,
              rentalData: rentalData,
            ).asBottomSheet(
              context,
              isDismissible: false,
              enableDrag: false,
              backgroundColor: context.theme.scaffoldBackgroundColor,
            );
          }
        });
  }
}
