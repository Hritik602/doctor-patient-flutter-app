import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_and_doctor_appointment/services/notification_helper.dart';
import 'package:health_and_doctor_appointment/services/notification_services.dart';

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({Key key}) : super(key: key);

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  TextEditingController medicineController = TextEditingController();
  TextEditingController medicineDescController = TextEditingController();
  NotificationService notificationService;
  int selectedRadioTile;

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  TimeOfDay time = TimeOfDay.now();
  TimeOfDay newTime;
  DateTime dateTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationService = NotificationService();
    notificationService.initialize();
    NotificationsHelper.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medicine Reminder"),
        elevation: 5,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add you medicine Name",
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: medicineController,
                decoration: InputDecoration(
                  hintText: "Add medicine ",
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide()),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide()),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Add you medicine description",
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: medicineDescController,
                decoration: InputDecoration(
                  hintText: "Add Medicine description ",
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide()),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide()),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 120,
                      width: 100,
                      child: Card(
                        child: IconButton(
                          onPressed: () async {
                            newTime = await showTimePicker(
                                context: context, initialTime: time);

                            log(newTime.toString());
                          },
                          icon: Icon(
                            FontAwesome.clock_o,
                            color: Colors.green,
                            size: 70,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 120,
                      width: 100,
                      child: Card(
                        child: IconButton(
                          onPressed: () async {
                            DateTime pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(), //get today's date
                                firstDate: DateTime(
                                    2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101));
                            setState(() {
                              dateTime = pickedDate;
                            });
                            log(dateTime.toString());
                          },
                          icon: Icon(
                            FontAwesomeIcons.calendar,
                            color: Colors.blue,
                            size: 70,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () async {
                    NotificationsHelper.setNotification(dateTime, newTime, 0,
                        title: medicineController.text,
                        body: medicineDescController.text);
                  },
                  child: Text("Add Reminder"),
                  style: ElevatedButton.styleFrom(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
