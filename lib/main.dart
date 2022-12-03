import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_and_doctor_appointment/mainPage.dart';
import 'package:health_and_doctor_appointment/screens/doctorProfile.dart';
import 'package:health_and_doctor_appointment/screens/doctor_form_screen.dart';
import 'package:health_and_doctor_appointment/screens/doctor_home_screen.dart';
import 'package:health_and_doctor_appointment/screens/firebaseAuth.dart';
import 'package:health_and_doctor_appointment/screens/myAppointments.dart';
import 'package:health_and_doctor_appointment/screens/skip.dart';
import 'package:health_and_doctor_appointment/screens/userProfile.dart';
import 'package:health_and_doctor_appointment/screens/doctor_tab_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'chat_room/firebase_helper.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}




class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isDr = false;
  bool isPatient = false;
  Future<void> _getUser() async {
    user = _auth.currentUser;
    await getUserType();
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  getUserType() async{

    await FirebaseFirestore.instance.collection('doctors').where('uuid', isEqualTo: user.uid)
        .snapshots().listen(
            (data) {
          if(data.docs.isEmpty){
            isDr = false;
          }else {
            isDr = true;
          }
        }
    );

    await FirebaseFirestore.instance.collection('Patient').where('uuid', isEqualTo: user.uid)
        .snapshots().listen(
            (data) {
          if(data.docs.isEmpty){
            isPatient = false;
          }else {
            isPatient = true;
          }
        }
    );
  }

  Widget getHomeScreen (){
    if(isDr){
      return DoctorTabPage();
    }else if(isPatient) {
      return MainPage();
    }else {
      return FireBaseAuth();
    }
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ChatProvider>(
          create: (_) => ChatProvider(),
        ),
      ],
      child:MaterialApp(
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => user == null ? Skip() : getHomeScreen(),
          '/login': (context) => FireBaseAuth(),
          '/home': (context) => MainPage(),
          '/profile': (context) => UserProfile(),
          '/MyAppointments': (context) => MyAppointments(),
          '/DoctorProfile': (context) => DoctorProfile(),
          '/DoctorTabScreen': (context) => DoctorTabPage(),
          '/DoctorFormScreen': (context) => DoctorFormScreen(),
        },
        theme: ThemeData(brightness: Brightness.light),
        debugShowCheckedModeBanner: false,
        //home: FirebaseAuthDemo(),
      ),
    );
  }
}


