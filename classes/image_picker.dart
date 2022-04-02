import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';


  File file;


  Future imagepicker(ImageSource source) async{



    final image = await ImagePicker().pickImage(source: source);

    if(image==null)
      return;




      file = File(image.path);




  }





Widget SelectImage ({BuildContext context}){
  return GestureDetector(
    onTap: (){
      showDialog(context: context, builder:(context)=>Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0 , vertical: 240),
        child: Card(
          child: Column(
            children: [
              TextButton.icon(icon :Icon(Icons.camera) , onPressed: (){
                imagepicker(ImageSource.camera);

              }, label: Text('Camera')),
              TextButton.icon(
                  icon: Icon(Icons.browse_gallery),
                  onPressed: (){
                    imagepicker(ImageSource.gallery);
                  }, label: Text('Gallery'))
            ],
          ),
        ),
      ));
    },
    child: ClipOval(
      child: CircleAvatar(
        radius:MediaQuery.of(context).size.height*0.1,

        child: file==null?Icon(Icons.person_add_outlined , color: Colors.white,): Image.file(file , fit: BoxFit.fill,),
        backgroundColor: Colors.grey,

      ),
    ),
  );
}