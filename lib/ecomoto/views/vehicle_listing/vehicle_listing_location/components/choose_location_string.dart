part of '../listing_location_view.dart';

class ChooseLocationString extends StatelessWidget {
  final String addressText;
  const ChooseLocationString({super.key, required this.addressText});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: AppSizes.size45,
      width: AppSizes.size300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          border: Border.all(
            color: AppColors.primaryColor,
          ),
          color: AppColors.scaffoldBackgroundColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: AppSizes.size40,
              child: Image.asset(AppImages.chooseLocationImage,
                  height: AppSizes.size22, width: AppSizes.size22)),
          SizedBox(
              width: AppSizes.size200 + AppSizes.size60,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(addressText,
                    style: context.textTheme.bodyLarge
                        ?.copyWith(color: AppColors.primaryColor)),
              ))
        ],
      ),
    );
  }
}
