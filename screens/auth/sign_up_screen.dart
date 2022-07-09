import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/default.dart';
import 'package:flutter_app/main.dart';
import 'login_screen.dart';
import 'user_administration.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../storage/storage.dart';

class SignUpScreen extends StatefulWidget {


  Function f;

  SignUpScreen({this.f});
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  var password_edit = TextEditingController();
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

                        height: 20.h,

                        child: Image.asset('images/login_img.jpg')),

                    Container(
                        alignment: Alignment.center,
                        child: Text('Sign Up' , style: TextStyle(

                          fontSize: 40,
                          fontWeight: FontWeight.w900,

                        ),)),


                    txtfield(text_edit: username_edit, hint: 'Username', keyboard: TextInputType.emailAddress, icon: Icon(Icons.email_outlined , color: username_edit.text.isEmpty?Colors.grey.shade300:Colors.black54, ) , obsecure: false,),
                    txtfield(text_edit: password_edit, hint: 'Password', keyboard: TextInputType.text, icon: Icon(Icons.lock_open , color: password_edit.text.isEmpty?Colors.grey.shade300:Colors.black54) , obsecure: true,),





                    GestureDetector(
                      onTap: ()async{
                        if(username_edit.text.isEmpty || password_edit.text.isEmpty)
                        {
                          showDialog(context: context, builder: (context)=>AlertDialog(
                            title: Text('Credential is not filled' , textScaleFactor: AppTheme.alert,),
                            actions: [
                              TextButton(onPressed: (){
                                Navigator.pop(context);

                              }, child: Text('OK' ,  textScaleFactor: AppTheme.alert,))
                            ],

                          ));

                        }
                        else if(password_edit.text.length<6){
                          showDialog(context: context, builder: (context)=>AlertDialog(
                            title: Text('Password length must be 6 minimum' , textScaleFactor: AppTheme.alert,),
                            actions: [
                              TextButton(onPressed: (){
                                Navigator.pop(context);

                              }, child: Text('OK' ,  textScaleFactor: AppTheme.alert,))
                            ],

                          ));



                        }
                        else
                        {
                          if(EmailValidator.validate(username_edit.text))
                            {

                              showDialog(context: context, builder: (context)=>UserAdministration(

                              )).then((value) async{
                                print('sign up aagssssaye');

                                print(value);





                                try{
                                  if(value !='back')
                                    {
                                      showDialog(context: context, builder: (context)=>Center(child: CircularProgressIndicator()));


                                      if(value!='guest')
                                      {
                                        await Storage.get_all_cloud_data();
                                      }
                                      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: username_edit.text, password: password_edit.text);
                                      navigatorKey.currentState.popUntil( (route) => route.isFirst);
                                    }


                                }
                               on FirebaseAuthException catch(e){

                                 showDialog(context: context, builder: (context)=>AlertDialog(
                                   title: Text(e.toString() , textScaleFactor: AppTheme.alert,),
                                   actions: [
                                     TextButton(onPressed: (){
                                       Navigator.pop(context);

                                     }, child: Text('OK' ,  textScaleFactor: AppTheme.alert,))
                                   ],

                                 ));


                               }





                              });


                            }










                        }
                      },
                      child: Container(
                        height: 8.h,
                        margin: EdgeInsets.symmetric(vertical: 1.5.h),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: AppTheme.green
                        ),
                        child: Center(child: Text('Sign Up' , style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.white
                        ),)),
                      ),
                    ),
                  ],
                ),
              ),


              GestureDetector(
                onTap: (){
                  widget.f();

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
                      child: Text('Sign In' , style: TextStyle(
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
    @required this.obsecure
  }) : super(key: key);

  TextEditingController text_edit;
  String hint;
  TextInputType keyboard;
  Icon icon;
  bool obsecure;

  @override
  State<txtfield> createState() => _txtfieldState();
}

class _txtfieldState extends State<txtfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: Material(
        child: TextField(
          obscureText: widget.obsecure ,

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
      ),
    );
  }
}

