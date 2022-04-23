import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/git/screens/app_theme.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';



class Storage {

  static final storage = FlutterSecureStorage();

  static const add_info = 'add_info';
  static  bool add_info_updated = false;

  static const tab = 'tab';
  static  bool tab_updated = false;

  static const composition = 'composition';
  static bool composition_updated = false;


  static const company_name = 'company_name';
  static bool company_name_updated = false;


  static const medicine = 'medicine';
  static bool medicine_updated = false;

  static const services = 'services';
  static bool service_updated = false;


  static const vital = 'services';
  static bool vital_updated = false;

  static const notes = 'tab';
  static  bool notes_updated = false;


  static const allergies = 'allergies';

  static const advices = 'advices';

  static const complaint = 'complaint';

  static const clinical_finding = 'clinical_finding';










  // Add Info
  static Future set_add_info({Map<String, Map<String, dynamic>> value , @required bool updated }) async
  {
    print(updated && value != null);

    Storage.add_info_updated = updated;


    if(updated)
    {
      print('\nset');
      print(value);


      final str = jsonEncode(value);

      await storage.write(key: add_info, value: str);
    }
  }

  static Future<Map<String, Map<String, dynamic>>> get_add_info() async
  {
    var str = await storage.read(key: add_info);

    var value = str != null ? jsonDecode(str) : null;

    value = Map<String, Map<String, dynamic>>.from(value);


    print(value.runtimeType);


    print('\n value :');


    print(value);

    return value == null ? null : value;
  }

  static Future cloud_add_info({Map<String, Map<String, dynamic>> value  , @required bool updated})async
  {





  }

  static Future delete_add_info(){
    storage.delete(key: add_info);
  }




  //Tab
  static Future set_tab({Map<String, Map<String, dynamic>> value , @required bool updated }) async
  {
    print(updated && value != null);

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

  static Future delete_tab(){
    storage.delete(key: tab);
  }





  //Composition
  static Future set_composition({Map<String, Map<String, dynamic>> value , @required bool updated }) async
  {
    composition_updated = updated;

    if(updated)
      {
        print('\nset');
        print(value);

        final str = jsonEncode(value);

        await storage.write(key: composition, value: str);
      }
  }

  static Future<Map<String, Map<String, dynamic>>> get_composition() async
  {
    var str = await storage.read(key: composition);

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

  static Future delete_composition(){
    storage.delete(key: composition);

  }





  //company_name
  static Future set_company_name({Map<String, Map<String, dynamic>> value , @required bool updated }) async
  {
    company_name_updated = updated;

    if(updated && value != null)
      {
        print('\nset');
        print(value);

        final str = jsonEncode(value);

        await storage.write(key: company_name, value: str);
      }
  }

  static Future<Map<String, Map<String, dynamic>>> get_company_name() async
  {
    var str = await storage.read(key: company_name);

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

  static Future delete_company_name(){
    storage.delete(key: company_name);

  }


  //medicine
  static Future set_medicine({Map<String, Map<String, dynamic>> value , @required bool updated }) async
  {
    company_name_updated = updated;

    if(updated && value != null)
    {
      print('\nset');
      print(value);

      final str = jsonEncode(value);

      await storage.write(key: medicine, value: str);
    }
  }

  static Future<Map<String, Map<String, dynamic>>> get_medicine() async
  {
    var str = await storage.read(key: medicine);

    var value = str != null ? jsonDecode(str) : null;

    value = Map<String, Map<String, dynamic>>.from(value);


    print(value.runtimeType);


    print('\n value :');


    print(value);

    return value == null ? null : value;
  }

  static Future cloud_medicine({Map<String, Map<String, dynamic>> value  , @required bool updated})async
  {
    List docs=[];
    await  FirebaseFirestore.instance.collection("Tab");


    value.forEach((key, value)async {

      await FirebaseFirestore.instance.collection("Tab").doc(key).set(value);
    });





  }

  static Future delete_medicine(){
    storage.delete(key: medicine);
  }


  //services
  static Future set_services({Map<String, Map<String, dynamic>> value , @required bool updated }) async
  {
    service_updated = updated;

    if(updated && value != null)
    {
      print('\nset');
      print(value);

      final str = jsonEncode(value);

      await storage.write(key: services, value: str);
    }
  }

  static Future<Map<String, Map<String, dynamic>>> get_services() async
  {

    print('\n get_services called');
    var str = await storage.read(key: services);

    var value = str != null ? jsonDecode(str) : null;

    value = Map<String, Map<String, dynamic>>.from(value);


    print(value.runtimeType);


    print('\n value :');


    print(value);

    return value == null ? null : value;
  }

  static Future cloud_services({Map<String, Map<String, dynamic>> value  , @required bool updated})async
  {






  }

  static Future delete_services(){
    storage.delete(key: services);
  }



  //Vital
  static Future set_vital({Map<String, Map<String, dynamic>> value , @required bool updated }) async
  {
    vital_updated = updated;

    print(updated);


    if(updated)
    {
      print('\nset');
      print(value);

      final str = jsonEncode(value);

      await storage.write(key: vital, value: str);
    }
  }

  static Future<Map<String, Map<String, dynamic>>> get_vital() async
  {

    print('\n get_vital called');
    var str = await storage.read(key: vital);

    var value = str != null ? jsonDecode(str) : null;

    value = Map<String, Map<String, dynamic>>.from(value);


    print(value.runtimeType);


    print('\n value :');


    print(value);

    return value == null ? null : value;
  }

  static Future cloud_vital({Map<String, Map<String, dynamic>> value  , @required bool updated})async
  {


  }

  static Future delete_vital(){
    storage.delete(key: vital);
  }




  // Notes
  static Future set_notes({Map<String, Map<String, dynamic>> value , @required bool updated }) async
  {
    print(updated && value != null);

    Storage.notes_updated = updated;


    if(updated)
    {
      print('\nset');
      print(value);


      final str = jsonEncode(value);

      await storage.write(key: notes, value: str);
    }
  }

  static Future<Map<String, Map<String, dynamic>>> get_notes() async
  {
    var str = await storage.read(key: notes);

    var value = str != null ? jsonDecode(str) : null;

    value = Map<String, Map<String, dynamic>>.from(value);


    print(value.runtimeType);


    print('\n value :');


    print(value);

    return value == null ? null : value;
  }

  static Future cloud_notes({Map<String, Map<String, dynamic>> value  , @required bool updated})async
  {






  }

  static Future delete_notes(){
    storage.delete(key: notes);
  }























}