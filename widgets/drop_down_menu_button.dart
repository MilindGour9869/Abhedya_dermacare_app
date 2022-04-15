
import 'package:flutter/material.dart';


import 'package:flutter_app/classes/service_dialogue.dart';


class DropDown  {















  Map<String , Map<String , dynamic >> all_data_map={};

  int n=0;


  static Widget dropDown( {Map<String  , Map<String, int>> menu , String service_id}) {

    List doc_id=[];

    doc_id = menu.keys.toList();



    return ListView.builder(
        shrinkWrap: true,
        itemCount: doc_id.length,
        itemBuilder: (context, index) {

        });
  }





  }

