part of '../listing_successful_view.dart';

class FormHeaderImage extends StatelessWidget {
  const FormHeaderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Image.asset(
        AppImages.vehicleListedSuccessImage,
        height: AppSizes.size200,
        width: AppSizes.size200,
      ),
    );
  }
}
