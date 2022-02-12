import 'package:flutter/material.dart';

import 'package:anim_search_bar/anim_search_bar.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'default.dart';

//screens
import 'screens/Profile.dart';
import 'screens/Patients.dart';
import 'screens/Medicines.dart';
import 'screens/Services.dart';
import 'screens/Setting.dart';
import 'screens/Reception.dart';
import 'screens/send_feedback.dart';


void main() async{
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
    }  else if (currentPage == DrawerSections.send_feedback) {
      container = SendFeedback();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,

        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimSearchBar(
                color: Color(0xFFEDF0F2),
                closeSearchOnSuffixTap: true,
                autoFocus: true,
                style: TextStyle(

                ),
                animationDurationInMilli: 150,





                width: MediaQuery.of(context).size.width*0.75,
                textController: search_text,
                onSuffixTap:(){
                  print('evv');
                }

            ),
          ],
        )
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
      child: Container(

      child: Column(
        children: [
        Container(
        height: 200,
        color: Colors.red,
          child: CircleAvatar(
            radius: MediaQuery.of(context).size.width*0.150,
            child: Icon(Icons.adjust ,color: Colors.red,),
          ),
      ),
      MyDrawerList(),
      ],
    ),
    ))
      ),
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
      Divider(),
      menuItem(2, "Patients", Icons.people_alt_outlined,
          currentPage == DrawerSections.Patients? true : false),
      menuItem(3, "Medicines", Icons.health_and_safety,
          currentPage == DrawerSections.Medicnes? true : false),
      menuItem(4, "Services", Icons.medication,
          currentPage == DrawerSections.Services ? true : false),
      Divider(),
      menuItem(5, "Setting", Icons.settings,
          currentPage == DrawerSections.Settings ? true : false),

      menuItem(6, "Reception", Icons.remove_red_eye,
          currentPage == DrawerSections.Reception ? true : false),
      Divider(),
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
