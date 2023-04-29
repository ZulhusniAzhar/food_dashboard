import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateRangePickerWidget extends StatelessWidget {
  DateRangePickerWidget({super.key});
  final _startDate = DateTime.now().obs;
  final _endDate = DateTime.now().add(const Duration(days: 7)).obs;

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    _startDate.value = args.value.startDate;
    _endDate.value = args.value.endDate ?? args.value.startDate;
  }

  @override
  Widget build(BuildContext context) {
    return SfDateRangePicker(
      selectionMode: DateRangePickerSelectionMode.range,
      initialSelectedRange: PickerDateRange(
        DateTime.now(),
        DateTime.now().add(const Duration(days: 7)),
      ),
      onSelectionChanged: _onSelectionChanged,
      selectionTextStyle: const TextStyle(color: Colors.black),
      rangeTextStyle: const TextStyle(color: Colors.black),
      headerStyle: const DateRangePickerHeaderStyle(
        textStyle: TextStyle(color: Colors.black),
        backgroundColor: Colors.yellow,
      ),
      monthCellStyle: const DateRangePickerMonthCellStyle(
        todayTextStyle: TextStyle(color: Colors.black),
        weekendTextStyle: TextStyle(color: Colors.black),
        textStyle: TextStyle(color: Colors.black),
      ),
      yearCellStyle: const DateRangePickerYearCellStyle(
        todayTextStyle: TextStyle(color: Colors.black),
        textStyle: TextStyle(color: Colors.black),
      ),
    );
  }
}
