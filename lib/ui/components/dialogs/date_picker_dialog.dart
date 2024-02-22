import 'package:flutter/material.dart';

Future<String?> appDatePicker(BuildContext context,
    {String? initialDate,
    bool Function(DateTime)? selectableDayPredicate}) async {
  final response = await showDatePicker(
    context: context,
    initialDate: DateTime.tryParse(initialDate ?? "") ?? DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(5000),
  );
  if (response != null) {
    return response.toLocal().toString().split(' ')[0];
  }
  return null;
}

Future<TimeOfDay?> appTimePicker(
  BuildContext context, {
  TimeOfDay? initialTime,
  String? helperTest,
  TimePickerEntryMode initialEntryMode = TimePickerEntryMode.inputOnly,
}) async {
  final response = await showTimePicker(
    context: context,
    helpText: helperTest,
    initialEntryMode: initialEntryMode,
    initialTime: initialTime ?? TimeOfDay.now(),
  );
  if (response != null) {
    return response;
  }
  return null;
}
