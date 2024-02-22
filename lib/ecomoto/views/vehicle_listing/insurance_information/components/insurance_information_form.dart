part of '../insurance_information_view.dart';

class InsuranceInformationForm extends StatefulWidget {
  final VehicleModel vehicleInputData;
  const InsuranceInformationForm({
    super.key,
    required this.vehicleInputData,
  });

  @override
  State<InsuranceInformationForm> createState() =>
      _InsuranceInformationFormState();
}

class _InsuranceInformationFormState extends State<InsuranceInformationForm>
    with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _insuranceProviderController;
  late final TextEditingController _insurancePNumberController;
  late final TextEditingController _policyNumberController;
  late final TextEditingController _effectiveDateController;
  late final TextEditingController _expiryDateController;
  late final TextEditingController _insuranceImageController;

  @override
  void initState() {
    _insuranceProviderController = TextEditingController();
    _insurancePNumberController = TextEditingController();
    _policyNumberController = TextEditingController();
    _effectiveDateController = TextEditingController();
    _expiryDateController = TextEditingController();
    _insuranceImageController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _insuranceProviderController.dispose();
    _insurancePNumberController.dispose();
    _policyNumberController.dispose();
    _effectiveDateController.dispose();
    _expiryDateController.dispose();
    _insuranceImageController.dispose();
    super.dispose();
  }

  void _pickExpireDate() async {
    final response =
        await appDatePicker(context, initialDate: _expiryDateController.text);
    if (response != null) {
      _expiryDateController.text = response;
    }
  }

  void _pickEffectiveDate() async {
    final response = await appDatePicker(context,
        initialDate: _effectiveDateController.text);
    if (response != null) {
      _effectiveDateController.text = response;
    }
  }

  void _pickInsuranceImage() async {
    final response = await appImageVideoPicker(
      context,
    );
    if (response != null) {
      widget.vehicleInputData.insuranceImage = response.path;
      _insuranceImageController.text = response.name;
    }
  }

  void _onProceed() {
    if (_formKey.currentState!.validate()) {
      context.removeFocus;

      final vehicleInputData = widget.vehicleInputData;
      vehicleInputData.effectiveDate =
          DateTime.tryParse(_expiryDateController.text);
      vehicleInputData.expiryDate =
          DateTime.tryParse(_effectiveDateController.text);
      vehicleInputData.insuranceProvider = _insuranceProviderController.text;
      vehicleInputData.insurancePNumber =
          int.tryParse(_insurancePNumberController.text);
      vehicleInputData.policyNumber =
          int.tryParse(_policyNumberController.text);

      AppRouter.router.push(EcomotoRoutes.vehicleListingQualityStandards,
          extra: vehicleInputData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Form(
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
                    const SizedBox(
                      height: AppSizes.size12,
                    ),
                    AppTextField.withLabel(
                      textInputAction: TextInputAction.next,
                      validator: validateRequired,
                      labelText: Strings.insuranceProviderLabelText,
                      hintText: Strings.insuranceProviderHintText,
                      controller: _insuranceProviderController,
                      backgroundColor: AppColors.registerFormColor,
                    ),
                    const SizedBox(height: AppSizes.size12),
                    AppTextField.withLabel(
                      textInputAction: TextInputAction.next,
                      validator: validateRequired,
                      keyboardType: const TextInputType.numberWithOptions(),
                      labelText: Strings.insurancePNumberLabelText,
                      hintText: Strings.insurancePNumberHintText,
                      controller: _insurancePNumberController,
                      backgroundColor: AppColors.registerFormColor,
                    ),
                    const SizedBox(height: AppSizes.size12),
                    AppTextField.withLabel(
                      textInputAction: TextInputAction.next,
                      validator: validateRequired,
                      labelText: Strings.policyNumberLabelText,
                      hintText: Strings.policyNumberHintText,
                      controller: _policyNumberController,
                      keyboardType: const TextInputType.numberWithOptions(),
                      backgroundColor: AppColors.registerFormColor,
                    ),
                    const SizedBox(height: AppSizes.size12),
                    AppTextField.withLabel(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.none,
                      validator: validateRequired,
                      labelText: Strings.insuranceEffectiveDateLabelText,
                      hintText: Strings.insuranceEffectiveDateHintText,
                      controller: _effectiveDateController,
                      onTap: _pickEffectiveDate,
                      suffixIcon: IconButton(
                        onPressed: _pickEffectiveDate,
                        icon: const Icon(Icons.calendar_month),
                      ),
                      backgroundColor: AppColors.registerFormColor,
                    ),
                    const SizedBox(height: AppSizes.size12),
                    AppTextField.withLabel(
                      textInputAction: TextInputAction.next,
                      validator: validateRequired,
                      keyboardType: TextInputType.none,
                      onTap: _pickExpireDate,
                      suffixIcon: IconButton(
                        onPressed: _pickExpireDate,
                        icon: const Icon(Icons.calendar_month),
                      ),
                      labelText: Strings.insuranceExpDateLabelText,
                      hintText: Strings.insuranceExpDateHintText,
                      controller: _expiryDateController,
                      backgroundColor: AppColors.registerFormColor,
                    ),
                    const SizedBox(height: AppSizes.size12),
                    AppTextField.withLabel(
                      textInputAction: TextInputAction.next,
                      validator: validateRequired,
                      keyboardType: TextInputType.none,
                      onTap: _pickInsuranceImage,
                      maxLines: 1,
                      suffixIcon: IconButton(
                        onPressed: _pickInsuranceImage,
                        icon: const Icon(Icons.upload),
                      ),
                      labelText: Strings.insuranceCardLabelText,
                      hintText: Strings.insuranceCardHintText,
                      controller: _insuranceImageController,
                      backgroundColor: AppColors.registerFormColor,
                    ),
                  ],
                ),
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
      ),
    );
  }
}
