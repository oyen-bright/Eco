part of vehicle_details;

class VehicleExtraFeatures extends StatelessWidget {
  final List<String> features;

  const VehicleExtraFeatures({Key? key, required this.features})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 15.0,
      runSpacing: 15.0,
      children: features.map((feature) {
        return _buildFeatureChip(context, feature);
      }).toList(),
    );
  }

  Widget _buildFeatureChip(BuildContext context, String feature) {
    IconData iconData;
    String label;

    switch (feature.toLowerCase()) {
      case 'fast charging':
        iconData = Icons.flash_on_outlined;
        label = 'Fast Charging';
        break;

      case 'flash charging':
        iconData = Icons.flash_on_outlined;
        label = 'Flash Charging';
        break;

      case 'sport car':
        iconData = Icons.directions_car_outlined;
        label = 'Sport Car';
        break;
      case 'air condition':
        iconData = Icons.ac_unit_outlined;
        label = 'Air Condition';
        break;
      case 'dog mode':
        iconData = Icons.pets_outlined;
        label = 'Dog Mode';
        break;
      case 'auto pilot':
        iconData = Icons.auto_mode_outlined;
        label = 'Auto Pilot';
        break;
      case 'bluetooth':
        iconData = Icons.bluetooth_outlined;
        label = 'Bluetooth';
        break;
      case 'gps':
        iconData = Icons.gps_fixed_outlined;
        label = 'GPS';
        break;
      case 'power a camp':
        iconData = Icons.power_outlined;
        label = 'Power A Camp';
        break;
      default:
        iconData = Icons.info_outlined;
        label = feature;
    }

    return Chip(
      shape: const RoundedRectangleBorder(side: BorderSide(width: 0.1)),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      labelStyle: const TextStyle(fontSize: 12.5),
      labelPadding: const EdgeInsets.only(right: 7),
      avatar: CircleAvatar(
        radius: 11,
        backgroundColor: AppColors.lightPurpleSecondary,
        child: Icon(
          iconData,
          size: 17,
          color: AppColors.lightPurple,
        ),
      ),
      label: Text(label),
    );
  }
}
