part of '../vehicle_availability_view.dart';

class VehicleAvailabilityForm extends StatefulWidget {
  final VehicleModel vehicleInputData;
  const VehicleAvailabilityForm({
    super.key,
    required this.vehicleInputData,
  });

  @override
  State<VehicleAvailabilityForm> createState() =>
      _VehicleAvailabilityFormState();
}

class _VehicleAvailabilityFormState extends State<VehicleAvailabilityForm>
    with ValidationMixin {
  RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOff;
  List<DateTime> selectedDates = [];

  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  void _onDaySelected(DateTime day, DateTime? focusedDay) {
    setState(() {
      if (selectedDates.contains(day)) {
        selectedDates.remove(day);
      } else {
        selectedDates.add(day);
      }
    });
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    if (start != null && end != null) {
      List<DateTime> datesToAdd = getDatesBetween(start, end)
          .where((date) => !selectedDates.contains(date))
          .toList();

      selectedDates.addAll(datesToAdd);
      start = null;
      end = null;
      rangeSelectionMode = RangeSelectionMode.toggledOff;
    } else {
      rangeSelectionMode = RangeSelectionMode.toggledOn;
    }

    setState(() {
      _rangeStart = start;
      _rangeEnd = end;
    });
  }

  void _onProceed() {
    if (selectedDates.isNotEmpty) {
      context.removeFocus;

      final vehicleInputData = widget.vehicleInputData;
      vehicleInputData.selectedDates = selectedDates;

      debugPrint('Vehicle Input Data: ${vehicleInputData.toString()}');

      AppRouter.router.push(EcomotoRoutes.vehicleListingSelectPlan,
          extra: vehicleInputData);
    } else {
      context.showSnackBar(Strings.noDateSelectErrorPrompt);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                const AvailabilityIndicator(),
                const SizedBox(
                  height: AppSizes.size10,
                ),
                Container(
                  // height: AppSizes.size300 + AppSizes.size6,
                  width: AppSizes.size300 + AppSizes.size6,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: context.colorScheme.primary,
                    ),
                    borderRadius:
                        BorderRadius.circular(AppConstants.borderRadius),
                  ),
                  child: TableCalendar(
                    availableGestures: AvailableGestures.all,
                    rowHeight: 43,
                    headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: context.textTheme.titleMedium!),
                    selectedDayPredicate: (day) {
                      return selectedDates.contains(day);
                    },
                    rangeSelectionMode: rangeSelectionMode,
                    calendarStyle: CalendarStyle(
                      rangeStartDecoration: BoxDecoration(
                        color: context.colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      cellMargin: const EdgeInsets.all(AppSizes.size2),
                      cellAlignment: Alignment.center,
                      isTodayHighlighted: false,
                      outsideDaysVisible: false,
                      selectedDecoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                AppConstants.borderRadiusSmall)),
                        color: context.colorScheme.primary,
                      ),
                    ),
                    onRangeSelected: _onRangeSelected,
                    rangeStartDay: _rangeStart,
                    rangeEndDay: _rangeEnd,
                    firstDay: DateTime.now(),
                    focusedDay: selectedDates.lastOrNull ?? DateTime.now(),
                    lastDay: DateTime(2999),
                    onDaySelected: _onDaySelected,
                  ),
                ),
                SizedBox(
                  height: AppSizes.size20,
                ),
                _buildTip(context),
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
    );
  }

  Widget _buildTip(BuildContext context) {
    return Text(
      Strings.multipleDatesTip,
      textAlign: TextAlign.center,
      style: context.textTheme.bodySmall?.copyWith(
        color: context.colorScheme.primary,
      ),
    );
  }
}
