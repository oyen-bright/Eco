part of '../trips_view.dart';

class NoTrips extends StatelessWidget {
  final String title;
  final String subtitle;
  const NoTrips({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    //TODO: pull down to refresh
    return OverflowBox(
      //TODO:fix overflow issue here
      // maxHeight: 00,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // const Spacer(),
          Image.asset(
            AppImages.vehicleOnboardingImage,
            scale: 5,
          ),
          const SizedBox(height: AppSizes.size24),
          SizedBox(
            width: double.infinity,
            child: Text(
              title,
              style: AppTextStyles.emptyStateTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              subtitle,
              style: context.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),

          // const Spacer(
          //   flex: 3,
          // ),
          // AppElevatedButton(
          //   title: Strings.findACar,
          //   onPressed: () => context.go(EcomotoRoutes.homeAllVehicles),
          // ),
          // const SizedBox(height: AppSizes.size24),
        ],
      ),
    );
  }
}
