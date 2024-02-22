part of '../listing_location_view.dart';

class VehicleListingLocationToggle extends StatelessWidget {
  final Widget? reservedSpaceToggle;
  final Widget? publicParkingToggle;

  const VehicleListingLocationToggle({
    super.key,
    this.reservedSpaceToggle,
    this.publicParkingToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                const SizedBox(
                    width: AppSizes.size30,
                    child: Icon(
                      Icons.circle,
                      size: 7,
                    )),
                Text(
                  Strings.reservedSpaceText,
                  style: context.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w400),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            Transform.scale(
              scale: .80,
              child: reservedSpaceToggle,
            )
          ],
        ),
        const SizedBox(
          height: AppSizes.size10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                    width: AppSizes.size30,
                    child: Icon(
                      Icons.circle,
                      size: 7,
                    )),
                Text(
                  Strings.publicParkingText,
                  style: context.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w400),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            Transform.scale(
              scale: .80,
              child: publicParkingToggle,
            )
          ],
        ),
      ],
    );
  }
}
