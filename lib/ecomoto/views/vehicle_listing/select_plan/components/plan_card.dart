part of '../select_plan_view.dart';

class CustomPlanCard extends StatelessWidget {
  final String name;
  final double price;
  final bool isPopular;
  final List<String> features;

  const CustomPlanCard({
    Key? key,
    required this.name,
    required this.price,
    required this.isPopular,
    required this.features,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: context.textTheme.titleMedium,
                    ),
                    if (isPopular)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.60, vertical: 2.87),
                        decoration: ShapeDecoration(
                          color: AppColors.popularPlanColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                AppConstants.borderRadius),
                          ),
                        ),
                        child: const Text("Popular "),
                      ),
                  ],
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${AppConstants.appCurrency}$price',
                        style: context.textTheme.headlineMedium?.copyWith(
                          color: context.colorScheme.onBackground,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: " per month",
                        style: context.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w400, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Basic feature for up to 10 users",
                  style: context.textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.w400, fontSize: 13),
                ),
                const SizedBox(height: 15),
                AppElevatedButton(
                  title: "Select Plan",
                  borderRadius: BorderRadius.circular(5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 9),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "FEATURES",
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Everything in ',
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: 'Starter',
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: ' plus....',
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ...features
                    .map(
                      (feature) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Image.asset(
                              AppImages.roundedCheckIcon,
                              scale: 1.5,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                feature,
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                const SizedBox(height: 20),
              ],
            ),
          )
        ],
      ),
    );
  }
}
