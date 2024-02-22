part of '../select_smart_car_view.dart';

class CarList extends StatefulWidget {
  final List<SmartCarVehicle> vehicles;
  final Function(SmartCarVehicle) onSelected;
  const CarList({super.key, required this.vehicles, required this.onSelected});

  @override
  State<CarList> createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  int selectedIndex = 0;

  _changeSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (_, __) => const SizedBox(
          height: 15,
        ),
        itemCount: widget.vehicles.length,
        itemBuilder: (context, index) {
          SmartCarVehicle vehicle = widget.vehicles[index];
          return CarDetails(
              isSelected: selectedIndex == index,
              vehicle: vehicle,
              onTap: () {
                haptic(HapticFeedbackType.selection);
                widget.onSelected(vehicle);
                _changeSelected(index);
              });
        },
      ),
    );
  }
}
