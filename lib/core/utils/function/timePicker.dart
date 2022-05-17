import 'package:flutter/material.dart';

Future selectDate(context) async {
  DateTime today = DateTime.now();
  DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: today,
      lastDate: DateTime(2025),
      confirmText: 'Book',
      cancelText: 'Not now',
      selectableDayPredicate: (DateTime d) {
        if (d.isBefore(DateTime.now().add(Duration(days: 100)))) {
          return true;
        }
        return false;
      });

  return selectedDate;
}

Future selectTime(BuildContext context) async {
  TimeOfDay selectedTime = TimeOfDay.now();
  final TimeOfDay? timeOfDay = await showTimePicker(
    context: context,
    initialTime: selectedTime,
    initialEntryMode: TimePickerEntryMode.dial,
  );
  if (timeOfDay != null && timeOfDay != selectedTime) {}
  return timeOfDay;
}
