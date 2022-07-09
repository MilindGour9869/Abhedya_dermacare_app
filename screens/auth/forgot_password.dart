import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/default.dart';
import 'package:flutter_app/main.dart';
import 'sign_up_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ForgotPasswordScreen extends StatefulWidget {

  Function f;
  ForgotPasswordScreen({this.f});
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {


  var username_edit = TextEditingController();





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
                        child: Text('Enter Email Id' , style: TextStyle(

                          fontSize: 30,
                          fontWeight: FontWeight.w900,

                        ),)),


                    txtfield(text_edit: username_edit, hint: 'Email', keyboard: TextInputType.emailAddress, icon: Icon(Icons.email_outlined , color: username_edit.text.isEmpty?Colors.grey.shade300:Colors.black54, )),

                    GestureDetector(
                      onTap: ()async{

                        if(username_edit.text.isNotEmpty)
                          {
                           if( EmailValidator.validate(username_edit.text))
                           {
                            try{
                              await FirebaseAuth.instance.sendPasswordResetEmail(email: username_edit.text).then((value) {


                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email sent to the given Email ID ...')));


                              });
                            }
                            on
                                FirebaseAuthException
                            catch(e){
                              showDialog(context: context, builder: (context)=>AlertDialog(
                                title: Text( 'Invalid Email Address , Email Address does not Exist ' , textScaleFactor: AppTheme.alert,),
                                actions: [
                                  TextButton(onPressed: (){
                                    Navigator.pop(context);

                                  }, child: Text('OK' ,  textScaleFactor: AppTheme.alert,))
                                ],

                              ));

                            }
                           }
                           else
                             {

                               showDialog(context: context, builder: (context)=>AlertDialog(
                                 title: Text('Invalid Email Address ' , textScaleFactor: AppTheme.alert,),
                                 actions: [
                                   TextButton(onPressed: (){
                                     Navigator.pop(context);

                                   }, child: Text('OK' ,  textScaleFactor: AppTheme.alert,))
                                 ],

                               ));

                             }
                          }
                        else
                          {
                            showDialog(context: context, builder: (context)=>AlertDialog(
                              title: Text('Email is required' , textScaleFactor: AppTheme.alert,),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.pop(context);

                                }, child: Text('OK' ,  textScaleFactor: AppTheme.alert,))
                              ],

                            ));

                          }





                      },
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.w , vertical: 1.h ),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            color: AppTheme.teal,
                            borderRadius: BorderRadius.circular(5),

                          ),
                          child: Text('Reset Password' , style: TextStyle(
                            color: AppTheme.white,


                          ),),
                        ),
                      ),
                    ),



                  ],
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
              color: widget.text_edit.text.isEmpty?Colors.grey.shade300:AppTheme.green,

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

