part of '../host_view.dart';

class EmptyState extends StatelessWidget {
  final String imageAsset;
  final String prompt;
  const EmptyState({super.key, required this.imageAsset, required this.prompt});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset(
            imageAsset,
            scale: 1.5,
          ),
          const SizedBox(height: AppSizes.size24),
          Text(
            prompt,
            style: AppTextStyles.emptyStateTextStyle,

            // style: context.textTheme.titleMedium!
            //     .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const Spacer(
            flex: 3,
          ),
        ],
      ),
    );
  }
}
