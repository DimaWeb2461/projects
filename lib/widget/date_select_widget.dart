import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';

class DateSelectWidget extends StatefulWidget {
  final Function(DateTime? value) onChanged;
  final DateTime? initialDateTime;
  const DateSelectWidget({super.key, required this.onChanged, this.initialDateTime});

  @override
  State<DateSelectWidget> createState() => _DateSelectWidgetState();
}

class _DateSelectWidgetState extends State<DateSelectWidget> {
  DateTime? selectedDateTime;

  @override
  void initState() {
    selectedDateTime = widget.initialDateTime;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DateSelectWidget oldWidget) {
    if(oldWidget.initialDateTime != selectedDateTime){
      selectedDateTime = widget.initialDateTime;
    }
    super.didUpdateWidget(oldWidget);
  }

  void _showDialog() {
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
              selectedDateTime = newTime;
              widget.onChanged.call(selectedDateTime);
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDialog(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        padding: EdgeInsets.all(4),
        child: selectedDateTime != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(selectedDateTime.toString()),
                  IconButton(
                    onPressed: () {
                      selectedDateTime = null;
                      widget.onChanged.call(selectedDateTime);

                      setState(() {});

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
