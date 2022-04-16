
import 'dart:io';

import 'package:flutter/material.dart';



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



  var search_text = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppTheme.green,
      body:Patient(),
      drawer:NavigationDrawer(),
    );
  }




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
      GestureDetector(
        onTap: (){
          print('yrhr');
        },
        child: ListTile(
          title: Text('Profile'),
          leading: Icon(Icons.person_outline),
          onTap: () {
            print('ggg');
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Profile()));
          },
        ),
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
