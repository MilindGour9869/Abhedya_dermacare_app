import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class Cloud_Storage {

  static Future Patient_Prescription_Upload( {String doc_id  , String visit_date, File file})async{
    final ref = await FirebaseStorage.instance.ref('Patient/${doc_id}/Prescription/${visit_date}');

    return ref.putFile(file);


  }
}