import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_and_doctor_appointment/screens/doctor_tab_page.dart';

class DoctorFormScreen extends StatefulWidget {
  final User doctorUid;
  const DoctorFormScreen({Key key, this.doctorUid}) : super(key: key);

  @override
  State<DoctorFormScreen> createState() => _DoctorFormScreenState();
}

class _DoctorFormScreenState extends State<DoctorFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _closeHour = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _openHour = TextEditingController();
  final TextEditingController _specification = TextEditingController();
  final TextEditingController _type = TextEditingController();
  FocusNode f5 = new FocusNode();
  FocusNode f6 = new FocusNode();
  FocusNode f7 = new FocusNode();
  FocusNode f8 = new FocusNode();
  FocusNode f9 = new FocusNode();
  FocusNode f10 = new FocusNode();
  FocusNode f11 = new FocusNode();
  bool _isSuccess;
  String _selectedItem = 'Cardiologist';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowGlow();
              return;
            },
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
                    child: _doctorForm(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _doctorForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(bottom: 50),
              child: Text(
                'Doctor Form',
                style: GoogleFonts.lato(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            //Address
            //f5
            TextFormField(
              focusNode: f5,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: TextInputType.emailAddress,
              controller: _address,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: 'Address',
                hintStyle: GoogleFonts.lato(
                  color: Colors.black26,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {
                f5.unfocus();
                FocusScope.of(context).requestFocus(f6);
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value.isEmpty) return 'Please enter the Address';
                return null;
              },
            ),
            SizedBox(
              height: 25.0,
            ),
            //opening hour
            //f6
            TextFormField(
              focusNode: f6,
              readOnly: true,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: TextInputType.number,
              controller: _openHour,
              decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipOval(
                    child: Material(
                      color: Colors.indigo, // button color
                      child: InkWell(
                        // inkwell color
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.timer_outlined,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          selectTime(context, _openHour);
                        },
                      ),
                    ),
                  ),
                ),
                contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: 'Opening hours',
                hintStyle: GoogleFonts.lato(
                  color: Colors.black26,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {
                f6.unfocus();
                FocusScope.of(context).requestFocus(f7);
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value.isEmpty) return 'Please enter the Opening Hour';
                return null;
              },
            ),
            SizedBox(
              height: 25.0,
            ),

            //closing Hours
            //f7
            TextFormField(
              focusNode: f7,
              readOnly: true,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: TextInputType.number,
              controller: _closeHour,
              decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipOval(
                    child: Material(
                      color: Colors.indigo, // button color
                      child: InkWell(
                        // inkwell color
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.timer_outlined,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          selectTime(context, _closeHour);
                        },
                      ),
                    ),
                  ),
                ),
                contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: 'Closing Hour',
                hintStyle: GoogleFonts.lato(
                  color: Colors.black26,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {
                f7.unfocus();
                FocusScope.of(context).requestFocus(f8);
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value.isEmpty) return 'Please enter the Closing Hour';
                return null;
              },
            ),
            SizedBox(
              height: 25.0,
            ),
            //phone number
            //f8
            TextFormField(
              focusNode: f8,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: TextInputType.phone,
              controller: _phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: 'Phone Number',
                hintStyle: GoogleFonts.lato(
                  color: Colors.black26,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {
                f8.unfocus();
                FocusScope.of(context).requestFocus(f9);
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value.isEmpty) return 'Please enter the Phone ';
                return null;
              },
            ),
            SizedBox(
              height: 25.0,
            ),

            //City Name
            //f9
            TextFormField(
              focusNode: f9,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: TextInputType.emailAddress,
              controller: _city,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: 'City Name',
                hintStyle: GoogleFonts.lato(
                  color: Colors.black26,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {
                f9.unfocus();
                if (_city.text.isEmpty) {
                  FocusScope.of(context).requestFocus(f10);
                }
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter the City Name';
                }
                return null;
              },
            ),
            SizedBox(
              height: 25.0,
            ),
            //specification
            //f10
            TextFormField(
              focusNode: f10,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              //keyboardType: TextInputType.visiblePassword,
              controller: _specification,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: 'Your Specification',
                hintStyle: GoogleFonts.lato(
                  color: Colors.black26,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {
                f10.unfocus();
                Focus.of(context).requestFocus(f11);
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter the opening hour';
                } else {
                  return null;
                }
              },
              obscureText: true,
            ),
            SizedBox(
              height: 25.0,
            ),
            //type
            //f11

            Container(
              padding: EdgeInsets.all(5),
              width: 400,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[350]),
                  borderRadius: BorderRadius.circular(90.0),
                  color: Colors.grey[350],
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: Colors.black.withOpacity(.2),
                    )
                  ]),
              child: DropdownButton<String>(
                hint: Text('Type'),
                style: GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.black),
                icon: SizedBox(),
                underline: SizedBox(),
                value: _selectedItem,
                onChanged: (String newValue) {
                  setState(() {
                    _selectedItem = newValue;
                    _type.text = newValue;
                  });
                },
                items: <String>[
                  'Cardiologist',
                  'Dentist',
                  'Eye Special',
                  'Orthopaedic',
                  'Paediatrician'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            //Submit Button
            Container(
              padding: const EdgeInsets.only(top: 25.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  child: Text(
                    "Submit ",
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    if (_openHour.text == _closeHour.text) {
                      // showAlertDialog(context,
                      //     "Opening hour and Closing hour can't be same");
                    } else {
                      if (_formKey.currentState.validate()) {
                        showLoaderDialog(context);
                        _registerToFirebase(context);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    primary: Colors.indigo[900],
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
              ),
            ),
            //Divider
            Container(
              padding: EdgeInsets.only(top: 25, left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              child: Divider(
                thickness: 1.5,
              ),
            ),

            // Container(
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 5.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //
            //         TextButton(
            //           style: ButtonStyle(
            //               overlayColor:
            //               MaterialStateProperty.all(Colors.transparent)),
            //          // onPressed: () => _pushPage(context, SignIn()),
            //           child: Text(
            //             'Submit',
            //             style: GoogleFonts.lato(
            //               fontSize: 15,
            //               color: Colors.indigo[700],
            //               fontWeight: FontWeight.w600,
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  TimeOfDay currentTime = TimeOfDay.now();
  Future<void> selectTime(
      BuildContext context, TextEditingController controller) async {
    TimeOfDay selectedTime = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );

    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    String formattedTime = localizations.formatTimeOfDay(selectedTime,
        alwaysUse24HourFormat: false);

    if (formattedTime != null) {
      setState(() {
        controller.text = formattedTime;
      });
    }
  }

  void showDropdown() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select an item'),
          content: DropdownButton<String>(
            value: _selectedItem,
            onChanged: (String newValue) {
              setState(() {
                _selectedItem = newValue;
                _type.text = newValue;
              });
              Navigator.pop(context);
            },
            items: <String>[
              'Cardiologist',
              'Dentist',
              'Eye Special',
              'Orthopaedic',
              'Paediatrician'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _registerToFirebase(BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(widget.doctorUid.uid)
          .set({
        'address': _address.text,
        'openingHour': _openHour.text,
        'closingHour': _closeHour.text,
        'city': _city.text,
        'specification': _specification.text,
        'type': _selectedItem,
        'phone': _phone.text,
      }, SetOptions(merge: true));
      _pushPage(context, DoctorTabPage());

      _isSuccess = false;
    } catch (e) {
      print(e);
    }
  }
}

showAlertDialog(BuildContext context, String text) {
  Navigator.pop(context);
  // set up the button
  Widget okButton = TextButton(
    child: Text(
      "OK",
      style: GoogleFonts.lato(fontWeight: FontWeight.bold),
    ),
    onPressed: () {
      Navigator.pop(context);
      FocusScope.of(context).requestFocus();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Error!",
      style: GoogleFonts.lato(
        fontWeight: FontWeight.bold,
      ),
    ),
    content: Text(
      text ?? "",
      style: GoogleFonts.lato(),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 15), child: Text("Loading...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void _pushPage(BuildContext context, Widget page) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => page),
  );
}
