part of '../extra_features_view.dart';

class ExtraFeaturesForm extends StatefulWidget {
  final VehicleModel vehicleInputData;
  const ExtraFeaturesForm({
    super.key,
    required this.vehicleInputData,
  });

  @override
  State<ExtraFeaturesForm> createState() => _ExtraFeaturesFormState();
}

class _ExtraFeaturesFormState extends State<ExtraFeaturesForm> {
  final vehicleInputData = VehicleModel();
  List<String> selectedOptions = [];
  List<String> allOptions = [
    Strings.airConditionText,
    Strings.dogModeText,
    Strings.autoPilotText,
    Strings.powerCampText,
    Strings.flashChargingText,
    Strings.gpsText,
    Strings.sportCarText,
    Strings.bluetoothText
  ];

  Map<String, IconData> optionIcons = {
    Strings.airConditionText: Icons.ac_unit,
    Strings.dogModeText: Icons.pets,
    Strings.autoPilotText: Icons.auto_mode,
    Strings.powerCampText: Icons.solar_power,
    Strings.flashChargingText: Icons.flash_on,
    Strings.gpsText: Icons.gps_fixed,
    Strings.sportCarText: Icons.sports,
    Strings.bluetoothText: Icons.bluetooth
  };
  bool isSelected(String option) {
    return selectedOptions.contains(option);
  }

  void _onProceed() {
    if (_formKey.currentState!.validate()) {
      context.removeFocus;

      final vehicleInputData = widget.vehicleInputData;
      vehicleInputData.extraFeatures = selectedOptions;

      debugPrint('$selectedOptions');
      AppRouter.router.push(EcomotoRoutes.vehicleListingInsuranceInformation,
          extra: vehicleInputData);
    }
  }

  void _toggleOption(String option) {
    setState(() {
      if (isSelected(option)) {
        selectedOptions.remove(option);
      } else {
        selectedOptions.add(option);
      }
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
                child: Wrap(
              alignment: WrapAlignment.center,
              spacing: AppSizes.size12,
              children: allOptions.map((option) {
                return FilterChip(
                  padding: const EdgeInsets.all(
                    AppSizes.size4,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppConstants.borderRadiusSmall),
                    side: BorderSide(
                      color: isSelected(option)
                          ? context.colorScheme.onPrimary
                          : AppColors.lightPurple.withOpacity(0.4),
                    ),
                  ),
                  label: Text(option),
                  onSelected: (selected) {
                    _toggleOption(option);
                  },
                  selected: isSelected(option),
                  showCheckmark: false,
                  labelStyle: context.textTheme.bodySmall?.copyWith(
                    color: isSelected(option) ? Colors.white : Colors.black,
                  ),
                  backgroundColor: context.colorScheme.onPrimary,
                  selectedColor: context.colorScheme.primary,
                  avatar: Icon(optionIcons[option],
                      color: isSelected(option)
                          ? context.colorScheme.onPrimary
                          : const Color(0xFF5F4AE5)),
                );
              }).toList(),
            )),
            Row(
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
                    onPressed: _onProceed,
                    navigateForward: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
