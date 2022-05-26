import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:flutter/cupertino.dart';

class Cloud_Storage {


  static Future Patient_Prescription_Upload( {String doc_id  , String visit_date, Uint8List data})async{

    try{

      final ref = await FirebaseStorage.instance.ref('Patient/${doc_id}/Prescription/${visit_date}.pdf');



      return ref.putData(data);
    }
    on FirebaseException catch (e){

      return null;

    }





  }

  static Future Patient_Cloud_Data_Delete({String doc_id}){
    FirebaseStorage.instance.ref('Patient/${doc_id}/').delete();
  }







  static Future Patient_Profile_Image_Upload( {String doc_id , File file})async{
    try{
      final ref = await FirebaseStorage.instance.ref('Patient/${doc_id}/Profile/Profile');

      return ref.putFile(file);
    }
    on FirebaseException catch (e){

      return null;

    }



  }





  static Future Admin_Profile_Image_Upload( {String username , File file})async{
    try{
      final ref = await FirebaseStorage.instance.ref('Administration/Admin/${username}/Profile');

      return ref.putFile(file);
    }
    on FirebaseException catch (e){

      return null;

    }
  }

  static Future Patient_Other_Document_Upload( {@required String doc_id , @required File file , @required String file_name})async{
    try{
      final ref = await FirebaseStorage.instance.ref('Patient/${doc_id}/OtherDocument/${file_name}');

      return ref.putFile(file);
    }
    on FirebaseException catch (e){

      return e;

    }
  }

  static Future Patient_Receipt_Upload( {@required String doc_id , @required File file , @required String file_name})async{
    try{
      final ref = await FirebaseStorage.instance.ref('Patient/${doc_id}/Receipt/${file_name}');

      return ref.putFile(file);
    }
    on FirebaseException catch (e){

      return e;

    }
  }




}