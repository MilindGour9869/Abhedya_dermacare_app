import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/git/screens/app_theme.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';



class Storage {

  static final storage = FlutterSecureStorage();

  static const medicine_additional_info_list = 'medicine_additional_info_list';
  static  bool add_info_updated = false;

  static const tab = 'tab';
  static  bool tab_updated = false;

  static const composition = 'composition';

  static const company_name = 'company_name';

  static const allergies = 'allergies';

  static const advices = 'advices';

  static const complaint = 'complaint';

  static const clinical_finding = 'clinical_finding';

  // Add Info
  static Future set_medicine_additional_info({List<String> value ,  @required bool updated}) async
  {
    add_info_updated = updated;
    print(updated);


    if(updated)
      {
        final str = jsonEncode(value);

        await storage.write(key: medicine_additional_info_list, value: str);
      }
  }

  static Future<List<String>> get_medicine_additional_info() async
  {
    var add_info = await storage.read(key: medicine_additional_info_list);
    print(add_info);

    final value = jsonDecode(add_info);

    return value == null ? null : List<String>.from(value);
  }

  static Future cloud_medicine_additional_info({List<String> value ,  @required bool updated}) async
  {

  }



  //Tab
  static Future set_tab({Map<String, Map<String, dynamic>> value , @required bool updated }) async
  {
    print(updated);

    Storage.tab_updated = updated;


    if(updated)
      {
        print('\nset');
        print(value);


        final str = jsonEncode(value);

        await storage.write(key: tab, value: str);
      }
  }

  static Future<Map<String, Map<String, dynamic>>> get_tab() async
  {
    var str = await storage.read(key: tab);

    var value = str != null ? jsonDecode(str) : null;

    value = Map<String, Map<String, dynamic>>.from(value);


    print(value.runtimeType);


    print('\n value :');


    print(value);

    return value == null ? null : value;
  }

  static Future cloud_tab({Map<String, Map<String, dynamic>> value  , @required bool updated})async
  {
    List docs=[];
    await  FirebaseFirestore.instance.collection("Tab");


    value.forEach((key, value)async {

      await FirebaseFirestore.instance.collection("Tab").doc(key).set(value);
    });





  }





  //Composition
  static Future set_composition({Map<String, Map<String, dynamic>> value , @required bool updated }) async
  {
    if(updated)
      {
        print('\nset');
        print(value);

        final str = jsonEncode(value);

        await storage.write(key: tab, value: str);
      }
  }

  static Future<Map<String, Map<String, dynamic>>> get_composition() async
  {
    var str = await storage.read(key: tab);

    var value = str != null ? jsonDecode(str) : null;

    value = Map<String, Map<String, dynamic>>.from(value);


    print(value.runtimeType);


    print('\n value :');


    print(value);

    return value == null ? null : value;
  }

  static Future cloud_composition({Map<String, Map<String, dynamic>> value , @required bool updated})async
  {
    List docs=[];
    await  FirebaseFirestore.instance.collection("Tab");


    value.forEach((key, value)async {

      await FirebaseFirestore.instance.collection("Tab").doc(key).set(value);
    });





  }





  //company_name
  static Future set_company_name({Map<String, Map<String, dynamic>> value , @required bool updated }) async
  {
    if(updated)
      {
        print('\nset');
        print(value);

        final str = jsonEncode(value);

        await storage.write(key: tab, value: str);
      }
  }

  static Future<Map<String, Map<String, dynamic>>> get_company_name() async
  {
    var str = await storage.read(key: tab);

    var value = str != null ? jsonDecode(str) : null;

    value = Map<String, Map<String, dynamic>>.from(value);


    print(value.runtimeType);


    print('\n value :');


    print(value);

    return value == null ? null : value;
  }

  static Future cloud_company_name({Map<String, Map<String, dynamic>> value  , @required bool updated})async
  {
    List docs=[];
    await  FirebaseFirestore.instance.collection("Tab");


    value.forEach((key, value)async {

      await FirebaseFirestore.instance.collection("Tab").doc(key).set(value);
    });





  }













}