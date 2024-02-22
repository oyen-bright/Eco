// ignore_for_file: public_member_api_docs, sort_constructors_first
part of locate_vehicle;

class VehicleLocatedGetCode extends StatefulWidget {
  final Vehicle vehicle;
  final String rentalID;

  const VehicleLocatedGetCode(
      {Key? key, required this.vehicle, required this.rentalID})
      : super(key: key);

  @override
  State<VehicleLocatedGetCode> createState() => _VehicleLocatedGetCodeState();
}

class _VehicleLocatedGetCodeState extends State<VehicleLocatedGetCode> {
  bool isLoading = false;

  void _onGetCode() async {
    setState(() {
      isLoading = true;
    });

    final response = await context.read<VehicleCubit>().sendVehicleUnlockOTP();

    if (mounted) {
      setState(() {
        isLoading = false;
      });
      if (response.error == null) {
        context.showSnackBar(response.message);

        UnlockVehicleOTP(
          rentalID: widget.rentalID,
          vehicle: widget.vehicle,
        ).asBottomSheet(context);
      } else {
        context.showSnackBar(response.error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future(() => false),
      child: Container(
        decoration: BoxDecoration(
            color: context.colorScheme.onPrimary,
            borderRadius:
                BorderRadius.circular(AppConstants.borderRadiusLarge)),
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.viewPaddingHorizontal),
        margin: const EdgeInsets.symmetric(
            vertical: AppConstants.viewPaddingVertical,
            horizontal: AppConstants.viewPaddingHorizontal),
        child: SizedBox(
            height: context.viewSize.height * .30,
            width: context.viewSize.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                _buildVehicleImageAndDetails(context),
                const Spacer(),
                _buildInstructionalText(context),
                const Spacer(),
                _buildActionButton(context),
                const Spacer(),
              ],
            )),
      ),
    );
  }

  Widget _buildVehicleImageAndDetails(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            height: context.viewSize.height * .25 / 2.4,
            width: context.viewSize.width / 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              child: (widget.vehicle.carImages.isNotEmpty
                  ? AppCachedImage(
                      withPinata: true,
                      imageUrl: widget.vehicle.carImages.first['imageUrl'])
                  : Image.asset(AppImages.noVehicleImage)),
            )),
        const SizedBox(
          width: AppSizes.size10,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                'Vehicle Located',
                style: context.textTheme.bodyLarge?.copyWith(
                    color: AppColors.rentalUsedColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              AutoSizeText(
                'Model : ${widget.vehicle.model}',
                style: context.textTheme.labelLarge
                    ?.copyWith(color: AppColors.lowOpacityTextColor),
              ),
              AutoSizeText(
                'Color : ${widget.vehicle.color}',
                style: context.textTheme.labelLarge
                    ?.copyWith(color: AppColors.lowOpacityTextColor),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildInstructionalText(BuildContext context) {
    return AutoSizeText(
      Strings.unlockVehiclePrompt,
      textAlign: TextAlign.center,
      style: context.textTheme.bodyLarge
          ?.copyWith(color: AppColors.lowOpacityTextColor),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return AppElevatedButton(
        isLoading: isLoading, onPressed: _onGetCode, title: Strings.getCode);
  }
}
