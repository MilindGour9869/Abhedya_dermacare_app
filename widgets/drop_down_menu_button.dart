import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/git/screens/app_theme.dart';
import 'package:flutter_app/default.dart';
import 'package:flutter_app/screens/Services.dart';

import 'package:flutter_app/classes/service_dialogue.dart';

class DropDown extends StatefulWidget {
  Map<String , Map<String , int>> menu={};

  String service_id;

  bool c;







  DropDown({this.menu, this.service_id   , this.c});

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {




  var service = TextEditingController();
  var charge = TextEditingController();

  List doc_id=[];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doc_id = widget.menu.keys.toList();
  }



  @override
  Widget build(BuildContext context) {








    return ListView.builder(
        shrinkWrap: true,
        itemCount: doc_id.length,
        itemBuilder: (context, index) {

          List a  =  widget.menu[doc_id[index]].keys.toList();
          String s = a[0].toString();

          List b = widget.menu[doc_id[index]].values.toList();
          String c = b[0].toString();






          return  GestureDetector(
            onTap: (){

              service.text = s;
              charge.text = c;


              showDialog(context: context,
                  builder: (context)=>
                      ServiceDialogue.Dialogue(service_name: widget.service_id , service: service , context: context , charges: charge , doc_id: doc_id[index].toString() )).then((value) {

                        widget.c = true;


              });

              },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0 , vertical: 2),
              child: Container(
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(7),
                ),
                height: MediaQuery.of(context).size.height * 0.06,

                child: Material(
                  elevation: 2,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [



                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                           s,
                            style: TextStyle(color: Colors.black , fontSize: 15),

                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(c+ ' Rs' , style: TextStyle(fontSize: 15),),
                            SizedBox(width: 10,),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

