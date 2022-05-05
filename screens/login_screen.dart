import 'package:flutter/cupertino.dart';
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
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 6.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Padding(
                padding:  EdgeInsets.only(top: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        alignment: Alignment.center,

                        height: 25.h,

                        child: Image.asset('images/login_img.jpg')),

                    Container(
                        alignment: Alignment.center,
                        child: Text('Login' , style: TextStyle(

                          fontSize: 40,
                          fontWeight: FontWeight.w900,

                        ),)),


                    txtfield(text_edit: username_edit, hint: 'Username', keyboard: TextInputType.emailAddress, icon: Icon(Icons.email_outlined , color: Colors.grey.shade300, )),
                    txtfield(text_edit: password_edit, hint: 'Password', keyboard: TextInputType.text, icon: Icon(Icons.lock_open , color: Colors.grey.shade300,)),

                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 4.w , vertical: 1.h ),
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text('Forgot Password' , style: TextStyle(
                          color: AppTheme.teal,
                          fontWeight: FontWeight.w900,

                        ),),
                      ),
                    ),


                    Container(
                      height: 8.h,
                      margin: EdgeInsets.symmetric(vertical: 1.5.h),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: AppTheme.green
                      ),
                      child: Center(child: Text('Sign In' , style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.white
                      ),)),
                    ),
                  ],
                ),
              ),


              GestureDetector(
                onTap: (){
                  print('ddd');

                },
                child: Container(

                  decoration: BoxDecoration(
                    color: AppTheme.teal,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    )
                  ),

                  child:Padding(
                    padding:  EdgeInsets.symmetric(vertical: 3.w , horizontal: 6.w),
                    child: Text('Sign Up' , style: TextStyle(
                      color: AppTheme.white ,
                      fontWeight: FontWeight.w900,
                    ),),
                  )
                ),
              ),






            ],
          ),
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
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: TextField(

        controller: widget.text_edit,

        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 7.w , vertical: 2.7.h ),



            hintText: widget.hint,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.grey.shade300
            ),
            enabledBorder: OutlineInputBorder(

              borderSide: BorderSide(
                color: Colors.grey.shade300,
                  
                width: 2,
              ),
              borderRadius: BorderRadius.circular(40),
            ),
            focusedBorder: OutlineInputBorder(

              borderSide: BorderSide(
                color: AppTheme.green,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(40),
            ),

            prefixIcon: widget.icon ,


        ),
        keyboardType: widget.keyboard,
      ),
    );
  }
}

