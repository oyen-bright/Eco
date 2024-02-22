part of locate_vehicle;

class DistanceContainerWidget extends StatelessWidget {
  final String distanceLeftString;
  final String durationLeftString;
  const DistanceContainerWidget(
      {super.key,
      required this.distanceLeftString,
      required this.durationLeftString});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppConstants.contentPadding,
      color: context.colorScheme.background,
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.compare_arrows),
                  label: Text('Distance: $distanceLeftString')),
            ),
            Expanded(
              child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.time_to_leave_outlined),
                  label: Text('Duration: $durationLeftString')),
            ),
          ],
        ),
      ),
    );
  }
}
