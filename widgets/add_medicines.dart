import 'package:flutter/material.dart';

import 'package:flutter_app/default.dart';
import 'package:flutter_app/widgets/list_search.dart';

import 'package:date_format/date_format.dart';



class AddMedicine extends StatefulWidget {
  @override
  _AddMedicineState createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {


  String composition= "Composition";
  String company_name ="Company Name";
  String tab = "TAB/CAP/SYP";


  Map<String,bool> map ={

    'composition' : false,
    'company_name':false,
    'tab':false,

  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Add Medicines'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(Icons.save),
              onPressed: (){
                Navigator.pop(context);

              },
            ),
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Medicine Name',

                helperText: 'Example - Parecetamol 250mg',

                border: OutlineInputBorder(

                )
              ),
            ),

            SizedBox(height: 20,),

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



                            return  ListSearch(group: 'tab', Group: 'Tab');}

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
            ), // Tab

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



                            return  ListSearch(group: 'composition', Group: 'Composition');}

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
                        else
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



                            return  ListSearch(group: 'company_name', Group: 'Company-Name');}

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
              decoration: InputDecoration(
                  labelText: 'Medicine Notes',



                  border: OutlineInputBorder(

                  )
              ),
            ),

          ],
        ),
      ),
    );
  }
}
