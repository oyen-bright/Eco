part of vehicle_details;

class VehicleDescription extends StatelessWidget {
  const VehicleDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            Strings.vehicleDescTitleText.toUpperCase(),
            style: const TextStyle(
              color: AppColors.lightPurple,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: AppSizes.size10),
          Text(
              '''Beautiful Tesla equipped with lots of new technologies for your family, friends and yourself! Enjoy Miami with a comfy and extravagant SUV. Blindspot warnings on the mirrors, navigation on a modern screen, Apple and Android Play Car, aux input, USB input, heated seats, and more! - Our cars do not smell like marijuana. GUARANTEED - Plenty of space in the interior, plenty of space in the trunk for baggage, etc. Drives beautifully and is easy to ride (automatic transmission). Our cars are treated with an ozone treatment between each rental to warranty and remove strong odors, bacteria, etc. - Use plus gas (the one in the middle of the fuel pump), please return at the same level it was received. During the duration of rental periods, any and all traffic and/or parking tickets, tolls as well as toll violations will be the responsibility of the renter. Thank you!''',
              style: context.textTheme.bodySmall!.copyWith()),
          const SizedBox(height: AppSizes.size10),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.lightPurple,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          Strings.vehicleDescTitleText.toUpperCase(),
                          style: const TextStyle(
                            color: AppColors.lightPurple,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        content: Text(
                          '''Beautiful Tesla equipped with lots of new technologies for your family, friends and yourself! Enjoy Miami with a comfy and extravagant SUV. Blindspot warnings on the mirrors, navigation on a modern screen, Apple and Android Play Car, aux input, USB input, heated seats, and more! - Our cars do not smell like marijuana. GUARANTEED - Plenty of space in the interior, plenty of space in the trunk for baggage, etc. Drives beautifully and is easy to ride (automatic transmission). Our cars are treated with an ozone treatment between each rental to warranty and remove strong odors, bacteria, etc. - Use plus gas (the one in the middle of the fuel pump), please return at the same level it was received. During the duration of rental periods, any and all traffic and/or parking tickets, tolls as well as toll violations will be the responsibility of the renter. Thank you!''',
                          style: context.textTheme.bodySmall!.copyWith(),
                        ),
                      );
                    });
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("See full description"),
                  SizedBox(width: 4),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSizes.size20),
        ],
      ),
    );
  }
}
