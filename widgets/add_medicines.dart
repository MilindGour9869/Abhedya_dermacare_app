import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/default.dart';
import 'package:flutter_app/widgets/list_search.dart';

import 'package:date_format/date_format.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

import 'package:flutter_app/widgets/try_list_search.dart';



class AddMedicine extends StatefulWidget {

  String composition , company_name , tab , doc_id , medicine_name ;

  AddMedicine({this.company_name , this.composition , this.tab ,this.doc_id , this.medicine_name});

  @override
  _AddMedicineState createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {


  String composition= "Composition";
  String company_name ="Company Name";
  String tab = "TAB/CAP/SYP";

  List<String> Tab = [];




  var medicine_name_edit=TextEditingController();
  var medicine_notes=TextEditingController();

  Map<String  , Map<String , dynamic>> json ={};

  DropdownMenuItem<String> Menu(String item)
  {
    return DropdownMenuItem(

      value: item,
      child: Text(item),

    );

  }

  String value;






  Map<String,bool> map ={

    'composition' : false,
    'company_name':false,
    'tab':false,

  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();



    if(widget.composition != null)
      {
        setState(() {
          composition = widget.composition;
          map['composition'] = true;



        });
      }
    if(widget.company_name != null)
    {
      setState(() {

        company_name=widget.company_name;
        map['company_name']=true;



      });
    }
    if(widget.tab != null)
    {
      setState(() {

        tab=widget.tab;
        map['tab'] = true;


      });
    }
    if(widget.medicine_name != null)
      {
        setState(() {
          medicine_name_edit.text = widget.medicine_name;
        });

      }


  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:  8.0 ,vertical: 70),
      child: Scaffold(
        resizeToAvoidBottomInset: false,




        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Column(
                children: [
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Add/Edit Medicine' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
                      Visibility(
                        visible: widget.doc_id==null?false:true,
                        child: IconButton(
                          icon: Icon(Icons.delete_outline_outlined),
                          onPressed: ()async{



                            var doc =await FirebaseFirestore.instance.collection('Medicines').doc(widget.doc_id);
                            doc.delete();

                            Navigator.pop(context , 'save');




                          },
                        ),
                      ),




                    ],
                  ),

                  SizedBox(height: 10,),

                  TextField(
                    controller: medicine_name_edit,
                    decoration: InputDecoration(
                        labelText: 'Medicine Name',

                        helperText: 'Example - Parecetamol 250mg',

                        border: OutlineInputBorder(

                        )
                    ),
                  ),

                  SizedBox(height: 10,),


                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.1,
                    width: MediaQuery.of(context).size.width*0.9,
                    child: Card(
                      color: AppTheme.white,
                      child: Row(
                        children: [
                          SizedBox(width: 7,),
                          Icon(Icons.comment),
                          SizedBox(width: 7,),

                          Flexible(
                            flex: 2,
                            child: GestureDetector(
                              onTap: (){
                                showDialog(
                                    context: context,
                                    builder: (context){

                                      return Column(
                                          children: []
                                      );

                                    }
                                );
                              },
                              child: Container(
                                width:  MediaQuery.of(context).size.width*0.7,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(tab , style: TextStyle(color: map['tab']?Colors.black:Colors.grey)),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 4,),




                          IconButton(onPressed: ()async{



                            //  print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                            showDialog(
                                context: context,
                                builder: (context)  {



                                  return  Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child:Try(),
                                  );}

                            ).then((value)async{

                              print(value);

                              List a =  await value;

                              print(a);



                              tab='';
                              a.forEach((element) {

                                tab+=element + s;


                              });

                              if(tab != "")
                              {
                                setState(() {
                                  tab=tab;
                                  map['tab']=true;

                                });
                              }
                              else
                              {
                                setState(() {
                                  tab="TAB/CAP/SYP";
                                  map['tab']=false;

                                });

                              }





                            });










                          }, icon: Icon(Icons.arrow_drop_down_circle_outlined))




                        ],
                      ),
                    ),
                  ),




                  // Tab

                  SizedBox(height: 10,),

                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.1,
                    width: MediaQuery.of(context).size.width*0.9,
                    child: Card(
                      color: AppTheme.white,
                      child: Row(
                        children: [
                          SizedBox(width: 7,),
                          Icon(Icons.comment),
                          SizedBox(width: 7,),

                          Flexible(
                            flex: 2,
                            child: GestureDetector(
                              onTap: (){
                                showDialog(
                                    context: context,
                                    builder: (context){

                                      return Column(
                                          children: []
                                      );

                                    }
                                );
                              },
                              child: Container(
                                width:  MediaQuery.of(context).size.width*0.7,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(composition , style: TextStyle(color: map['composition']?Colors.black:Colors.grey)),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 4,),


                          IconButton(onPressed: ()async{



                            //  print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                            showDialog(
                                context: context,
                                builder: (context)  {



                                  return  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ListSearch(group: 'composition', Group: 'Composition'),
                                  );}

                            ).then((value)async{

                              print(value);

                              List a =  await value;

                              print(a);



                              composition='';
                              a.forEach((element) {

                                composition+=element + s;


                              });

                              if(composition != "")
                              {
                                setState(() {
                                  composition=composition;
                                  map['composition']=true;

                                });
                              }
                              else if(widget.doc_id != null)
                              {
                                setState(() {
                                  composition="Composition";
                                  map['composition']=false;

                                });

                              }





                            });










                          }, icon: Icon(Icons.arrow_drop_down_circle_outlined))




                        ],
                      ),
                    ),
                  ), //Composition

                  SizedBox(height: 10,),

                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.1,
                    width: MediaQuery.of(context).size.width*0.9,
                    child: Card(
                      color: AppTheme.white,
                      child: Row(
                        children: [
                          SizedBox(width: 7,),
                          Icon(Icons.comment),
                          SizedBox(width: 7,),

                          Flexible(
                            flex: 2,
                            child: GestureDetector(
                              onTap: (){
                                showDialog(
                                    context: context,
                                    builder: (context){

                                      return Column(
                                          children: []
                                      );

                                    }
                                );
                              },
                              child: Container(
                                width:  MediaQuery.of(context).size.width*0.7,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(company_name , style: TextStyle(color: map['company_name']?Colors.black:Colors.grey)),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 4,),


                          IconButton(onPressed: ()async{



                            //  print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                            showDialog(
                                context: context,
                                builder: (context)  {



                                  return  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ListSearch(group: 'company_name', Group: 'Company-Name'),
                                  );}

                            ).then((value)async{

                              print(value);

                              List a =  await value;

                              print(a);



                              company_name='';
                              a.forEach((element) {

                                company_name+=element + s;


                              });

                              if(company_name != "")
                              {
                                setState(() {
                                  company_name=company_name;
                                  map['company_name']=true;

                                });
                              }
                              else
                              {
                                setState(() {
                                  company_name="Company Name";
                                  map['company_name']=false;

                                });

                              }





                            });










                          }, icon: Icon(Icons.arrow_drop_down_circle_outlined))




                        ],
                      ),
                    ),
                  ), // Company Name

                  SizedBox(height: 10,),

                  TextField(
                    controller: medicine_notes,
                    decoration: InputDecoration(
                        labelText: 'Medicine Notes',



                        border: OutlineInputBorder(

                        )
                    ),
                  ),

                  SizedBox(height: 10,),
                ],
              ),

              Container(
                alignment: Alignment.bottomCenter,
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey
                      ),
                      child: TextButton(
                        child: Text('Cancel' , style:  TextStyle(
                            color: Colors.black
                        ),),
                        onPressed: (){

                          Navigator.pop(context);


                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppTheme.green
                      ),
                      child: TextButton(
                        child: Text('Done' , style:  TextStyle(
                            color: Colors.black
                        ),),
                        onPressed: ()async{

                          if(widget.doc_id == null)
                          {
                            var doc =await FirebaseFirestore.instance.collection('Medicines').doc();


                            final json = {
                              'id':doc.id,
                              'medicine_name':medicine_name_edit.text,
                              'tab':tab,
                              'composition':composition,
                              'company_name':company_name,
                              'notes':medicine_notes.text,

                            };


                            doc.set(json);
                          }
                          if(widget.doc_id != null)
                          {
                            var doc =await FirebaseFirestore.instance.collection('Medicines').doc(widget.doc_id);


                            final json = {
                              'id':doc.id,
                              'medicine_name':medicine_name_edit.text,
                              'tab':tab,
                              'composition':composition,
                              'company_name':company_name,
                              'notes':medicine_notes.text,

                            };


                            doc.update(json);
                          }







                          Navigator.pop(context , 'save');








                        },
                      ),
                    ),
                  ],),
              ),

              SizedBox(height: 10,),





            ],
          ),
        ),
      ),
    );
  }
}
