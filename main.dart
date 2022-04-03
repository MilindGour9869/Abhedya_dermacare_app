import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:anim_search_bar/anim_search_bar.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import 'default.dart';

//screens
import 'screens/Profile.dart';
import 'screens/Patients.dart';
import 'screens/Medicines.dart';
import 'screens/Services.dart';
import 'screens/Setting.dart';
import 'screens/Reception.dart';
import 'screens/send_feedback.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        fontFamily: 'RobotoSlab-Black.ttf',
      ),
      routes: {},
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.Patients;

  bool a = true;
  var search_text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.Profile) {
      container = Profile();
    } else if (currentPage == DrawerSections.Patients) {
      container = Patient();
    } else if (currentPage == DrawerSections.Medicnes) {
      container = Medicines();
    } else if (currentPage == DrawerSections.Services) {
      container = Services();
    } else if (currentPage == DrawerSections.Settings) {
      container = Setting();
    } else if (currentPage == DrawerSections.Reception) {
      container = Reception();
    } else if (currentPage == DrawerSections.send_feedback) {
      container = SendFeedback();
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppTheme.green,
      body:Patient(),
      drawer:NavigationDrawer(),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
          // shows the list of menu drawer
          children: [
            menuItem(1, "Profile", Icons.person,
                currentPage == DrawerSections.Profile ? true : false),
            Dividerr(),
            menuItem(2, "Patients", Icons.people_alt_outlined,
                currentPage == DrawerSections.Patients ? true : false),
            menuItem(3, "Medicines", Icons.health_and_safety,
                currentPage == DrawerSections.Medicnes ? true : false),
            menuItem(4, "Services", Icons.medication,
                currentPage == DrawerSections.Services ? true : false),
            Dividerr(),
            menuItem(5, "Setting", Icons.settings,
                currentPage == DrawerSections.Settings ? true : false),
            menuItem(6, "Reception", Icons.remove_red_eye,
                currentPage == DrawerSections.Reception ? true : false),
            Dividerr(),
            menuItem(7, "Send Feedback", Icons.call_made_outlined,
                currentPage == DrawerSections.send_feedback ? true : false),
          ]),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.Profile;
            } else if (id == 2) {
              currentPage = DrawerSections.Patients;
            } else if (id == 3) {
              currentPage = DrawerSections.Medicnes;
            } else if (id == 4) {
              currentPage = DrawerSections.Services;
            } else if (id == 5) {
              currentPage = DrawerSections.Settings;
            } else if (id == 6) {
              currentPage = DrawerSections.Reception;
            } else if (id == 7) {
              currentPage = DrawerSections.send_feedback;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  Profile,
  Patients,
  Medicnes,
  Services,
  Settings,
  Reception,
  send_feedback,
}

class NavigationDrawer extends StatefulWidget {
  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  File file;

  Future imagepicker(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);

    if (image == null) return;

    setState(() {
      this.file = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 240),
                              child: Card(
                                child: Column(
                                  children: [
                                    TextButton.icon(
                                        icon: Icon(Icons.camera),
                                        onPressed: () {
                                          imagepicker(ImageSource.camera);
                                        },
                                        label: Text('Camera')),
                                    TextButton.icon(
                                        icon: Icon(Icons.browse_gallery),
                                        onPressed: () {
                                          imagepicker(ImageSource.gallery);
                                        },
                                        label: Text('Gallery'))
                                  ],
                                ),
                              ),
                            ));
                  },
                  child: ClipOval(
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.height * 0.1,
                      child: file == null
                          ? Icon(
                              Icons.person_add_outlined,
                              color: Colors.white,
                            )
                          : Image.file(
                              file,
                              fit: BoxFit.fill,
                            ),
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ),
              ),
              Menu(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget Menu(BuildContext context) {
  return Wrap(
    runSpacing: 7,
    children: [
      ListTile(
        title: Text('Profile'),
        leading: Icon(Icons.person_outline),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Profile()));
        },
      ), // Profile

      Dividerr(),

      ListTile(
        title: Text('Patients'),
        leading: Icon(Icons.people_alt_outlined),
        onTap: () {
         Navigator.pop(context);
        },
      ), // Patient
      ListTile(
        title: Text('Medicine'),
        leading: Icon(Icons.medical_services_outlined),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Medicines()));
        },
      ), // Medicine
      ListTile(
        title: Text('Services'),
        leading: Icon(Icons.room_service),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Services()));
        },
      ), // Services

      Dividerr(),

      ListTile(
        title: Text('Setting'),
        leading: Icon(Icons.settings_accessibility_outlined),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Setting()));
        },
      ),

      ListTile(
        title: Text('Reception'),
        leading: Icon(Icons.remove_red_eye_outlined),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Reception()));
        },
      ),

      Dividerr(),

//      ListTile(
//        title: Text('Services'),
//        leading: Icon(Icons.room_service),
//        onTap: (){
//
//          Navigator.push(context , MaterialPageRoute(builder: (context)=>Services()) );
//        },
//
//      ),
    ],
  );
}

class Dividerr extends StatelessWidget {
  const Dividerr({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(thickness: 2,);
  }
}
