import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/default.dart';
import 'package:flutter_app/list_search/blood_group_list_search.dart';


import 'package:email_validator/email_validator.dart';
import 'package:flutter_app/storage/cloud_storage.dart';
import 'package:flutter_app/widgets/stream_builder.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'dart:io';



import 'package:flutter_app/classes/Patient_name_list.dart';




class AddPatient extends StatefulWidget {

  Patient_name_data_list patient_data;

  List all_patient_name_list=[];

  bool icon_tap = false ;


  AddPatient({this.patient_data , this.all_patient_name_list , this.icon_tap = false });




  @override
  _AddPatientState createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {

 File file;

 String name='';

 Patient_name_data_list data;
 List patient_list ;
 bool icon_tap = false;






 var name_edit = TextEditingController();
 var age_edit = TextEditingController();
 var address_edit = TextEditingController();
 var email_edit = TextEditingController();
 var mobile_edit = TextEditingController();
 var group_edit = TextEditingController();
 var blood_group_edit=TextEditingController();

 String profile_link ;

 bool profile_img_delete = false;

 String one_result;

 bool circle = true;











 Future imagepicker(ImageSource source) async{



   final image = await ImagePicker().pickImage(source: source , imageQuality: 50);

   if(image==null)
     return null;

   setState(() {


     this.file = File(image.path);
     profile_link = "";

   });

   return 'change';



 }






 bool male = false , female = false;


 @override
 void initState() {
   // TODO: implement initState
   super.initState();

   print('gbfgf');



   print(widget.all_patient_name_list);
   print(icon_tap);

   patient_list= widget.all_patient_name_list;
   icon_tap= widget.icon_tap;

   print('bgf');
   

   print(patient_list);


   if(widget.patient_data!=null)
   {
     name = widget.patient_data.name;

     print('hhh');

     print(widget.patient_data.profile_link.toString());


     setState(() {

       print('vb vbvb');


       print(widget.patient_data.age);


       age_edit.text=widget.patient_data.age==0?"":widget.patient_data.age.toString();
       name_edit.text=widget.patient_data.name.toString();
       mobile_edit.text=widget.patient_data.mobile==0?"":widget.patient_data.mobile.toString();



       if(widget.patient_data.blood_group != null)
         {
           print('data.bloodgroup not emtpy');

           blood_group_edit.text  = widget.patient_data.blood_group.isNotEmpty?widget.patient_data.blood_group:"Blood Group";
           one_result =widget.patient_data.blood_group;

         }

       if(widget.patient_data.gender != null)
         {
           print(widget.patient_data.gender);

           if(widget.patient_data.gender == "Male")
            {

              male=true;}
           else if(widget.patient_data.gender == "Female")
             {

               female = true;
             }

         }

       if(widget.patient_data.profile_link !=null)
         {
           profile_link = widget.patient_data.profile_link.isEmpty?null:widget.patient_data.profile_link ;



         }




     });


   }



 }







 @override
  Widget build(BuildContext context) {







    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.teal,
          leading: IconButton(
            icon: Icon(Icons.arrow_back ,),
            onPressed: (){
              Navigator.pop(context , 'back');
            },
          ),



          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Patient'),
              IconButton(
                  onPressed: () async {

                    print(Timestamp.now());
                    print(icon_tap);

                    print(age_edit.text);






                    if(name_edit.text!=null && name_edit.text.isNotEmpty)
                      {
                        bool isSame = false ;

                        if(icon_tap)
                          {
                            for(int i =0 ;i<patient_list.length ;i++)
                            {
                              if(name_edit.text == patient_list[i])
                              {
                                isSame = true;

                                print('\nisa same is trueee');

                                break;
                              }

                            }
                          }

                        print(isSame);





                         if(isSame && icon_tap)
                           {
                             print('in if ');


                            return  showDialog(context: context , builder: (context)=>AlertDialog(
                               title: Text('Name is similar to another patient\nPlease change the name'  ),
                               actions: [
                                 TextButton(onPressed: (){
                                   Navigator.pop(context);

                                 }, child: Text('OK' ,  textScaleFactor: AppTheme.alert,))
                               ],

                             ));
                           }


                         else
                         {
                           print('show dialogue ');

                         showDialog(context: context, builder: (context)=>Center(child: CircularProgressIndicator()));



                             if(email_edit.text.isNotEmpty)
                             {
                               if(!EmailValidator.validate(email_edit.text))
                               {
                                 showDialog(context: context, builder: (context)=>AlertDialog(
                                   title: Text('Invalid Email ID'),
                                   actions: [
                                     TextButton(onPressed: (){
                                       Navigator.pop(context);

                                     }, child: Text('OK' , textScaleFactor: AppTheme.alert,))
                                   ],
                                 ));

                               }
                             }
                             if(mobile_edit.text.isNotEmpty){

                               print('in else if');


                               if(mobile_edit.text.length!=10)
                               {
                                 showDialog(context: context, builder: (context)=>AlertDialog(
                                   title: Text('Invalid Mobile No.' ,  textScaleFactor: AppTheme.alert,),
                                   actions: [
                                     TextButton(onPressed: (){
                                       Navigator.pop(context);

                                     }, child: Text('OK' , textScaleFactor: AppTheme.alert,))
                                   ],
                                 ));

                               }


                             }





                             if(icon_tap)
                             {
                               var doc = await FirebaseFirestore.instance.collection('Patient').doc();
                               if(file!=null)
                               {

                                 print('file no null');





                               var link = Cloud_Storage.Patient_Profile_Image_Upload(
                                 doc_id:  doc.id,
                                 file: file,
                               );

                               final snapshot =   await link.whenComplete((){});



                               profile_link =  await snapshot.ref.getDownloadURL();

                               }


                               final json = {
                                 'name':name_edit.text,
                                 'age' : age_edit.text,
                                 'gender':male==true?'Male':female==true?'Female':"",
                                 'address': address_edit.text,
                                 'mobile':mobile_edit.text,
                                 'recent_visit':Timestamp.now(),
                                 'email':email_edit.text,
                                 'doc_id' : doc.id,
                                 'blood_group':blood_group_edit.text,
                                 'profile_link' : profile_link==null?"":profile_link,


                               };

                               doc.set(json);
                             }
                             else if(icon_tap == false)
                             {

                               if(file!=null)
                               { print('file no null');

                               var link = Cloud_Storage.Patient_Profile_Image_Upload(
                                 doc_id: widget.patient_data.doc_id ,
                                 file: file,
                               );


                               final snapshot = await link.whenComplete((){});

                               profile_link = await snapshot.ref.getDownloadURL();








                               }



                               await FirebaseFirestore.instance.collection('Patient').doc(widget.patient_data.doc_id).update(
                                   {
                                     'name':name_edit.text,
                                     'age' : age_edit.text,
                                     'gender':male==true?'Male':female==true?'Female':"",
                                     'address': address_edit.text,
                                     'mobile':mobile_edit.text,
                                     'recent_visit':Timestamp.now(),
                                     'email':email_edit.text,
                                     'blood_group':blood_group_edit.text,
                                     'profile_link' : profile_link==null?"":profile_link,





                                   });
                             }


                         Navigator.popUntil(context,(route)=>route.isFirst);







                         }


                      }
                    else
                      {
                        return showDialog(context: context , builder: (context)=>AlertDialog(

                          title: Text('Name is Compulsory\nPlease write the name'  , textScaleFactor: AppTheme.alert,),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.pop(context);

                            }, child: Text('OK' ,  textScaleFactor: AppTheme.alert,))
                          ],
                        ));

                      }

                  },
                  icon: Icon(
                    Icons.save,
                    color: Colors.white,

                  ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(



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


                              imagepicker(ImageSource.camera);
                              Navigator.pop(context);
                            },
                            label: Text(' Camera' ,style: AppTheme.Black,)),
                        TextButton.icon(
                            icon: Icon(FontAwesomeIcons.photoFilm  , color: AppTheme.green, ),
                            onPressed: () {

                              imagepicker(ImageSource.gallery);
                              Navigator.pop(context);
                            },
                            label: Text(' Gallery' ,style: AppTheme.Black, ))
                      ],
                    )),
              );
            },

            onDoubleTap: (){
              setState(() {
                profile_img_delete = !profile_img_delete;

              });
            },


            child: ClipOval(
              child: profile_link == null
                  ? CircleAvatar(
                backgroundColor: AppTheme.grey,
                radius: 20.w,
                child: Icon(
                  Icons.person_add_outlined,
                  color: Colors.white,
                ),
              )
                  :  file!=null?Image.file(
                file,
                fit: BoxFit.cover,
                height: 40.w,
                width: 40.w,
              ):Image.network(
                profile_link ,
                height: 40.w,
                width: 40.w,
                fit: BoxFit.fill,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes
                          : null,
                    ),
                  );
                },
              ),
            ),
          ),
        ),

              Visibility(
                visible: profile_img_delete,
                child: CircleAvatar(
                  backgroundColor: AppTheme.white,
                  child: IconButton(
                    onPressed: (){

                      setState(() {

                        profile_link.isNotEmpty?FirebaseStorage.instance.refFromURL(profile_link).delete():null;

                        profile_link=null;
                        file=null;
                        profile_img_delete=false;


                      });
                    },
                    icon: Icon(Icons.delete_outline_outlined ,color: Colors.red,),
                  ),
                ),
              ),




              txtfield(text_edit: name_edit, hint: "Name", keyboard: TextInputType.text , icon: Icon(Icons.person_outline),),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ChoiceChip(label: Text('Male'), selected:male,selectedColor: Colors.teal,onSelected: (bool selected){
                    setState(() {
                      male=true;
                      female=false;



                    });

                  }, ),

                  ChoiceChip(label: Text('Female' , ), selected:female ,selectedColor: Colors.teal,onSelected: (bool a){
                    setState(() {
                      male=false;
                      female=true;

                    });
                  }, ),

                  Container(
                    width: 39.w,


                      child: TextField(
                        controller: age_edit,

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

                            hintText: "Age",
                            prefixIcon: Icon(Icons.cake_outlined),







                      )
                      ,
                        keyboardType: TextInputType.number,
                      )

                  ),


                ],
              ),


              txtfield(text_edit: address_edit, hint: "Address", keyboard: TextInputType.text , icon: Icon(Icons.place_outlined), ),
              txtfield(text_edit: email_edit, hint: "Email", keyboard:TextInputType.emailAddress , icon: Icon(Icons.email),),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 6.w , vertical: 1.h),
                child: TextField(
                  controller: mobile_edit,

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

                      labelText: 'Mobile no.',
                      prefixIcon: Icon(Icons.call)),


                  keyboardType: TextInputType.number,
                  maxLength: 10,








                ),
              ),


              Padding(
                  padding:  EdgeInsets.symmetric(vertical: 1.h , horizontal: 6.w),
                  child:TextField(
                    controller: blood_group_edit,
                    autofocus: false,

                    readOnly: true,

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

                        labelText: "Blood Group",
                        prefixIcon: Icon(Icons.medication),
                        // ignore: void_checks
                        suffixIcon: IconButton(icon: Icon(Icons.arrow_drop_down_circle_outlined),onPressed: (){

                          setState(() {
                            blood_group_edit.text ="";

                          });



                          if(name_edit!=null && name_edit.text.isNotEmpty)
                          {
                            print('fff');


                            print(blood_group_edit.text);


                            return   showDialog(
                                context: context,
                                builder: (context) => Padding(
                                  padding:  EdgeInsets.all(4.w),
                                  child: Blood_Group_List_Search(
                                    result: [one_result
                                    ],
                                  ),
                                )).then((value){
                              print('ff');

                              if(value!=null)
                                {
                                  if(value.isNotEmpty)
                                    {
                                      print('dvfbabfds');

                                      setState(() {
                                        blood_group_edit.text = value[0];
                                        one_result = value[0];




                                      });
                                    }
                                }




                            });
                          }
                          else
                          {
                            return showDialog(
                                context: context,
                                builder: (context) =>AlertDialog(
                                  title: Text('Please enter Name of Patient'  , textScaleFactor: AppTheme.alert,),
                                  actions: [
                                    TextButton(onPressed: (){
                                      Navigator.pop(context);

                                    }, child: Text('OK' ,  textScaleFactor: AppTheme.alert,))
                                  ],
                                ));
                          }
                        },)
                    ),










                  )
              ),










//            SizedBox(height: 5,),
//            Padding(
//              padding: const EdgeInsets.symmetric(horizontal: 8.0),
//              child: Divider( color: Colors.grey,thickness: 0.5,),
//            ),





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
      padding:  EdgeInsets.symmetric(vertical: 1.h, horizontal:  6.w),
      child: TextField(
        controller: widget.text_edit,

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

              labelText: widget.hint,
          prefixIcon: widget.icon),


        keyboardType: widget.keyboard ,







      ),
    );
  }
}




