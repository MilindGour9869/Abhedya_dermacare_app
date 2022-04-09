import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage{

  static final storage = FlutterSecureStorage();

  static const medicine_additional_info_list = 'medicine_additional_info_list';


  static Future set_medicine_additional_info({List<String> add_info})async
  {
    final value = jsonEncode(add_info);
    
    await storage.write(key: medicine_additional_info_list, value: value);
  }

  static Future<List<String>> get_medicine_additional_info()async
  {


   var add_info =  await storage.read(key: medicine_additional_info_list);
    final value = jsonDecode(add_info);

    return value == null? null :List<String>.from(value);


  }
}