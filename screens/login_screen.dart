import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/default.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/screens/sign_up_screen.dart';
import 'package:flutter_app/widgets/user_administration.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../storage/storage.dart';

class LoginScreen extends StatefulWidget {

  Function f;
  LoginScreen({this.f});
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


                    txtfield(obsecure:false,text_edit: username_edit, hint: 'Email', keyboard: TextInputType.emailAddress, icon: Icon(Icons.email_outlined , color: username_edit.text.isEmpty?Colors.grey.shade300:Colors.black54, )),
                    txtfield(obsecure:true,text_edit: password_edit, hint: 'Password', keyboard: TextInputType.text, icon: Icon(Icons.lock_open , color: password_edit.text.isEmpty?Colors.grey.shade300:Colors.black54)),

                    GestureDetector(
                      onTap: ()async{

                        Navigator.pushNamed(context, 'ForgotPassword');





                      },
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.w , vertical: 1.h ),
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text('Forgot Password ?' , style: TextStyle(
                            color: AppTheme.teal,
                            fontWeight: FontWeight.w900,

                          ),),
                        ),
                      ),
                    ),


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
                        else
                          {

                          showDialog(context: context, builder: (context)=>UserAdministration()).then((value)async {
                            try{

                              print('svavra');



                              print(value);



                              if(value !='back')
                                {

                                  showDialog(context: context, builder: (context)=>Center(child: CircularProgressIndicator()));

                                  if(value!='guest')
                                  {
                                    await Storage.get_all_cloud_data();
                                  }

                                  await FirebaseAuth.instance.signInWithEmailAndPassword(email: username_edit.text, password: password_edit.text);

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
                      },
                      child: Container(
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

                  child:GestureDetector(
                    onTap: (){

                      widget.f();


                    },
                    child: Padding(
                      padding:  EdgeInsets.symmetric(vertical: 3.w , horizontal: 6.w),
                      child: Text('Sign Up' , style: TextStyle(
                        color: AppTheme.white ,
                        fontWeight: FontWeight.w900,
                      ),),
                    ),
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
    @required this.obsecure,
    @required this.suffix,


  }) : super(key: key);

  TextEditingController text_edit;
  String hint;
  TextInputType keyboard;
  Icon icon;
  bool obsecure;
  bool suffix;

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
        obscureText: widget.obsecure,

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

