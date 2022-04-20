
import 'dart:io';

import 'package:flutter/material.dart';



import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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

      home: ResponsiveSizer(
        builder: (context, orientation, screenType){
          return MediaQuery(
              data:MediaQuery.of(context).copyWith(textScaleFactor: 1.2),
              child: HomePage());

        },
      ),
      theme: ThemeData(
        fontFamily: 'Nunito-Regular',

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
                padding:  EdgeInsets.symmetric(vertical: 1.h),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                      title: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton.icon(
                              icon: Icon(FontAwesomeIcons.cameraRetro , color: AppTheme.green, ),
                              onPressed: () {
                                imagepicker(ImageSource.camera);
                              },
                              label: Text(' Camera' ,style: AppTheme.Black,)),
                          TextButton.icon(
                              icon: Icon(FontAwesomeIcons.photoFilm  , color: AppTheme.green, ),
                              onPressed: () {
                                imagepicker(ImageSource.gallery);
                              },
                              label: Text(' Gallery' ,style: AppTheme.Black, ))
                        ],
                      )),
                    );
                  },
                  child: ClipOval(
                    child: CircleAvatar(
                      radius:  AppTheme.circle,
                      child: file == null
                          ? Icon(
                              Icons.person_add_outlined,
                              color: Colors.white,
                            )
                          : Image.file(
                              file,
                              fit: BoxFit.fill,
                            ),
                      backgroundColor: AppTheme.grey,
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
    runSpacing: 2.w,
    children: [
      GestureDetector(
        onTap: (){

        },
        child: ListTile(
          title: Text('Profile'),
          leading: Icon(FontAwesomeIcons.userDoctor , color: AppTheme.green,),
          onTap: () {

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Profile()));
          },
        ),
      ), // Profile

      Dividerr(),

      ListTile(
        title: Text('Patients' , ),
        leading: Icon(FontAwesomeIcons.users , color: AppTheme.teal),
        onTap: () {
         Navigator.pop(context);
        },
      ), // Patient
      ListTile(
        title: Text('Medicine' , ),
        leading: Icon(FontAwesomeIcons.capsules , color: AppTheme.teal ),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Medicines()));
        },
      ), // Medicine
      ListTile(
        title: Text('Services' , ),
        leading: Icon(FontAwesomeIcons.briefcase , color: AppTheme.teal),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Services()));
        },
      ), // Services

      Dividerr(),

      ListTile(
        title: Text('Setting' , ),
        leading: Icon(FontAwesomeIcons.gear , color: AppTheme.grey,),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Setting()));
        },
      ),

      ListTile(
        title: Text('Reception' , ),
        leading: Icon(FontAwesomeIcons.eyeSlash ,  color: AppTheme.grey,),
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
    return Divider(thickness: 0.5.w, color: AppTheme.grey,);
  }
}
