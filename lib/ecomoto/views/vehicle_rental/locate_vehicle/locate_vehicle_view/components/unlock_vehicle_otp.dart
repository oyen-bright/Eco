part of '../locate_vehicle_view.dart';

class UnlockVehicleOTP extends StatefulWidget {
  final Vehicle vehicle;
  final String rentalID;
  const UnlockVehicleOTP(
      {super.key, required this.vehicle, required this.rentalID});

  @override
  UnlockVehicleOTPState createState() => UnlockVehicleOTPState();
}

class UnlockVehicleOTPState extends State<UnlockVehicleOTP> {
  late bool isApproved;
  String? errorMessage;
  bool isLoading = false;
  String? currentOTP;

  @override
  void initState() {
    super.initState();
    isApproved = false;
  }

  Future<void> _verifyOTP(String input) async {
    currentOTP = input;
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final response = await context
        .read<VehicleCubit>()
        .verifyVehicleUnlockOTP(token: input.trim(), rentalID: widget.rentalID);

    if (response.error != null) {
      setState(() {
        isLoading = false;
        isApproved = false;
        errorMessage = response.error;
      });
    } else {
      setState(() {
        isLoading = false;
        isApproved = true;
      });
    }
  }

  void _unlockVehicle() async {
    if (!isApproved && widget.vehicle.smartCarDetails.id != null) {
      print(widget.vehicle.smartCarDetails.id!);
      setState(() => isLoading = true);
      final onTripStartUnlockVehicleResponse = await context
          .read<VehicleCubit>()
          .onTripStartUnlockVehicle(
              rentalId: widget.rentalID,
              smartCarVehicleId: "0d607e4b-5ea2-48ae-87cf-2ef5787781e1");
      setState(() => isLoading = false);
      final onTripStartUnlockVehicleError =
          onTripStartUnlockVehicleResponse.error;

      if (mounted) {
        if (onTripStartUnlockVehicleError != null) {
          log(onTripStartUnlockVehicleError);
          showAppDialog(context, onTripStartUnlockVehicleError);
        } else {
          await showAppDialog(
              context, onTripStartUnlockVehicleResponse.message ?? "");
          AppRouter.router.pushReplacement(
              EcomotoRoutes.vehicleRentalUploadImageView,
              extra: widget.rentalID);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future(() => !isLoading),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.viewPaddingHorizontal,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ..._buildHeader(),
                ..._buildOTPInput(),
                ..._buildButton()
              ],
            ),
            // if (isLoading) _buildLoadingIndicator(context)
          ],
        ),
      ),
    );
  }

  List<Widget> _buildHeader() {
    return [
      if (isApproved) ...[
        const SizedBox(
          height: 10,
        ),
        Image.asset(
          AppImages.otpApprovedIcon,
          scale: 2,
        ),
        const SizedBox(
          height: 10,
        ),
      ] else
        const SizedBox(
          height: 100,
        ),
      Text(
        Strings.provideOTPPrompt,
        textAlign: TextAlign.center,
        style: context.textTheme.titleMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 30,
      ),
    ];
  }

  List<Widget> _buildOTPInput() {
    return [
      _UnlockOtpForm(
        predefinedOTP: currentOTP,
        isLoading: isLoading,
        isError: errorMessage != null,
        isApproved: isApproved,
        onUnlockPressed: (input) => _verifyOTP(input),
      ),
      if (isApproved) ...{
        const SizedBox(
          height: 10,
        ),
        const Text(Strings.otpApproved),
      } else if (errorMessage != null) ...{
        const SizedBox(
          height: 10,
        ),
        Text(
          errorMessage!,
          textAlign: TextAlign.center,
          style: TextStyle(color: context.colorScheme.error),
        ),
      }
    ];
  }

  List<Widget> _buildButton() {
    return [
      const SizedBox(
        height: 40,
      ),
      AppElevatedButton(
        isLoading: isLoading,
        title: Strings.unlockVehicle,
        backgroundColor: AppColors.approvalGreen,
        onPressed: !isApproved ? () => _unlockVehicle() : null,
      ),
      const SizedBox(
        height: 40,
      ),
    ];
  }

  Container _buildLoadingIndicator(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
          color: context.colorScheme.secondary,
        ),
        child: const CircularProgressIndicator());
  }
}

class _UnlockOtpForm extends StatefulWidget {
  final bool isApproved;
  final bool isError;
  final bool isLoading;
  final Function(String) onUnlockPressed;
  final String? predefinedOTP;

  const _UnlockOtpForm({
    required this.isError,
    required this.isLoading,
    required this.isApproved,
    required this.onUnlockPressed,
    this.predefinedOTP,
  });

  @override
  State<_UnlockOtpForm> createState() => _UnlockOtpFormState();
}

class _UnlockOtpFormState extends State<_UnlockOtpForm> {
  late List<TextEditingController> controllers;
  late FocusNode firstFocusNode;

  final inputCount = 8;

  @override
  void initState() {
    super.initState();
    firstFocusNode = FocusNode();
    controllers = List.generate(inputCount, (index) => TextEditingController());

    if (widget.predefinedOTP != null) {
      for (int i = 0; i < widget.predefinedOTP!.length; i++) {
        controllers[i].text = widget.predefinedOTP![i];
      }
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    firstFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TODO:make it better
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        inputCount,
        (index) => Container(
          decoration: BoxDecoration(
            color: widget.isApproved
                ? AppColors.otpInputApprovedColor
                : widget.isError
                    ? context.colorScheme.error.withOpacity(0.1)
                    : AppColors.otpInputColor,
            borderRadius: BorderRadius.circular(5),
            // border: Border.all(color: AppColors.primaryColor, width: 1),
          ),
          width: 40,
          child: TextField(
            readOnly: widget.isApproved || widget.isLoading,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            controller: controllers[index],
            maxLength: 1,
            style: context.textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onChanged: (String value) {
              if (value.isNotEmpty) {
                if (index < inputCount - 1) {
                  FocusScope.of(context).nextFocus();
                } else {
                  String otp =
                      controllers.map((controller) => controller.text).join();
                  if (otp.length == inputCount) {
                    // Updated condition here
                    FocusScope.of(context)
                        .unfocus(); // Remove focus from all text fields
                    widget.onUnlockPressed(otp);
                  }
                }
              } else {
                if (index > 0) {
                  FocusScope.of(context).previousFocus();
                }
              }
            },
            focusNode: index == 0 ? firstFocusNode : null,
            buildCounter: (BuildContext context,
                    {int? currentLength, int? maxLength, bool? isFocused}) =>
                null,
          ),
        ),
      ),
    );
  }
}
