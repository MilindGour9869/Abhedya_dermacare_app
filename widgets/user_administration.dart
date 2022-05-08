import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/default.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../main.dart';
import '../storage/storage.dart';

class UserAdministration extends StatefulWidget {


  @override
  _UserAdministrationState createState() => _UserAdministrationState();
}

class _UserAdministrationState extends State<UserAdministration> {


  var passcode_edit = TextEditingController();
  Map<String , bool> map3={
    'Admin' : true,
    'Reception' : false,
    'Guest' : false,
  };

  bool passcode = false;



  Widget User({@required String user}){
    return Row(

      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 2.w),
          child: GestureDetector(onTap: (){

            setState(() {
              map3.forEach((key, value) {
                map3[key] = false;

              });

              map3['Admin'] = true;

            });
          }, child: Material(
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey,
                        width: 2
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: map3['Admin']?Colors.grey:Colors.transparent

                ),
                child: Padding(
                  padding: const EdgeInsets.all( 1.0),
                  child: Text('Admin' , style: TextStyle(

                      color: map3['Admin']?Colors.white:Colors.grey
                  ),
                    textScaleFactor: AppTheme.list_tile_subtile,



                  ),
                )),
          )),
        ),

        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 2.w),
          child: GestureDetector(onTap: (){

            setState(() {
              map3.forEach((key, value) {
                map3[key] = false;

              });

              map3['Reception'] = true;

            });

          }, child: Material(
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey,
                        width: 2
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: map3['Reception']?Colors.grey:Colors.transparent

                ),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Text('Reception' , style: TextStyle(

                      color: map3['Reception']?Colors.white:Colors.grey
                  ),
                    textScaleFactor: AppTheme.list_tile_subtile,
                  ),
                )),
          )),
        ),

        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 2.w),
          child: GestureDetector(onTap: (){

            setState(() {
              map3.forEach((key, value) {
                map3[key] = false;

              });

              map3['Guest'] = true;

            });
          }, child: Material(
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey,
                        width: 2
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: map3['Guest']?Colors.grey:Colors.transparent

                ),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Text('Guest' , style: TextStyle(

                      color: map3['Guest']?Colors.white:Colors.grey
                  ),

                    textScaleFactor: AppTheme.list_tile_subtile,


                  ),
                )),
          )),
        )
      ],
    );
  }




  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 2.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              borderRadius: BorderRadius.circular(5),
              child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(bottom: 3.w),
                        child: Center(
                          child: Text('Login As :' , style: TextStyle(
                            fontWeight: FontWeight.w900
                          ),),
                        ),
                      ),

                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: 2.w),
                        child: User(),
                      ),

                      Visibility(
                        visible:!map3['Guest'] ,
                        child: Padding(
                          padding:  EdgeInsets.symmetric(vertical: 2.w),
                          child: Center(
                            child: Container(
                                width: 41.w,



                                child: TextField(
                                  controller: passcode_edit,

                                  decoration: InputDecoration(


                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 2,),
                                      borderRadius: BorderRadius.circular(10),),

                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.teal,
                                        width: 2,),
                                      borderRadius: BorderRadius.circular(10),),

                                    hintText: "Passcode",
                                    prefixIcon: Icon(Icons.lock_outline),







                                  )
                                  ,
                                  keyboardType: TextInputType.number,
                                ),




                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: 2.w),
                        child: Center(child: GestureDetector(
                          onTap: ()async {



                            if(map3['Guest'])
                              {
                                await Storage.set_guest_true();
                                Navigator.pop(context , 'guest');
                              }
                            else
                              {
                               if(passcode_edit.text.isNotEmpty )
                                 {
                                   String collection ;
                                   map3.forEach((key, value) async{
                                     if(value)
                                       {
                                         collection = key;
                                       }

                                   });

                                     collection!=null?await FirebaseFirestore.instance.collection('Administration').doc(collection).get().then((value)async  {

                                       print(value['passcode']);


                                       if(value['passcode'].toString() == passcode_edit.text)
                                       {  print('ffff');

                                       Navigator.pop(context);


                                       }
                                       else
                                       {
                                         showDialog(context: context, builder: (context)=>AlertDialog(
                                           title: Text('Invalid Passcode' , textScaleFactor: AppTheme.alert,),
                                           actions: [
                                             TextButton(onPressed: (){
                                               Navigator.pop(context);

                                             }, child: Text('OK' ,  textScaleFactor: AppTheme.alert,))
                                           ],
                                         ));

                                       }

                                       print(passcode);



                                     }):null;






                                 }
                               else
                                 {
                                   showDialog(context: context, builder: (context)=>AlertDialog(
                                     title: Text('Passcode is Required' , textScaleFactor: AppTheme.alert,),
                                     actions: [
                                       TextButton(onPressed: (){
                                         Navigator.pop(context);

                                       }, child: Text('OK' ,  textScaleFactor: AppTheme.alert,))
                                     ],

                                   ));
                                 }






                              }






                          },
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppTheme.teal
                              ),
                              padding: EdgeInsets.all(2.w),
                              child: Text('Login In' , style: TextStyle(
                                color: Colors.white
                              ),)),
                        )),
                      )
                    ],
                  )
              ),
            )




          ],
        ),
      ),
    );

  }
}
