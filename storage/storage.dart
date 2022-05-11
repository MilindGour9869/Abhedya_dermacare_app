import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/git/screens/app_theme.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';



class Storage {

  static final storage = FlutterSecureStorage();


  static bool is_get_cloud_called = false;
  static const one_time_get_cloud = 'one_time_get_cloud';


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

  static const notes = 'notes';
  static  bool notes_updated = false;

  static const blood_group = 'blood_group';
  static  bool blood_group__updated = false;

  static const select_practice = 'select_practice';
  static  bool select_practice_updated = false;


  static const allergies = 'allergies';

  static const advices = 'advices';

  static const complaint = 'complaint';

  static const clinical_finding = 'clinical_finding';

  static const String guest = 'Guest';
  static const String admin = 'Admin';
  static const String reception = 'Reception';




  static Map<String,bool> user_map={

    'is_guest' :false,
    'is_admin' :false,
    'is_reception' : false,
  };






  static Map<String ,String> list_all_map ={

    'Complaint' : 'complaint' ,
    'Blood_Group' : 'blood_group' ,
    'Composition' : 'composition' ,
    'Diagnosis' : 'diagnosis' ,
    'Allergies' : 'allergies' ,
    'Investigation' : 'investigation' ,
    'Medicines' : 'medicine' ,
    'Services' : 'services' ,
    'Tab' : 'tab' ,
    'Clinical_finding' : 'clinical_finding'





  };


  static Future set_guest_true()async{

    user_map['is_guest']=true;

    await storage.write(key: guest, value: 'true');
  }

  static Future set_guest_false()async{
    user_map['is_guest']=false;

    await storage.write(key: guest, value: 'false');

  }

  static Future get_guest()async{
    var result = await storage.read(key: guest);


    if(result =='true')
      {
        user_map['is_guest']=true;

      }
    else
      {
        user_map['is_guest']=false;

      }

  }

  static Future set_admin_true()async{

    user_map['is_admin']=true;

    await storage.write(key: admin, value: 'true');
  }

  static Future set_admin_false()async{

    user_map['is_admin']=false;

    await storage.write(key: admin, value: 'false');
  }

  static Future get_admin()async{
    var result = await storage.read(key: admin);

    print('ggg');


    print(result);


    if(result =='true')
    {
      user_map['is_admin']=true;

    }
    else
    {
      user_map['is_admin']=false;

    }

  }


  static Future set_reception_true()async{

    user_map['is_reception']=true;

    await storage.write(key: reception, value: 'true');
  }

  static Future set_reception_false()async{

    user_map['is_reception']=false;

    await storage.write(key: reception, value: 'false');
  }

  static Future get_reception()async{
    var result = await storage.read(key: reception);


    if(result =='true')
    {
      user_map['is_reception']=true;

    }
    else
    {
      user_map['is_reception']=false;

    }

  }


  static Future get_all_cloud_data()async{
    list_all_map.keys.forEach((element) {

      Map<String , Map<String , dynamic>> result = {} ;

      FirebaseFirestore.instance.collection(element).get().then(( QuerySnapshot querySnapshot) {

        querySnapshot.docs.forEach((element) {

          Map<String,dynamic> map = element.data();

          result[element.id] = map;


        });
        Storage.set(value: result, updated: true, key: list_all_map[element]);




      });
    });

  }
  static Future set_all_cloud_data()async{





  }
  static Future delete_all_data()async{
    list_all_map.values.forEach((element) {
      storage.delete(key: element);

    });
  }




  static Future set({@required Map<String, Map<String, dynamic>> value , @required bool updated , @required String key }) async
  {
    print(updated && value != null);






    if(updated)
    {
      print('\nset');
      print(value);


      final str = jsonEncode(value);

      await storage.write(key: key, value: str);
    }
  }

  static Future<Map<String, Map<String, dynamic>>> get({@required String key}) async
  {
    var str = await storage.read(key: key);

    var value = str != null ? jsonDecode(str) : null;

    value = Map<String, Map<String, dynamic>>.from(value);


    print(value.runtimeType);


    print('\n value :');


    print(value);

    return value == null ? null : value;
  }

  static Future delete({@required String variable}){
    storage.delete(key: variable);
  }



  static Future cloud({ @required String Group , @required Function get , String user ,  })async
  {

    print('cloud called');


    var json = await  get();

    print(json);

    json.forEach((key, value) {

      FirebaseFirestore.instance.collection(Group).doc(key).set(value ,SetOptions(merge: true) );
    });










  }












  // Add Info






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



  //Blood Group
  static Future set_blood_group({Map<String, Map<String, dynamic>> value , @required bool updated }) async
  {
    print(updated && value != null);

    Storage.blood_group__updated = updated;


    if(updated)
    {
      print('\nset');
      print(value);


      final str = jsonEncode(value);

      await storage.write(key: blood_group, value: str);
    }
  }

  static Future<Map<String, Map<String, dynamic>>> get_blood_group() async
  {
    var str = await storage.read(key: blood_group);

    var value = str != null ? jsonDecode(str) : null;

    value = Map<String, Map<String, dynamic>>.from(value);


    print(value.runtimeType);


    print('\n value :');


    print(value);

    return value == null ? null : value;
  }



  static Future delete_blood_group(){
    storage.delete(key: blood_group);
  }



  //Select Practice
  static Future set_select_practice({Map<String, Map<String, dynamic>> value , @required bool updated }) async
  {
    print(updated && value != null);

    Storage.select_practice_updated = updated;


    if(updated)
    {
      print('\nset');
      print(value);


      final str = jsonEncode(value);

      await storage.write(key: select_practice, value: str);
    }
  }

  static Future<Map<String, Map<String, dynamic>>> get_select_practice() async
  {
    var str = await storage.read(key: select_practice);

    var value = str != null ? jsonDecode(str) : null;

    value = Map<String, Map<String, dynamic>>.from(value);


    print(value.runtimeType);


    print('\n value :');


    print(value);

    return value == null ? null : value;
  }

  static Future cloud_select_practice({Map<String, Map<String, dynamic>> value  , @required bool updated})async
  {





  }

  static Future delete_select_practice(){
    storage.delete(key: select_practice);
  }























}