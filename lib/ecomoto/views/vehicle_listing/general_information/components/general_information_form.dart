part of '../general_information_view.dart';

class GeneralInformationForm extends StatefulWidget {
  final VehicleModel vehicleInputData;

  const GeneralInformationForm({
    super.key,
    required this.vehicleInputData,
  });

  @override
  State<GeneralInformationForm> createState() => _GeneralInformationFormState();
}

class _GeneralInformationFormState extends State<GeneralInformationForm>
    with ValidationMixin {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _vinController;
  late final TextEditingController _brandController;
  late final TextEditingController _modelController;
  late final TextEditingController _modelYearController;
  late final TextEditingController _colorController;
  late final TextEditingController _numberOfSeatsController;
  late final TextEditingController _vehicleTypeController;
  late final TextEditingController _vehiclePlateNumberController;
  late final TextEditingController _mileagePerChargeController;
  late final TextEditingController _vehicleRegistrationController;

  @override
  void initState() {
    _vinController = TextEditingController();
    _vinController.text = widget.vehicleInputData.vin ?? "";
    _brandController = TextEditingController();
    _brandController.text = widget.vehicleInputData.brand ?? "";
    _modelYearController = TextEditingController();
    _modelYearController.text = widget.vehicleInputData.modelYear ?? "";
    _modelController = TextEditingController();
    _modelController.text = widget.vehicleInputData.model ?? "";
    _colorController = TextEditingController();
    _numberOfSeatsController = TextEditingController();
    _vehicleTypeController = TextEditingController();
    _vehiclePlateNumberController = TextEditingController();
    _mileagePerChargeController = TextEditingController();
    _vehicleRegistrationController = TextEditingController();
    _mileagePerChargeController.text =
        widget.vehicleInputData.mileagePerCharge?.toString() ?? "";

    super.initState();
  }

  @override
  void dispose() {
    _vinController.dispose();
    _brandController.dispose();
    _modelYearController.dispose();
    _modelController.dispose();
    _colorController.dispose();
    _numberOfSeatsController.dispose();
    _vehicleTypeController.dispose();
    _mileagePerChargeController.dispose();
    _vehiclePlateNumberController.dispose();
    _vehicleRegistrationController.dispose();
    super.dispose();
  }

  void _onProceed() {
    if (_formKey.currentState!.validate()) {
      context.removeFocus;
      widget.vehicleInputData.numberOfSeats =
          int.tryParse(_numberOfSeatsController.text);
      widget.vehicleInputData.color = _colorController.text;
      widget.vehicleInputData.capacity =
          int.tryParse(_numberOfSeatsController.text);
      widget.vehicleInputData.vehicleType = _vehicleTypeController.text;
      widget.vehicleInputData.vehicleRegistrationGoodThru =
          _vehicleRegistrationController.text;
      widget.vehicleInputData.vehiclePlateNumber =
          _vehiclePlateNumberController.text;

      AppRouter.router.push(EcomotoRoutes.vehicleListingExtraFeatures,
          extra: widget.vehicleInputData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: AppSizes.size12),
                AppTextField.withLabel(
                  textInputAction: TextInputAction.next,
                  validator: validateRequired,
                  labelText: Strings.vinLabelText,
                  readOnly: true,
                  hintText: Strings.vinHintText,
                  controller: _vinController,
                  backgroundColor: context.colorScheme.secondary,
                ),
                const SizedBox(height: AppSizes.size12),
                AppTextField.withLabel(
                  textInputAction: TextInputAction.next,
                  validator: validateRequired,
                  readOnly: true,
                  labelText: Strings.vehicleBrandLabelText,
                  hintText: Strings.vehicleBrandHintText,
                  controller: _brandController,
                  backgroundColor: context.colorScheme.secondary,
                ),
                const SizedBox(height: AppSizes.size12),
                AppTextField.withLabel(
                  textInputAction: TextInputAction.next,
                  validator: validateRequired,
                  readOnly: true,
                  labelText: Strings.modelLabelText,
                  hintText: Strings.modelHintText,
                  controller: _modelController,
                  backgroundColor: context.colorScheme.secondary,
                ),
                const SizedBox(height: AppSizes.size12),
                AppTextField.withLabel(
                  textInputAction: TextInputAction.next,
                  validator: validateYear,
                  readOnly: true,
                  keyboardType: TextInputType.datetime,
                  labelText: Strings.modelYearLabelText,
                  hintText: Strings.modelYearHintText,
                  controller: _modelYearController,
                  backgroundColor: context.colorScheme.secondary,
                ),
                const SizedBox(height: AppSizes.size12),
                AppTextField.withLabel(
                  textInputAction: TextInputAction.next,
                  validator: validateMMYYYY,
                  keyboardType: TextInputType.datetime,
                  labelText: Strings.vehicleRegistrationLabelText,
                  hintText: Strings.vehicleRegistrationHintText,
                  controller: _vehicleRegistrationController,
                  backgroundColor: context.colorScheme.secondary,
                ),
                const SizedBox(height: AppSizes.size12),
                AppTextField.withLabel(
                  textInputAction: TextInputAction.next,
                  validator: validateRequired,
                  textCapitalization: TextCapitalization.characters,
                  keyboardType: TextInputType.text,
                  labelText: Strings.vehiclePlateNumberLabelText,
                  hintText: Strings.vehiclePlateNumberHintText,
                  controller: _vehiclePlateNumberController,
                  backgroundColor: context.colorScheme.secondary,
                ),
                const SizedBox(height: AppSizes.size12),
                AppTextField.withLabel(
                  textInputAction: TextInputAction.next,
                  validator: validateRequired,
                  keyboardType: const TextInputType.numberWithOptions(),
                  labelText: Strings.numberOfSeatsLabelText,
                  hintText: Strings.numberOfSeatsHintText,
                  controller: _numberOfSeatsController,
                  backgroundColor: context.colorScheme.secondary,
                ),
                const SizedBox(height: AppSizes.size12),
                AppTextField.withLabel(
                  textInputAction: TextInputAction.next,
                  validator: validateRequired,
                  labelText: Strings.vehicleColorLabelText,
                  hintText: Strings.vehicleColorHintText,
                  controller: _colorController,
                  backgroundColor: context.colorScheme.secondary,
                ),
                const SizedBox(height: AppSizes.size12),
                AppTextField.withLabel(
                  textInputAction: TextInputAction.next,
                  validator: validateRequired,
                  labelText: Strings.vehicleTypeLabelText,
                  hintText: Strings.vehicleTypeHintText,
                  controller: _vehicleTypeController,
                  backgroundColor: context.colorScheme.secondary,
                ),
                const SizedBox(height: AppSizes.size12),
                AppTextField.withLabel(
                  textInputAction: TextInputAction.next,
                  validator: validateRequired,
                  readOnly: true,
                  keyboardType: const TextInputType.numberWithOptions(),
                  labelText: Strings.mileagePerChargeLabelText,
                  hintText: Strings.mileagePerChargeHintText,
                  controller: _mileagePerChargeController,
                  suffixText: Strings.mileagePerChargeSuffixText,
                  backgroundColor: context.colorScheme.secondary,
                ),
              ],
            ),
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
    );
  }
}
