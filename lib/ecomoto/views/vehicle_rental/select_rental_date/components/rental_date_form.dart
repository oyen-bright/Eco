part of rental_date;

class RentalDatePicker extends StatefulWidget {
  final VehicleRentalModel rentalData;
  final Vehicle vehicle;

  const RentalDatePicker({
    super.key,
    required this.rentalData,
    required this.vehicle,
  });

  @override
  RentalDatePickerState createState() => RentalDatePickerState();
}

class RentalDatePickerState extends State<RentalDatePicker>
    with ValidationMixin {
  late final TextEditingController pickUpTimeController;
  late final TextEditingController returnTimeController;

  DateTime _focusedDay = DateTime.now();

  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  TimeOfDay? _pickUpTime;
  TimeOfDay? _returnTime;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    pickUpTimeController = TextEditingController();
    returnTimeController = TextEditingController();

    widget.rentalData.startDate = _focusedDay;
  }

  @override
  void dispose() {
    pickUpTimeController.dispose();
    returnTimeController.dispose();
    super.dispose();
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _updateRentalData();
    });
  }

  void _onDaySelected(DateTime? selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      _rangeEnd = null;
      _rangeStart = selectedDay;
      _updateRentalData();
    });
  }

  void _updateRentalData() {
    if (_rangeStart != null) {
      widget.rentalData.startDate = _rangeStart;
    }
    if (_rangeStart != null && _rangeEnd != null) {
      widget.rentalData.startDate = _rangeStart;
      widget.rentalData.endDate = _rangeEnd;
    }
  }

  bool validate() {
    context.removeFocus;

    bool isControllersEmpty() {
      return [pickUpTimeController.text, returnTimeController.text]
          .any((element) => element.isEmpty);
    }

    bool isReturnTimeValid(DateTime? startDate, DateTime? endDate,
        TimeOfDay? pickUpTime, TimeOfDay? returnTime) {
      if (pickUpTime == null || returnTime == null || startDate == null) {
        return false;
      }

      endDate ??= startDate;

      final pickUpDateTime = DateTime(startDate.year, startDate.month,
          startDate.day, pickUpTime.hour, pickUpTime.minute);
      final returnDateTime = DateTime(endDate.year, endDate.month, endDate.day,
          returnTime.hour, returnTime.minute);

      if (startDate.year == endDate.year &&
          startDate.month == endDate.month &&
          startDate.day == endDate.day) {
        return returnDateTime.isAfter(pickUpDateTime);
      } else {
        return true;
      }
    }

    if (isControllersEmpty()) {
      context.showSnackBar(Strings.validationErrorPrompt);
      return false;
    }

    if (widget.rentalData.startDate == null ||
        _pickUpTime == null ||
        _returnTime == null) {
      context.showSnackBar(Strings.validationErrorPrompt);
      return false;
    }

    final DateTime startDate = widget.rentalData.startDate!;
    final DateTime? endDate = widget.rentalData.endDate;

    if (!isReturnTimeValid(startDate, endDate, _pickUpTime, _returnTime)) {
      context.showSnackBar(Strings.validationReturnTimeErrorPrompt);
      return false;
    }

    widget.rentalData
      ..rentalStartDateTime = DateTime(startDate.year, startDate.month,
          startDate.day, _pickUpTime!.hour, _pickUpTime!.minute)
      ..rentalEndDateTime = DateTime(
          endDate?.year ?? startDate.year,
          endDate?.month ?? startDate.month,
          endDate?.day ?? startDate.day,
          _returnTime!.hour,
          _returnTime!.minute)
      ..pickUpTime = _pickUpTime
      ..returnTime = _returnTime;

    return true;
  }

  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    return DateFormat.jm().format(dateTime);
  }

  void _onSelectTime(BuildContext context, void Function(TimeOfDay) onSelected,
      TextEditingController controller, String hintText) async {
    final TimeOfDay? initialTime =
        onSelected == _updatePickUpTime ? _pickUpTime : _returnTime;
    final response = await appTimePicker(context,
        initialTime: initialTime, helperTest: hintText);

    if (response != null) {
      onSelected(response);
      controller.text = formatTimeOfDay(response);
    }
  }

  void _updatePickUpTime(TimeOfDay newTime) {
    setState(() {
      _pickUpTime = newTime;
    });
  }

  void _updateReturnTime(TimeOfDay newTime) {
    setState(() {
      _returnTime = newTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildCalendar(),
        const SizedBox(
          height: AppSizes.size16,
        ),
        _buildDateAndTimeSelection(context),
        const SizedBox(
          height: AppSizes.size4,
        ),
        _buildRentalInformationForm(context),
      ],
    );
  }

  Widget _buildCalendar() {
    return Transform.scale(
      scale: .90,
      child: Container(
        decoration: BoxDecoration(
            color: context.colorScheme.primary,
            borderRadius: BorderRadius.circular(AppSizes.size20)),
        child: TableCalendar(
          enabledDayPredicate: (DateTime date) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(date);

            return widget.vehicle.availableDates.any((DateTime availableDate) {
              String formattedAvailableDate =
                  DateFormat('yyyy-MM-dd').format(availableDate);

              return formattedDate == formattedAvailableDate;
            });
          },
          onDisabledDayTapped: (_) =>
              context.showSnackBar(Strings.vehicleNotAvailable),
          availableGestures: AvailableGestures.all,
          headerStyle: HeaderStyle(
              leftChevronIcon:
                  const Icon(Icons.chevron_left, color: Colors.white),
              rightChevronIcon:
                  const Icon(Icons.chevron_right, color: Colors.white),
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: context.textTheme.titleMedium!
                  .copyWith(color: context.colorScheme.onPrimary)),
          startingDayOfWeek: StartingDayOfWeek.monday,
          rangeStartDay: _rangeStart,
          rangeEndDay: _rangeEnd,
          rangeSelectionMode: RangeSelectionMode.toggledOn,
          currentDay: DateTime.now(),
          calendarFormat: CalendarFormat.month,
          focusedDay: _focusedDay,
          selectedDayPredicate: (DateTime day) {
            return isSameDay(_focusedDay, day);
          },
          firstDay: DateTime.now(),
          lastDay: DateTime.now().add(const Duration(days: 365)),
          onRangeSelected: _onRangeSelected,
          onDaySelected: _onDaySelected,
          calendarStyle: CalendarStyle(
            isTodayHighlighted: false,
            outsideDaysVisible: false,
            rangeEndTextStyle:
                TextStyle(color: context.colorScheme.onBackground),
            rangeStartTextStyle:
                TextStyle(color: context.colorScheme.onBackground),
            rangeStartDecoration: BoxDecoration(
              color: context.colorScheme.onSecondary,
              shape: BoxShape.circle,
            ),
            selectedTextStyle:
                TextStyle(color: context.colorScheme.onBackground),
            selectedDecoration: BoxDecoration(
                color: context.colorScheme.secondary, shape: BoxShape.circle),
            weekendTextStyle: TextStyle(color: context.colorScheme.onPrimary),
            rangeEndDecoration: BoxDecoration(
              color: context.colorScheme.onSecondary,
              shape: BoxShape.circle,
            ),
            disabledTextStyle: TextStyle(color: Colors.grey.withOpacity(0.3)),
            rangeHighlightColor: context.colorScheme.secondary,
            defaultTextStyle: TextStyle(color: context.colorScheme.onPrimary),
          ),
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(color: context.colorScheme.onPrimary),
            weekendStyle: TextStyle(color: context.colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }

  Widget _buildDateAndTimeSelection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const AutoSizeText(Strings.rentalDateTitle,
            textAlign: TextAlign.center),
        SizedBox(
          width: double.infinity,
          child: AutoSizeText(
            _getSelectedDateText(),
            textAlign: TextAlign.center,
            style: context.textTheme.titleMedium!
                .copyWith(fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }

  String _getSelectedDateText() {
    if (_rangeStart != null && _rangeEnd != null) {
      return '${DateFormat('d MMM').format(_rangeStart!)} to ${DateFormat('d MMM yyyy').format(_rangeEnd!)}';
    } else {
      return DateFormat('d MMM yyyy').format(_focusedDay);
    }
  }

  Form _buildRentalInformationForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(
            height: AppSizes.size30,
          ),
          Row(
            children: [
              Expanded(
                child: AppTextField.withColor(
                  hintText: Strings.pickUpTimeInputHit,
                  readOnly: true,
                  validator: validateRequired,
                  keyboardType: TextInputType.none,
                  controller: pickUpTimeController,
                  labelText: Strings.pickUpTimeInput,
                  onTap: () => _onSelectTime(
                    context,
                    _updatePickUpTime,
                    pickUpTimeController,
                    Strings.pickUpTimeInputHit,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => _onSelectTime(
                      context,
                      _updatePickUpTime,
                      pickUpTimeController,
                      Strings.pickUpTimeInputHit,
                    ),
                    icon: const Icon(Icons.time_to_leave),
                  ),
                ),
              ),
              const SizedBox(
                width: AppSizes.size10,
              ),
              Expanded(
                child: AppTextField.withColor(
                  keyboardType: TextInputType.none,
                  hintText: Strings.returnTimeInput,
                  labelText: Strings.returnTimeInput,
                  validator: validateRequired,
                  controller: returnTimeController,
                  onTap: () => _onSelectTime(
                    context,
                    _updateReturnTime,
                    returnTimeController,
                    Strings.returnTimeInputHit,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => _onSelectTime(
                      context,
                      _updateReturnTime,
                      returnTimeController,
                      Strings.returnTimeInputHit,
                    ),
                    icon: const Icon(Icons.time_to_leave),
                  ),
                ),
              ),
            ],
          )
        ],
      ).withHorViewPadding,
    );
  }
}
