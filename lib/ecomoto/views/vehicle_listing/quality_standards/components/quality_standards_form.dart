part of '../quality_standards_view.dart';

class QualityStandardsForm extends StatefulWidget {
  final VehicleModel vehicleInputData;
  const QualityStandardsForm({
    super.key,
    required this.vehicleInputData,
  });

  @override
  State<QualityStandardsForm> createState() => _QualityStandardsFormState();
}

class _QualityStandardsFormState extends State<QualityStandardsForm> {
  bool isMaintenanceSelected = false;
  bool isOwnerSelected = false;
  bool isUpToDateSelected = false;
  bool isAccident = false;

  bool isMaintenanceSelectedShowError = false;
  bool isOwnerSelectedShowError = false;
  bool isUpToDateSelectedShowError = false;

  void _onProceed() {
    if (_validate()) {
      final vehicleInputData = widget.vehicleInputData;
      vehicleInputData.isAccident = isAccident;
      vehicleInputData.isRegisteredOwner = isOwnerSelected;
      vehicleInputData.isUpToDate = isUpToDateSelected;
      vehicleInputData.isVehicleMaintenance = isMaintenanceSelected;

      AppRouter.router.push(EcomotoRoutes.vehicleListingSelectPrice,
          extra: vehicleInputData);
    }
  }

  bool _validate() {
    if (!isMaintenanceSelected) {
      isMaintenanceSelectedShowError = true;
    } else {
      isMaintenanceSelectedShowError = false;
    }
    if (!isOwnerSelected) {
      isOwnerSelectedShowError = true;
    } else {
      isOwnerSelectedShowError = false;
    }
    if (!isUpToDateSelected) {
      isUpToDateSelectedShowError = true;
    } else {
      isUpToDateSelectedShowError = false;
    }
    setState(() {});
    if (isMaintenanceSelected && isOwnerSelected && isUpToDateSelected) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    QualityFormWidget(
                      maintenanceToggle: (
                        AppToggleButton(
                          isSelected: isMaintenanceSelected,
                          onToggle: (value) {
                            setState(() {
                              isMaintenanceSelected = !isMaintenanceSelected;
                            });
                          },
                        ),
                        isMaintenanceSelectedShowError
                      ),
                      upToDateToggle: (
                        AppToggleButton(
                          isSelected: isUpToDateSelected,
                          onToggle: (value) {
                            setState(() {
                              isUpToDateSelected = !isUpToDateSelected;
                            });
                          },
                        ),
                        isUpToDateSelectedShowError
                      ),
                      registeredOwnerToggle: (
                        AppToggleButton(
                          isSelected: isOwnerSelected,
                          onToggle: (value) {
                            setState(() {
                              isOwnerSelected = !isOwnerSelected;
                            });
                          },
                        ),
                        isOwnerSelectedShowError
                      ),
                      accidentToggle: (
                        AppToggleButton(
                          isSelected: isAccident,
                          onToggle: (value) {
                            setState(() {
                              isAccident = !isAccident;
                            });
                          },
                        ),
                        false
                      ),
                    ),
                  ]),
            ),
          ),
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
    );
  }
}
