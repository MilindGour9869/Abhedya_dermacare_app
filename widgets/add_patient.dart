import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

import 'list_search.dart';

import 'package:flutter_app/classes/Patient_name_list.dart';




class AddPatient extends StatefulWidget {

  Patient_name_data_list patient_data;

  AddPatient({this.patient_data });




  @override
  _AddPatientState createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {

 File file;

 String name='';

 Patient_name_data_list data;

 var name_edit = TextEditingController();
 var age_edit = TextEditingController();
 var address_edit = TextEditingController();
 var email_edit = TextEditingController();
 var mobile_edit = TextEditingController();
 var group_edit = TextEditingController();
 var blood_group_edit=TextEditingController();



 Future imagepicker() async{

   final image = await ImagePicker().pickImage(source: ImageSource.camera);

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

   if(data!=null)
   {
     setState(() {

       age_edit.text=data.age.toString();
       name_edit.text=data.name.toString();
       mobile_edit.text=data.mobile.toString();




     });


   }



 }







 @override
  Widget build(BuildContext context) {







    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Patient'),
            IconButton(
                onPressed: () async {

                  if(name_edit.text!=null)
                    {
                       await FirebaseFirestore.instance.collection('Patient').doc(name_edit.text).set({
                        'name':name_edit.text,
                        'age' : age_edit.text==null?"":age_edit.text,
                        'gender':male==true?'Male':female==true?'Female':"",
                        'address': address_edit.text==null?"":address_edit.text,

                      });
                      Navigator.pop(context);
                    }
                  else
                    {

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
            SizedBox(height: 20,),
            CircleAvatar(
              radius:MediaQuery.of(context).size.height*0.1,

              child: file==null?Icon(Icons.person_add_outlined , color: Colors.white,):Image.file(file),
              backgroundColor: Colors.grey,
            ),
            SizedBox(height: 5,),



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

                ChoiceChip(label: Text('Female'), selected:female ,selectedColor: Colors.teal,onSelected: (bool a){
                  setState(() {
                    male=false;
                    female=true;

                  });
                }, ),

                SizedBox(
                    width: MediaQuery.of(context).size.width*0.400,
                    height: 70,
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
            txtfield(text_edit: mobile_edit, hint: "Mobile no.", keyboard:TextInputType.number , icon: Icon(Icons.call),),
            SizedBox(height: 10,),




            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0 , horizontal: 20),
              child:TextField(
                autofocus: false,
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

                    hintText: "Group",
                    prefixIcon: Icon(Icons.medication),
                     suffixIcon: IconButton(icon: Icon(Icons.arrow_drop_down_circle_outlined),onPressed: (){



                     if(name_edit!=null && name_edit.text.isNotEmpty)
                       {
                         return   showDialog(
                             context: context,
                             builder: (context) => Padding(
                               padding: const EdgeInsets.all(20.0),
                               child: ListSearch(group: 'group', Group: 'Group', name: name_edit.text),
                             ));
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
                padding: const EdgeInsets.symmetric(vertical: 8.0 , horizontal: 20),
                child:TextField(

                  autofocus: false,
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

                      hintText: "Blood-group",
                      prefixIcon: Icon(Icons.water_drop_outlined),
                      // ignore: void_checks
                      suffixIcon: IconButton(icon: Icon(Icons.arrow_drop_down_circle_outlined),onPressed: (){

                        if(name_edit!=null && name_edit.text.isNotEmpty )
                        {
                          return   showDialog(
                              context: context,
                              builder: (context) => Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: ListSearch(group: 'blood-group', Group: 'Blood-Group', name: name_edit.text,),
                              ));
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



            SizedBox(height: 10,),


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
      padding: const EdgeInsets.symmetric(vertical: 8.0 , horizontal:  20),
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

              hintText: widget.hint,
          prefixIcon: widget.icon),


        keyboardType: widget.keyboard ,






      ),
    );
  }
}

//class Search extends SearchDelegate<String> {
//
//
//
//
//
//  @override
//  List<Widget> buildActions(BuildContext context) {
//    return [
//      IconButton(
//        icon: Icon(Icons.clear),
//        onPressed: () {
//
//        },
//      )
//    ];
//  }
//
//  @override
//  Widget buildLeading(BuildContext context) {
//    return null;
//  }
//
//  @override
//  Widget buildResults(BuildContext context) {
//    return null;
//  }
//
//  @override
//  Widget buildSuggestions(BuildContext context) {
//    final suggestions = query.isEmpty ? ['qq' , 'ecc' , 'ec']: [];
//    return Container(
//      height: 200,
//
//      child: ListView.builder(
//        itemCount: suggestions.length,
//        itemBuilder: (content, index) => ListTile(
//            leading: IconButton(
//              icon: Icon(Icons.adjust),
//              onPressed: (){
//                group_tap=!group_tap;
//
//
//              },
//            ), title: Text(suggestions[index])),
//      ),
//    );
//  }
//}
