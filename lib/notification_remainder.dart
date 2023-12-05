import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;


//weekly, monthly, custom date remainder & custom time
enum ReminderType { Weekly, Monthly, CustomDate }

class ReminderSettings {
  final ReminderType reminderType;
  final DateTime? customDate;

  ReminderSettings(this.reminderType, this.customDate);
}

class ReminderScreen extends StatefulWidget {
  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  ReminderType selectedReminderType = ReminderType.Weekly;
  TimeOfDay? selectedTime;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    loadReminderSettings();
  }

  void loadReminderSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? reminderType = prefs.getString('reminderType');
    int? hour = prefs.getInt('hour');
    int? minute = prefs.getInt('minute');
    int? year = prefs.getInt('year');
    int? month = prefs.getInt('month');
    int? day = prefs.getInt('day');

    if (reminderType != null) {
      setState(() {
        selectedReminderType = ReminderType.values
            .firstWhere((type) => type.toString() == reminderType);
      });
    }

    if (hour != null && minute != null) {
      selectedTime = TimeOfDay(hour: hour, minute: minute);
    }

    if (year != null && month != null && day != null) {
      selectedDate = DateTime(year, month, day);
    }
  }

  void saveReminderSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('reminderType', selectedReminderType.toString());

    if (selectedTime != null) {
      prefs.setInt('hour', selectedTime!.hour);
      prefs.setInt('minute', selectedTime!.minute);
    }

    if (selectedDate != null) {
      prefs.setInt('year', selectedDate!.year);
      prefs.setInt('month', selectedDate!.month);
      prefs.setInt('day', selectedDate!.day);
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
        saveReminderSettings();
      });
    }
  }

  Future<void> selectDate(BuildContext context) async {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      onConfirm: (date) {
        setState(() {
          selectedDate = date;
          saveReminderSettings();
        });
      },
      currentTime: selectedDate ?? DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminder Settings'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Weekly Reminder'),
            leading: Radio<ReminderType>(
              value: ReminderType.Weekly,
              groupValue: selectedReminderType,
              onChanged: (value) {
                setState(() {
                  selectedReminderType = value!;
                  saveReminderSettings();
                });
              },
            ),
          ),
          ListTile(
            title: Text('Monthly Reminder'),
            leading: Radio<ReminderType>(
              value: ReminderType.Monthly,
              groupValue: selectedReminderType,
              onChanged: (value) {
                setState(() {
                  selectedReminderType = value!;
                  saveReminderSettings();
                });
              },
            ),
          ),
          ListTile(
            title: Text('Custom Date Reminder'),
            leading: Radio<ReminderType>(
              value: ReminderType.CustomDate,
              groupValue: selectedReminderType,
              onChanged: (value) {
                setState(() {
                  selectedReminderType = value!;
                  saveReminderSettings();
                });
              },
            ),
          ),
          if (selectedReminderType == ReminderType.CustomDate)
            ListTile(
              title: Text('Select Date'),
              trailing: ElevatedButton(
                onPressed: () {
                  selectDate(context);
                },
                child: Text(
                  selectedDate != null
                      ? 'Selected Date: ${selectedDate!.toString().split(' ')[0]}'
                      : 'Select Date',
                ),
              ),
            ),
          ListTile(
            title: Text('Reminder Time'),
            trailing: ElevatedButton(
              onPressed: () {
                selectTime(context);
              },
              child: Text(
                selectedTime != null
                    ? 'Selected Time: ${selectedTime!.format(context)}'
                    : 'Select Time',
              ),
            ),
          ),
        ],
      ),
    );
  }
}