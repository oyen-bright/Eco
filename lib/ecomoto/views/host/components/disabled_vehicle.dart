part of '../host_view.dart';

class DisabledVehicles extends StatelessWidget {
  const DisabledVehicles({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyState(
      imageAsset: AppImages.noDisabledVehicles,
      prompt: Strings.disabledVehicleEmptyStatePrompt,
    );
  }
}
