part of '../quality_standards_view.dart';

class QualityFormWidget extends StatelessWidget {
  final (Widget, bool showError) maintenanceToggle;
  final (Widget, bool showError) registeredOwnerToggle;
  final (Widget, bool showError) accidentToggle;
  final (Widget, bool showError) upToDateToggle;

  const QualityFormWidget(
      {super.key,
      required this.maintenanceToggle,
      required this.registeredOwnerToggle,
      required this.accidentToggle,
      required this.upToDateToggle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _toggleRow(context, upToDateToggle.$1, Strings.vehicleUpToDateText,
            upToDateToggle.$2),
        _toggleRow(context, registeredOwnerToggle.$1,
            Strings.registeredOwnerText, registeredOwnerToggle.$2),
        _toggleRow(context, maintenanceToggle.$1,
            Strings.vehicleHasMaintenanceText, maintenanceToggle.$2),
        _toggleRow(
            context, accidentToggle.$1, Strings.isVehicleAccidentText, false),
        Divider(
          height: 0.3,
          thickness: 0.3,
          color: context.colorScheme.onBackground,
        ),
      ],
    );
  }

  Widget _toggleRow(
      BuildContext context, Widget toggle, String toggleText, bool showError) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Divider(
          height: 0.3,
          thickness: 0.3,
          color: context.colorScheme.onBackground,
        ),
        const SizedBox(
          height: AppSizes.size10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: AppSizes.size45,
              width: AppSizes.size200 + AppSizes.size45,
              child: Text(
                toggleText,
                style: context.textTheme.titleMedium,
                textAlign: TextAlign.left,
              ),
            ),
            Transform.scale(
              scale: 0.85,
              child: toggle,
            )
          ],
        ),
        if (showError) ...{
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info,
                color: Colors.red,
                size: 17,
              ),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                  child: Text(
                Strings.errorMessage,
                style: context.textTheme.bodySmall?.copyWith(color: Colors.red),
              ))
            ],
          )
        },
        const SizedBox(
          height: AppSizes.size20,
        ),
      ],
    );
  }
}
