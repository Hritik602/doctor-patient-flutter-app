import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorSettings extends StatefulWidget {
  @override
  _DoctorSettingsState createState() => _DoctorSettingsState();
}

class _DoctorSettingsState extends State<DoctorSettings> {
  UserDetails detail = new UserDetails();

  FirebaseAuth _auth = FirebaseAuth.instance;
  User user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  Future _signOut() async {
    await _auth.signOut();
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            splashRadius: 25,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.indigo,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: Text(
          'User Settings',
          style: GoogleFonts.lato(
              color: Colors.indigo, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          UserDetails(),
        ],
      ),
    );
  }
}

class UserDetails extends StatefulWidget {
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  Future _signOut() async {
    await _auth.signOut();
  }

  List labelName = [
    'Name',
    'Email',
    'Mobile Number',
    'Bio',
    'Birthday',
    'City',
    'image',
    'address',
    "closeHour",
    "openHour",
    "rating",
    'specification',
    'type'
  ];

  List value = [
    'name',
    'email',
    'phone',
    'bio',
    'birthDate',
    'city',
    'image',
    'address',
    "closeHour",
    "openHour",
    "rating",
    'specification',
    'type'
  ];

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 100,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('doctors')
                  .doc(user.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                var userData = snapshot.data;
                return Container(
                  height: MediaQuery.of(context).size.height - 200,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: List.generate(
                      value.length,
                          (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: InkWell(
                          splashColor: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateUserDetails(
                                      label: labelName[index],
                                      field: value[index],
                                    )));
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[200],
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 14),
                              height: MediaQuery.of(context).size.height / 14,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    labelName[index],
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    userData[value[index]]?.isEmpty ?? true
                                        ? 'Not Added'
                                        : userData[value[index]],
                                    style: GoogleFonts.lato(
                                      color: Colors.black54,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 14),
              height: MediaQuery.of(context).size.height / 14,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueGrey[50],
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login', (Route<dynamic> route) => false);
                  _signOut();
                },
                style: TextButton.styleFrom(primary: Colors.grey),
                child: Text(
                  'Sign out',
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class UpdateUserDetails extends StatefulWidget {
  final String label;
  final String field;
  const UpdateUserDetails({Key key, this.label, this.field}) : super(key: key);

  @override
  _UpdateUserDetailsState createState() => _UpdateUserDetailsState();
}

class _UpdateUserDetailsState extends State<UpdateUserDetails> {
  TextEditingController _textcontroller = TextEditingController();
  FocusNode f1;
  FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  String UserID;

  Future<void> _getUser() async {
    user = _auth.currentUser;
    UserID = user.uid;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.indigo,
          ),
        ),
        title: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.label,
            style: GoogleFonts.lato(
              color: Colors.indigo,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
        child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('doctors')
                  .doc(UserID)
                  .snapshots(),
              builder: (context, snapshot) {
                var userData = snapshot.data;
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _textcontroller,
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    onFieldSubmitted: (String _data) {
                      _textcontroller.text = _data;
                    },
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value.isEmpty)
                        return 'Please Enter the ' + widget.label;
                      return null;
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                await   updateData();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                  primary: Colors.indigo.withOpacity(0.9),
                  onPrimary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                child: Text(
                  'Update',
                  style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> updateData() async {
    FirebaseFirestore.instance.collection('doctors').doc(UserID).set({
      widget.field: _textcontroller.text,
    }, SetOptions(merge: true));
    if (widget.field.compareTo('name') == 0) {
      await user.updateProfile(displayName: _textcontroller.text);
    }
    if (widget.field.compareTo('phone') == 0) {
    }
  }
}
