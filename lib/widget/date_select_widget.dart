import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/date_controller.dart';


class DateSelectWidget extends StatelessWidget {
  final Function(DateTime? value) onChanged;
  const DateSelectWidget({super.key, required this.onChanged, DateTime? initialDateTime});

  void _showDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            initialDateTime: DateTime.now(),
            mode: CupertinoDatePickerMode.date,
            use24hFormat: true,
            showDayOfWeek: true,
            onDateTimeChanged: (DateTime newTime) {
              context.read<DateController>().setDate(newTime);
              onChanged(newTime);
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = context.watch<DateController>().selectedDate;

    return GestureDetector(
      onTap: () => _showDialog(context),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        padding: EdgeInsets.all(4),
        child: selectedDate != null
            ? Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(selectedDate.toString()),
            IconButton(
              onPressed: () {
                context.read<DateController>().clearDate();
                onChanged(null);
              },
              icon: Icon(
                Icons.remove,
                color: Colors.red,
              ),
            ),
          ],
        )
            : Text('CLICK TO SELECT TIME !'),
      ),
    );
  }
}
