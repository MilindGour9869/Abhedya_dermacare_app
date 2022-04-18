import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/default.dart';
import 'package:flutter_app/screens/Patients.dart';
import 'package:flutter_app/classes/image_picker.dart';

import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'dart:io';

import 'list_search.dart';

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








 Future imagepicker(ImageSource source) async{



   final image = await ImagePicker().pickImage(source: source);

   if(image==null)
     return;

   setState(() {


     this.file = File(image.path);

   });


 }




 bool male = false , female = false;


 @override
 void initState() {
   // TODO: implement initState
   super.initState();
   data  = widget.patient_data;
   print('gbfgf');

   print(widget.all_patient_name_list);
   print(icon_tap);

   patient_list= widget.all_patient_name_list;
   icon_tap= widget.icon_tap;

   print('bgf');
   

   print(patient_list);


   if(data!=null)
   {
     name = data.name;

     setState(() {

       age_edit.text=data.age.toString();
       name_edit.text=data.name.toString();
       mobile_edit.text=data.mobile.toString();

       if(data.group != null)
         {

           data.group.forEach((element) {
             group_edit.text = element + " , " + group_edit.text ;

           });
         }

       if(data.blood_group != null)
         {
           print('data.bloodgroup not emtpy');

           data.blood_group.forEach((element) {
             blood_group_edit.text = element;

           });
         }

       if(data.gender != "")
         {
           print(data.gender);

           if(data.gender == "Male")
            {

              male=true;}
           else if(data.gender == "Female")
             {

               female = true;
             }

         }




     });


   }



 }







 @override
  Widget build(BuildContext context) {







    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back , size: AppTheme.aspectRatio*40,),
          onPressed: (){
            Navigator.pop(context , 'back');
          },
        ),



        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Patient' , style: AppTheme.main_white_30,),
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
                              break;
                            }

                          }
                        }




                       if(isSame && icon_tap)
                         {
                           showDialog(context: context , builder: (context)=>Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 30.0   , vertical: 230),
                             child: Card(

                               child: Column(
                                 children: [
                                   Text('Name is similar to another patient name ' ),
                                   Text('Please change the name' ),
                                 ],
                               ),
                             ),
                           ));
                         }
                       else
                         {
                           print('vrvea');
                           if(icon_tap)
                             {
                               var doc = await FirebaseFirestore.instance.collection('Patient').doc();

                               final json = {
                                 'name':name_edit.text,
                                 'age' : age_edit.text,
                                 'gender':male==true?'Male':female==true?'Female':"",
                                 'address': address_edit.text,
                                 'mobile':mobile_edit.text,
                                 'recent_visit':Timestamp.now(),
                                 'email':email_edit.text,
                                 'id' : doc.id,
                               };

                               doc.set(json);
                             }
                           else if(icon_tap == false)
                             {



                               await FirebaseFirestore.instance.collection('Patient').doc(widget.patient_data.doc_id).update(
                                   {
                                     'name':name_edit.text,
                                     'age' : age_edit.text,
                                     'gender':male==true?'Male':female==true?'Female':"",
                                     'address': address_edit.text,
                                     'mobile':mobile_edit.text,
                                     'recent_visit':Timestamp.now(),
                                     'email':email_edit.text,





                                   });
                             }

                         }

                      Navigator.pop(context , 'save');
                    }
                  else
                    {
                      showDialog(context: context , builder: (context)=>Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0   , vertical: 230),
                        child: Card(

                          child: Column(
                            children: [
                              Text('Name is Compulsory ' ),
                              Text('Please write the name' ),
                            ],
                          ),
                        ),
                      ));

                    }

                },
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                  size: AppTheme.aspectRatio*40,
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
                onTap: (){
                  showDialog(context: context, builder:(context)=>AlertDialog(
                    title: Card(
                      child: Column(
                        children: [
                          TextButton.icon(icon :Icon(Icons.camera) , onPressed: (){
                            imagepicker(ImageSource.camera);

                          }, label: Text('Camera')),
                          TextButton.icon(
                              icon: Icon(Icons.browse_gallery),
                              onPressed: (){
                            imagepicker(ImageSource.gallery);
                          }, label: Text('Gallery'))
                        ],
                      ),
                    ),
                  ));
                },
                child: ClipOval(
                  child: CircleAvatar(
                    radius:MediaQuery.of(context).size.height*0.1,

                    child: file==null?Icon(Icons.person_add_outlined , color: Colors.white,): Image.file(file , fit: BoxFit.fill,),
                    backgroundColor: Colors.grey,

                  ),
                ),
              ),
            ),




            txtfield(text_edit: name_edit, hint: "Name", keyboard: TextInputType.text , icon: Icon(Icons.person_outline),),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ChoiceChip(label: Text('Male' , style: AppTheme.main_black_25), selected:male,selectedColor: Colors.teal,onSelected: (bool selected){
                  setState(() {
                    male=true;
                    female=false;



                  });

                }, ),

                ChoiceChip(label: Text('Female' , style: AppTheme.main_black_25,), selected:female ,selectedColor: Colors.teal,onSelected: (bool a){
                  setState(() {
                    male=false;
                    female=true;

                  });
                }, ),

                SizedBox(
                    width: MediaQuery.of(context).size.width*0.400,
                    height: 9.h,
                    child: TextField(
                      controller: age_edit,
                      style: AppTheme.main_black_25,
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
            txtfield(text_edit: mobile_edit, hint: "Mobile no.", keyboard:TextInputType.number , icon: Icon(Icons.call),),





            Padding(
              padding: EdgeInsets.symmetric(vertical:1.h, horizontal: 6.w),
              child:TextField(
                controller: group_edit,
                autofocus: false,
                style: AppTheme.main_black_25,
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

                    labelText: "Group",
                    prefixIcon: Icon(Icons.medication),
                     // ignore: void_checks
                     suffixIcon: IconButton(icon: Icon(Icons.arrow_drop_down_circle_outlined),onPressed: (){



                     if(name_edit!=null && name_edit.text.isNotEmpty)
                       {
                         return   showDialog(
                             context: context,
                             builder: (context) => Padding(
                               padding: const EdgeInsets.all(20.0),
                               child: ListSearch(group: 'group', Group: 'Group', patient_doc_id: data.doc_id , date: formatDate(data.recent_visit.toDate(), [dd, '-', mm, '-', yyyy ]).toString()),
                             )).then((value){
                               print('ff');

                               setState(() {
                                 group_edit.text ="";
                               });

                               value.forEach((e){
                                 group_edit.text = e + " , " + group_edit.text ;
                               });

                               setState(() {
                                 group_edit = group_edit;

                               });
                         });
                       }
                     else
                       {
                         return showDialog(
                             context: context,
                             builder: (context) =>AlertDialog(
                               title: Text('Please enter Name of Patient'),
                             ));
                       }
                     },)
                ),










              )
            ),

            Padding(
                padding:  EdgeInsets.symmetric(vertical: 1.h , horizontal: 6.w),
                child:TextField(
                  controller: blood_group_edit,
                  autofocus: false,
                  style: AppTheme.main_black_25,

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

                          return   showDialog(
                              context: context,
                              builder: (context) => Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: ListSearch(group: 'blood-group', Group: 'Blood-Group', patient_doc_id: data.doc_id , date: formatDate(data.recent_visit.toDate(), [dd, '-', mm, '-', yyyy ]).toString()),
                              )).then((value){
                            print('ff');

                            value.forEach((e){
                              blood_group_edit.text = e ;
                            });

                            setState(() {
                              blood_group_edit = blood_group_edit;

                            });
                          });
                        }
                        else
                        {
                          return showDialog(
                              context: context,
                              builder: (context) =>AlertDialog(
                                title: Text('Please enter Name of Patient'),
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
          style: AppTheme.main_black_25,
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




