import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/git/screens/app_theme.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';



class Storage {

  static final storage = FlutterSecureStorage();

  static const medicine_additional_info_list = 'medicine_additional_info_list';

  static const tab = 'tab';

  static const composition = 'composition';

  static const company_name = 'company_name';

  static const allergies = 'allergies';

  static const advices = 'advices';

  static const complaint = 'complaint';

  static const clinical_finding = 'clinical_finding';


  static Future set_medicine_additional_info({List<String> add_info}) async
  {
    final value = jsonEncode(add_info);

    await storage.write(key: medicine_additional_info_list, value: value);
  }

  static Future<List<String>> get_medicine_additional_info() async
  {
    var add_info = await storage.read(key: medicine_additional_info_list);
    print(add_info);

    final value = jsonDecode(add_info);

    return value == null ? null : List<String>.from(value);
  }


  static Future set_composition({Map<String, String> composition}) async
  {
    final value = jsonEncode(composition);

    await storage.write(key: medicine_additional_info_list, value: value);
  }

  static Future<Map<String, String>> get_composition() async
  {
    var str = await storage.read(key: composition);

    final value = jsonDecode(str);

    return value == null ? null : value;
  }


  static Future set_tab({Map<String, Map<String, dynamic>> tab_map }) async
  {
    print('\nset');
    print(tab_map);

    final value = jsonEncode(tab_map);

    await storage.write(key: tab, value: value);
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

  static Future cloud_tab({Map<String, Map<String, dynamic>> tab_map })async
  {
    List docs=[];
    await  FirebaseFirestore.instance.collection("Tab");


    tab_map.forEach((key, value)async {

      await FirebaseFirestore.instance.collection("Tab").doc(key).set(value);
    });





  }








}