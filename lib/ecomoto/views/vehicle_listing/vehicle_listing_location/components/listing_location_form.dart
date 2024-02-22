part of '../listing_location_view.dart';

class ListingLocationForm extends StatefulWidget {
  final VehicleModel vehicleInputData;

  const ListingLocationForm({
    super.key,
    required this.vehicleInputData,
  });

  @override
  State<ListingLocationForm> createState() => _ListingLocationFormState();
}

class _ListingLocationFormState extends State<ListingLocationForm>
    with LocationMixin {
  bool _isReservedSelected = true;
  bool _isPublicParkingSelected = false;

  @override
  void initState() {
    super.initState();
    requestLocationPermission(context);
  }

  void _onProceed() {
    if (_validateInput()) {
      widget.vehicleInputData.isReserved = _isReservedSelected;
      widget.vehicleInputData.isPublicParking = _isPublicParkingSelected;
      AppRouter.router.push(EcomotoRoutes.vehicleListingAvailability,
          extra: widget.vehicleInputData);
      debugPrint('Vehicle Input Data: ${widget.vehicleInputData.toString()}');
    } else {
      _showLocationSelectionError();
    }
  }

  bool _validateInput() {
    return widget.vehicleInputData.latitude != null &&
        widget.vehicleInputData.longitude != null;
  }

  void _showLocationSelectionError() {
    context.showSnackBar(Strings.locationPickingTip);
  }

  Widget _buildToggleButtons() {
    return VehicleListingLocationToggle(
      reservedSpaceToggle: AppToggleButton(
        isSelected: _isReservedSelected,
        onToggle: (_) => _toggleReservedSpace(),
      ),
      publicParkingToggle: AppToggleButton(
        isSelected: _isPublicParkingSelected,
        onToggle: (_) => _togglePublicParking(),
      ),
    );
  }

  void _toggleReservedSpace() {
    setState(() {
      _isReservedSelected = !_isReservedSelected;
      _isPublicParkingSelected = !_isReservedSelected;
    });
  }

  void _togglePublicParking() {
    setState(() {
      _isPublicParkingSelected = !_isPublicParkingSelected;
      _isReservedSelected = !_isPublicParkingSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildFormContent(),
        _buildSubmitButton(),
      ],
    );
  }

  Widget _buildFormContent() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildToggleButtons(),
            const SizedBox(height: AppSizes.size20),
            LocationPicker(vehicleInputData: widget.vehicleInputData),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Row(
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
    );
  }
}
