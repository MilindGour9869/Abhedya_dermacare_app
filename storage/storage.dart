import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';



class Storage {

  static final storage = FlutterSecureStorage();

  static const one_time_get_cloud = 'one_time_get_cloud';

  //List
  static const add_info = 'add_info';

  static const tab = 'tab';

  static const composition = 'composition';

  static const company_name = 'company_name';

  static const medicine = 'medicine';

  static const services = 'services';

  static const vital = 'services';

  static const notes = 'notes';

  static const blood_group = 'blood_group';

  static const select_practice = 'select_practice';

  static const allergies = 'allergies';

  static const advices = 'advices';

  static const complaint = 'complaint';

  static const clinical_finding = 'clinical_finding';

  //User
  static const String guest = 'Guest';
  static const String admin = 'Admin';
  static const String reception = 'Reception';

  //Dr. Name
  static const String dr_name = 'dr_name';

  // For get_all_cloud_data Loop ,
  static Map<String, String> list_all_map = {

    'Complaint': 'complaint',
    'Blood_Group': 'blood_group',
    'Composition': 'composition',
    'Diagnosis': 'diagnosis',
    'Allergies': 'allergies',
    'Investigation': 'investigation',
    'Medicines': 'medicine',
    'Services': 'services',
    'Tab': 'tab',
    'Clinical_finding': 'clinical_finding'
  };


  //-----------------------------------------------------------------------------------------

  static Future set_dr_name_true() async {
    await storage.write(key: dr_name, value: 'true');
  }

  static Future set_dr_name_false() async {
    await storage.write(key: dr_name, value: 'false');
  }

  static Future<bool> get_dr_name() async {
    var result = await storage.read(key: guest);


    if (result == 'true') {
      return true;
    }
    else {
      return false;
    }
  }

  //-----------------------------------------------------------------------------------------

  //USER
  static Future set_guest_true() async {


    await storage.write(key: guest, value: 'true');
  }

  static Future set_guest_false() async {


    await storage.write(key: guest, value: 'false');
  }

  static Future<bool> get_guest() async {
    var result = await storage.read(key: guest);


    if (result == 'true') {
      return true;
    }
    else {
      return false;
    }
  }

  static Future set_admin_true() async {

    await storage.write(key: admin, value: 'true');
  }

  static Future set_admin_false() async {


    await storage.write(key: admin, value: 'false');
  }

  static Future<bool> get_admin() async {
    var result = await storage.read(key: admin);

    if (result == 'true') {
      return true;
    }
    else {
      return false;
    }
  }


  static Future set_reception_true() async {


    await storage.write(key: reception, value: 'true');
  }

  static Future set_reception_false() async {

    await storage.write(key: reception, value: 'false');
  }

  static Future<bool> get_reception() async {
    var result = await storage.read(key: reception);

    if (result == 'true') {
      return true;
    }
    else {
      return false;
    }
  }


  static Future<String> get_user() async {
    if (await get_guest()) {
      return 'guest';
    }
    else if (await get_admin()) {
      return 'admin';
    }
    else if (await get_reception()) {
      return 'reception';
    }
    else {
      return 'non';
    }
  }

  //-----------------------------------------------------------------------------------------

  static Future get_all_cloud_data() async {

    list_all_map.keys.forEach((element) {

      Map<String, Map<String, dynamic>> result = {};

      FirebaseFirestore.instance.collection(element).snapshots().forEach((
          element) {
        element.docs.forEach((element) {
          result[element.id] = element.data();
        });

        Storage.set(key: list_all_map[element]!, value: result!);
      });
    });

  }

  // static Future set_all_cloud_data(){}

   static Future delete_all_data() async {

    list_all_map.values.forEach((element) {
      storage.delete(key: element);
    });
  }

  //-----------------------------------------------------------------------------------------

  static Future<void> set({required String key, required Map<String,  Map<String, dynamic>> value}) async
  {
    final str = jsonEncode(value);
    await storage.write(key: key, value: str);
  }
  static Future<void> update({required String key, required Map<String,  Map<String, dynamic>> value}) async
  {
    // value is of lenght = 1;

   final updated_result = await get(key: key);

   if(updated_result!=null)
     {

       updated_result.keys.forEach((element) {

            //doc_id==doc_id
         if(element == value.keys.toString())
           {
             updated_result[element]= value[element]!;
           }
       });

       set(key: key, value: updated_result);

     }

  }

  static Future< Map<String, Map<String, dynamic>>? > get({required String key}) async
  {
   try{
     final str = await storage.read(key: key);

     var value = str != null ? jsonDecode(str) : null;

     value = Map<String, Map<String, dynamic>>.from(value);

     //Format
     //{ doc_id1 :{'name':'xxx' , '} , doc_id2:{'name':} , }

     return value == null ? null : value;

   }
   catch(e){
     return null;
   }
  }

  static Future<void>? delete({required String key}) {
    storage.delete(key: key);
  }

  static Future<void>? cloud({required String Group, required Function get}) async
  {
    Map<String, Map<String, dynamic>> json = await get();

    json.forEach((key, value) {
      FirebaseFirestore.instance.collection(Group).doc(key).set(
          value, SetOptions(merge: true));
    });
  }


}