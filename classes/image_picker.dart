import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../default.dart';


  File? file;


  Future imagepicker(ImageSource source) async{



    final image = await ImagePicker().pickImage(source: source);

    if(image==null)
      return;




      file = File(image.path);




  }





Widget SelectImage ({BuildContext? context}){
  return  Container(
    margin: EdgeInsets.symmetric(vertical: 2.h),
    child: GestureDetector(
      onTap: () {
        showDialog(
          context: context!,
          builder: (context) => AlertDialog(
              title: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton.icon(
                      icon: Icon(FontAwesomeIcons.cameraRetro , color: AppTheme.green, ),
                      onPressed: () {
                        imagepicker(ImageSource.camera).then((value) {

                          Navigator.pop(context);
                        });
                      },
                      label: Text(' Camera' ,style: AppTheme.Black,)),
                  TextButton.icon(
                      icon: Icon(FontAwesomeIcons.photoFilm  , color: AppTheme.green, ),
                      onPressed: () {
                        imagepicker(ImageSource.gallery).then((value) {
                          if(value!=null)
                          {
                            Navigator.pop(context);

                          }
                        });
                      },
                      label: Text(' Gallery' ,style: AppTheme.Black, ))
                ],
              )),
        );
      },
      child: ClipOval(
        child: CircleAvatar(
          radius:  AppTheme.circle,
          child: file == null
              ? Icon(
            Icons.person_add_outlined,
            color: Colors.white,
          )
              : Image.file(
            file!,
            fit: BoxFit.fill,
          ),
          backgroundColor: AppTheme.offwhite,
        ),
      ),
    ),
  );

}