part of '../select_plan_view.dart';

class AvailablePlans extends StatelessWidget {
  final VehicleModel vehicleInputData;

  const AvailablePlans({super.key, required this.vehicleInputData});

  @override
  Widget build(BuildContext context) {
    final plans = [
      const CustomPlanCard(
        name: "Basic Plan",
        price: 10.0,
        isPopular: true,
        features: [
          "Access to basic Features",
          "Basic reporting and analytics",
          "Up to 10 individual users",
          "20GB individual data each user",
          "Basic chat and email support"
        ],
      ),
      const CustomPlanCard(
        name: "Basic Plan",
        price: 10.0,
        isPopular: true,
        features: [
          "Access to basic Features",
          "Basic reporting and analytics",
          "Up to 10 individual users",
          "20GB individual data each user",
          "Basic chat and email support"
        ],
      ),
      const CustomPlanCard(
        name: "Basic Plan",
        price: 10.0,
        isPopular: true,
        features: [
          "Access to basic Features",
          "Basic reporting and analytics",
          "Up to 10 individual users",
          "20GB individual data each user",
          "Basic chat and email support"
        ],
      ),
    ];
    return Stack(children: [
      Positioned.fill(
        child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 60),
            shrinkWrap: true,
            itemCount: plans.length,
            itemBuilder: (context, index) {
              return plans[index];
            }),
      ),
      Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: Row(
          children: [
            Expanded(
              child: AppElevatedButtonWithIcon(
                onPressed: () => context.pop(),
                navigateBackward: true,
              ),
            ),
            const SizedBox(
              width: AppSizes.size10,
            ),
            Expanded(
              child: AppElevatedButtonWithIcon(
                onPressed: () => AppRouter.router.push(
                    EcomotoRoutes.vehicleListingSelectImages,
                    extra: vehicleInputData),
                navigateForward: true,
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
