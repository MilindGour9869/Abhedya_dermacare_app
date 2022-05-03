import 'package:flutter/material.dart';
import 'package:flutter_app/default.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var password_edit = TextEditingController();
  var username_edit = TextEditingController();
  var passcode_edit = TextEditingController();

  Map<String , bool> map={

  'Admin':false,
  'Reception' :false,
  'Guest' :false,
};

  Widget User({@required String user}){
    return TextButton.icon(onPressed: (){
      setState(() {

        map[user]=!map[user];


      });
    }, icon: Icon(Icons.adjust , color: map[user]?AppTheme.green:Colors.grey,), label: Text(user , style: TextStyle(color: map[user]?AppTheme.green:Colors.black),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 6.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(

              height: 20.h,

                child: Image.asset('images/logo_without_background.png')),

            txtfield(text_edit: username_edit, hint: 'Username', keyboard: TextInputType.emailAddress, icon: Icon(Icons.email_outlined)),
            txtfield(text_edit: password_edit, hint: 'Password', keyboard: TextInputType.text, icon: Icon(Icons.lock_open)),
            Column(
              children: [
                Text('Login As :'),

                User(user: 'Admin'),
                User(user: 'Reception'),
                User(user: 'Guest'),




              ],
            ),


            txtfield(text_edit: password_edit, hint: 'Passcode', keyboard: TextInputType.text, icon: Icon(Icons.lock_open)),




          ],
        ),
      ),
    );
  }
}

class txtfield extends StatefulWidget {
  txtfield({
    Key key,
    @required this.text_edit,
    @required this.hint,
    @required this.keyboard,
    @required this.icon,
  }) : super(key: key);

  TextEditingController text_edit;
  String hint;
  TextInputType keyboard;
  Icon icon;

  @override
  State<txtfield> createState() => _txtfieldState();
}

class _txtfieldState extends State<txtfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: TextField(
        controller: widget.text_edit,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.teal,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            labelText: widget.hint,
            prefixIcon: widget.icon),
        keyboardType: widget.keyboard,
      ),
    );
  }
}

