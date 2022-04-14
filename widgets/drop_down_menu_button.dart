
import 'package:flutter/material.dart';


import 'package:flutter_app/classes/service_dialogue.dart';

class DropDown extends StatefulWidget {
  Map<String , Map<String , int>> menu={};

  Map<String , Map<String , dynamic >> all_data_map={};

  String service_id;

  bool c;







  DropDown({this.menu, this.service_id   , this.c , this.all_data_map});

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
                      ServiceDialogue.Dialogue(service_name: widget.service_id , service: service , context: context , charges: charge , doc_id: doc_id[index].toString() , map: widget.all_data_map )).then((value) {

                        if(value == 'save')
                          {


                          }


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
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [



                         Row(
                           mainAxisSize: MainAxisSize.min,
                           children: [
                             Icon(Icons.arrow_forward_ios_rounded , color: Colors.grey,),
                             SizedBox(width: 2,),

                             Text(
                               ' ${s[0].toUpperCase()+s.substring(1)}',
                               style: TextStyle(color: Colors.black , fontSize: 15),

                             ),
                           ],
                         ),


                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(c+ ' ₹' , style: TextStyle(fontSize: 15),),
                              IconButton(onPressed: (){



                              }, icon: Icon(Icons.delete_outline_outlined , color: Colors.grey,))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

