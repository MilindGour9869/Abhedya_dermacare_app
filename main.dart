
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/classes/AuthPage.dart';
import 'package:flutter_app/screens/forgot_password.dart';
import 'package:flutter_app/screens/login_screen.dart';
import 'package:flutter_app/screens/sign_up_screen.dart';
import 'package:flutter_app/storage/storage.dart';
import 'package:flutter_app/widgets/add_patient.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'default.dart';



//screens
import 'screens/Profile.dart';
import 'screens/Patient.dart';
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

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,

      home: ResponsiveSizer(
        builder: (context, orientation, screenType){


          return HomePage();

        },
      ),


      theme: ThemeData(
        fontFamily: 'Nunito-SemiBold',

      ),


      routes: {
        'Patient' : (context)=>Patient(),
        'Home' : (context)=>HomePage(),
        'Login' : (context) => LoginScreen(),
        'ForgotPassword':(context)=>ForgotPasswordScreen(),
        'AddPatient' : (context)=>AddPatient(),






      },
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

    return StreamBuilder<User>(

      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context,snapshot){

        if(snapshot.hasData)
        {
          return Scaffold(
            backgroundColor: AppTheme.green,
            resizeToAvoidBottomInset: false,
            body: Patient(),
            drawer:MediaQuery(
                data:MediaQuery.of(context).copyWith(textScaleFactor: 1.2),

                child: NavigationDrawer()),


          );
        }
        else{

          return AuthPage();
        }
      },



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
          //  crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 2.h),
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
                                    imagepicker(ImageSource.camera).then((value) {

                                      Navigator.pop(context);
                                    });
                                  },
                                  label: Text(' Camera' ,style: AppTheme.Black,)),
                              TextButton.icon(
                                  icon: Icon(FontAwesomeIcons.photoFilm  , color: AppTheme.green, ),
                                  onPressed: () {
                                    imagepicker(ImageSource.gallery).then((value) {
                                      if(value!=null)
                                        {
                                          Navigator.pop(context);

                                        }
                                    });
                                  },
                                  label: Text(' Gallery' ,style: AppTheme.Black, ))
                            ],
                          )),
                    );
                  },
                  child: ClipOval(
                    child: file == null
                        ? CircleAvatar(
                       radius: 20.w,
                          backgroundColor: AppTheme.grey,
                          child: Icon(
                      Icons.person_add_outlined,
                      color: Colors.white,
                    ),
                        )
                        : Image.file(
                      file,
                      height: 40.w,
                      width: 40.w,
                      fit: BoxFit.cover,
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

      ListTile(
        title: Text('Sign Out' , ),
        leading: Icon(FontAwesomeIcons.signOut ,  color: AppTheme.grey,),
        onTap: ()async {
          await Storage.delete_all_data();
          await Storage.set_guest_false();
          await Storage.set_admin_false();
          await Storage.set_reception_false();


          await FirebaseAuth.instance.signOut();

        },
      )



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
