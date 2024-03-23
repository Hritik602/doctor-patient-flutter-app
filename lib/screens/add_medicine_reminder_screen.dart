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
  // NotificationService notificationService;
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
    // notificationService = NotificationService();
    // notificationService.initialize();
    // NotificationsHelper.init();
  }

  Set<MedicineReminder> medicineReminder = {};

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Medicine Reminder",
        ),
        elevation: 5,
        backgroundColor: Colors.lightBlueAccent,
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
                    var medicineData = MedicineReminder(
                        medicineName: medicineController.text,
                        medicineDesc: medicineDescController.text,
                        newTime: newTime,
                        dateTime: dateTime);
                    medicineReminder.add(medicineData);
                    setState(() {});
                  },
                  child: Text("Add Reminder"),
                  style: ElevatedButton.styleFrom(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              medicineReminder.isNotEmpty
                  ? SizedBox(
                      height: size.height,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: medicineReminder.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text(medicineReminder
                                    .toList()[index]
                                    .medicineName),
                                subtitle: Text(medicineReminder
                                        .toList()[index]
                                        .medicineDesc +
                                    " " +
                                    newTime.format(context)),
                                trailing: IconButton(
                                  onPressed: () {
                                    medicineReminder.remove(
                                        medicineReminder.toList()[index]);
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              ),
                            );
                          }))
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class MedicineReminder {
  String medicineName;
  String medicineDesc;
  TimeOfDay newTime;
  DateTime dateTime;
  MedicineReminder(
      {this.medicineName, this.medicineDesc, this.newTime, this.dateTime});
}
