part of rental_payment;

class TotalRentalPricePayment extends StatelessWidget {
  final Vehicle vehicle;
  final VehicleRentalModel rentalData;
  const TotalRentalPricePayment(
      {super.key, required this.vehicle, required this.rentalData});

  @override
  Widget build(BuildContext context) {
    return RentalPriceCard(
      buttonTitle: Strings.proceedToPaymentText,
      vehicle: vehicle,
      rentalData: rentalData,
      onPressed: () async {
        // final response = await context
        //     .read<VehicleCubit>()
        //     .rentVehicle(vehicleData: rentalData);

        // rentalData.rentalId = response.rentalID;
        // response.error != null || response.rentalID == null
        //     ? context.mounted
        //         ? context.showSnackBar(response.error)
        //         : null
        //     : AppRouter.router.pushReplacement(
        //         EcomotoRoutes.vehicleRentalPaymentSuccessfulView,
        //         extra: [vehicle, rentalData],
        //       );

        rentalData.rentalId = "65cf624af7f2ee86cea1f3c1";

        AppRouter.router.pushReplacement(
          EcomotoRoutes.vehicleRentalPaymentSuccessfulView,
          extra: [vehicle, rentalData],
        );
      },
    );
  }
}
