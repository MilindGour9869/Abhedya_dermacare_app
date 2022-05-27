import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/classes/Patient_name_list.dart';
import 'package:flutter_app/storage/cloud_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:open_file/open_file.dart';

import '../default.dart';

class DocumentScreen extends StatefulWidget {
  Patient_name_data_list patient_data;

  DocumentScreen({@required this.patient_data});

  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  String visit_date;

  bool isprofile = false;
  bool isprescription = false;
  bool isreceipt = false;
  bool is_other_doc = false;


  Uint8List profile_cloud_data;

  var other_doc_file_rename = TextEditingController();
  var receipt_file_rename = TextEditingController();



  Future fprescription;
  Future fother_doc;
  Future fprofile;
  Future freceipt ;


  File profile_file;
  String profile_name;
  String profile_link;


  List prescript = [];



  File other_doc_file ;
  Map<String , dynamic> other_doc_file_map ={};
  List other_doc_list = [];

  File receipt_file ;
  Map<String , dynamic> receipt_file_map ={};
  List receipt_list = [];



  bool ischange = false;




  Future imagepicker_profile(ImageSource source) async {

    ischange = true;

    final image =
        await ImagePicker().pickImage(source: source, imageQuality: 50);

    if (image == null) return null;

    setState(() {
      this.profile_file = File(image.path);
      profile_name = 'Profile'+ getFileExtension(profile_file.path);




      print(profile_file.path);
    });

    return 'change';
  }


  Future imagepicker_other_doc(ImageSource source) async {

    ischange = true;

    final image =
    await ImagePicker().pickImage(source: source, imageQuality: 50);

    if (image == null) return null;

    setState(() {
      other_doc_file = File(image.path);

      print(other_doc_file.path);



    });

    return 'change';
  }

  Future imagepicker_receipt(ImageSource source) async {


    ischange = true;

    final image =
    await ImagePicker().pickImage(source: source, imageQuality: 50);

    if (image == null) return null;

    setState(() {
      receipt_file = File(image.path);



    });

    return 'change';
  }

  Future f_profile() async {
    try {
      var r = await FirebaseStorage.instance
          .ref('Patient/${widget.patient_data.doc_id}/Profile/');

      await r.listAll().then((value) async {

        profile_name =  value.items.first.name;
        profile_cloud_data = await value.items.first.getData();
        profile_link = await value.items.first.getDownloadURL();


      });








      return r.name;
    } catch (e) {
      print(e);
    }
  }

  Future f_other_doc() async {
    try {
      var ref = await FirebaseStorage.instance
          .ref('Patient/${widget.patient_data.doc_id}/OtherDocument/');


      var result = await ref.listAll();


      other_doc_list = await result.items;





      return 'DataArrived';
    } catch (e) {
      print(e);
    }
  }

  Future f_receipt() async {
    try {
      var ref = await FirebaseStorage.instance
          .ref('Patient/${widget.patient_data.doc_id}/Receipt/');


      var result = await ref.listAll();


      receipt_list = await result.items;





      return 'DataArrived';
    } catch (e) {
      print(e);
    }
  }



  Future f_prescription() async {
    var ref = await FirebaseStorage.instance
        .ref('Patient/${widget.patient_data.doc_id}/Prescription/');

    print('ger');

    print(ref.fullPath);

    var result = await ref.listAll();


   prescript = await result.items;

    return 'Data arrived';
  }

  bool hasdata = false;

  String getFileExtension(String fileName) {
    try {
      return "." + fileName.split('.').last;
    } catch(e){
      return null;
    }
  }


  @override
  void initState() {
    // TODO: implement initState

    print('cddcddsaas');

    fprofile = f_profile();
    fprescription = f_prescription();
    fother_doc = f_other_doc();
    freceipt = f_receipt();
    profile_link = widget.patient_data.profile_link;



  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: Scaffold(
        resizeToAvoidBottomInset: false,

        appBar: AppBar(
            title: Text('Add Document'),
            backgroundColor: AppTheme.teal,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: (){
                if(ischange)
                  {
                    Navigator.pop(context , 'change');
                  }
                else
                  {
                    Navigator.pop(context , 'back');

                  }
              },
            ),
            actions: [
              IconButton(
                  onPressed: () async {





                        if(ischange)
                        {

                          showDialog(context: context, builder: (context)=>Center(child: CircularProgressIndicator()));

                          if(other_doc_file_map.isNotEmpty)
                          {







                            await Future.wait(other_doc_file_map.keys.map((key)async {


                              await Cloud_Storage.Patient_Other_Document_Upload(
                                doc_id: widget.patient_data.doc_id,
                                file: other_doc_file_map[key],
                                file_name: key,

                              );




                            }));


                          }
                          if(receipt_file_map.isNotEmpty)
                          {







                            await Future.wait(receipt_file_map.keys.map((key)async {


                              await Cloud_Storage.Patient_Receipt_Upload(
                                doc_id: widget.patient_data.doc_id,
                                file: receipt_file_map[key],
                                file_name: key,

                              );




                            }));


                          }
                          if(profile_file !=null)
                            {
                              await Cloud_Storage.Patient_Profile_Image_Upload(
                                doc_id: widget.patient_data.doc_id,
                                file: profile_file,
                                file_name: profile_name
                              ).then((value) async{
                                await FirebaseFirestore.instance.collection('Patient').doc(widget.patient_data.doc_id).update({

                                  'profile_link' : value
                                });
                              });



                            }

                          Navigator.popUntil(context,(route)=>route.isFirst);



                        }
                        else
                        {
                          Navigator.pop(context , 'back');

                        }


                      }
                  ,
                  icon: Icon(Icons.save))
            ]),
        body: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isprofile = !isprofile;
                });
              },
              child: Card(
                elevation: 2,
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppTheme.teal,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text('Profile'),
                    ],
                  ),
                ),
              ),
            ), // Profile
            Visibility(
                visible: isprofile,
                child: FutureBuilder(
                  future: fprofile,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (profile_cloud_data != null || profile_file != null) {
                      print('erevdd\n');

                      print(snapshot.data);

                      return GestureDetector(
                        onTap: () async {
                          print(snapshot.hasData);

                          if (profile_cloud_data != null) {
                            final tempDir = await getTemporaryDirectory();

                            print(tempDir.path);

                            File f = await File('${tempDir.path}/profile.png')
                                .create();
                            f.writeAsBytesSync(profile_cloud_data);

                            OpenFile.open(f.path);
                          } else if (profile_file != null) {


                            OpenFile.open(profile_file.path);
                          }
                        },
                        child: Card(
                          child: ListTile(
                            title: Row(
                              children: [
                                Icon(Icons.person_outline),
                                SizedBox(width: 2.w),
                                Text(profile_name==null?'Profile':profile_name),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete_outline_outlined,
                                color: Colors.red,
                              ),
                              onPressed: ()async{

                                if(profile_cloud_data !=null)
                                  {
                                    ischange = true;


                                        if(profile_link != null )
                                          {
                                            if(profile_link.isNotEmpty)
                                              {
                                                 FirebaseStorage.instance.refFromURL(profile_link).delete();

                                              }
                                          }


                                     FirebaseFirestore.instance.collection('Patient').doc(widget.patient_data.doc_id).update(
                                      {
                                        'profile_link' : ""
                                      }
                                    );


                                  }
                                setState(() {
                                  profile_cloud_data = null;
                                  profile_file = null;
                                });








                              },
                            ),
                          ),
                        ),
                      );
                    }

                    if (profile_cloud_data == null) {
                      return Card(
                          child: TextButton.icon(
                              onPressed: () {
                                print('dwee');

                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                      title: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextButton.icon(
                                          icon: Icon(
                                            FontAwesomeIcons.cameraRetro,
                                            color: AppTheme.green,
                                          ),
                                          onPressed: () {
                                            imagepicker_profile(ImageSource.camera);
                                            Navigator.pop(context);
                                          },
                                          label: Text(
                                            ' Camera',
                                            style: AppTheme.Black,
                                          )),
                                      TextButton.icon(
                                          icon: Icon(
                                            FontAwesomeIcons.photoFilm,
                                            color: AppTheme.green,
                                          ),
                                          onPressed: () {
                                            imagepicker_profile(ImageSource.gallery);
                                            Navigator.pop(context);
                                          },
                                          label: Text(
                                            ' Gallery',
                                            style: AppTheme.Black,
                                          ))
                                    ],
                                  )),
                                );
                              },
                              icon: Icon(Icons.add),
                              label: Text('Add Profile')));
                    } else {
                      return const Text('errror');
                    }
                  },
                )),

            GestureDetector(
              onTap: () {
                setState(() {
                  isprescription = !isprescription;
                });
              },
              child: Card(
                elevation: 2,
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppTheme.teal,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text('Prescription'),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
                visible: isprescription,
                child: FutureBuilder(
                  future: fprescription,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (prescript.isNotEmpty) {
                      return ListView(
                        shrinkWrap: true,
                        children: prescript
                            .map<Widget>((e) => Card(
                              child: ListTile(
                                    title: Row(
                                      children: [
                                        Icon(Icons.picture_as_pdf_outlined),
                                        SizedBox(width: 2.w),
                                        Text('${e.name}'),
                                      ],
                                    ),
                                    onTap: () async {
                                      final tempDir =
                                          await getTemporaryDirectory();

                                      print(tempDir.path);

                                      print(e.name);



                                      File f =
                                          await File('${tempDir.path}/${e.name}.pdf')
                                              .create();
                                      f.writeAsBytesSync(await e.getData());

                                      OpenFile.open(f.path);
                                    },
                                    trailing: IconButton(
                                      onPressed: ()async {
                                        setState(() {
                                          prescript.remove(e);
                                        });

                                         await FirebaseStorage.instance.refFromURL(await e.getDownloadURL()).delete();
                                         ischange = true;
                                      },
                                      icon: Icon(
                                        Icons.delete_outline_outlined,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                            ))
                            .toList(),
                      );
                    }
                    if (prescript.isEmpty) {
                      return Card(
                        child: Padding(
                          padding: EdgeInsets.all(2.w),
                          child: Text('No Data'),
                        ),
                      );
                    } else {
                      return const Text('errror');
                    }
                  },
                )),

            GestureDetector(
              onTap: () {
                setState(() {
                  isreceipt = !isreceipt;
                });
              },
              child: Card(
                elevation: 2,
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppTheme.teal,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text('Receipts'),

                    ],
                  ),

                ),
              ),
            ),
            Visibility(
                visible: isreceipt,
                child: FutureBuilder(
                  future: freceipt,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (!snapshot.hasError) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          ListView(
                            shrinkWrap: true,
                            children: receipt_list
                                .map<Widget>((e) => Card(
                              child: ListTile(
                                title: Row(
                                  children: [
                                    Icon(Icons.file_copy_outlined),
                                    SizedBox(width: 2.w),
                                    Text('${e.name}'),
                                  ],
                                ),
                                onTap: () async {
                                  final tempDir =
                                  await getTemporaryDirectory();

                                  print(tempDir.path);

                                  print(e.name);




                                  File f =
                                  await File('${tempDir.path}/${e.name}')
                                      .create();
                                  f.writeAsBytesSync(await e.getData());

                                  OpenFile.open(f.path);
                                },
                                trailing: IconButton(
                                  onPressed: () async{
                                    setState(() {
                                      receipt_list.remove(e);
                                    });
                                    await FirebaseStorage.instance.refFromURL(await e.getDownloadURL()).delete();
                                    ischange = true;
                                  },
                                  icon: Icon(
                                    Icons.delete_outline_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ))
                                .toList(),
                          ),
                          ListView(
                            shrinkWrap: true,
                            children: receipt_file_map.keys
                                .map<Widget>((e) => Card(
                              child: ListTile(
                                title: Row(
                                  children: [
                                    Icon(Icons.photo_library_outlined),
                                    SizedBox(width: 2.w),
                                    Text(e),
                                  ],
                                ),
                                onTap: () async {



                                  OpenFile.open(receipt_file_map[e].path);
                                },
                                trailing: IconButton(
                                  onPressed: () async{
                                    setState(() {
                                      receipt_file_map.remove(e);


                                    });


                                  },
                                  icon: Icon(
                                    Icons.delete_outline_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ))
                                .toList(),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Card(
                                  child: TextButton.icon(
                                      onPressed: () {
                                        print('dwee');

                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                              title: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextButton.icon(
                                                      icon: Icon(
                                                        FontAwesomeIcons.cameraRetro,
                                                        color: AppTheme.green,
                                                      ),
                                                      onPressed: () {
                                                        var r =  imagepicker_receipt(ImageSource.camera);
                                                        Navigator.pop(context , r);
                                                      },
                                                      label: Text(
                                                        ' Camera',
                                                        style: AppTheme.Black,
                                                      )),
                                                  TextButton.icon(
                                                      icon: Icon(
                                                        FontAwesomeIcons.photoFilm,
                                                        color: AppTheme.green,
                                                      ),
                                                      onPressed: () {
                                                        var r = imagepicker_receipt(ImageSource.gallery);
                                                        Navigator.pop(context , r);
                                                      },
                                                      label: Text(
                                                        ' Gallery',
                                                        style: AppTheme.Black,
                                                      ))
                                                ],
                                              )),
                                        ).then((value) {

                                          if(value != null)
                                          {
                                            receipt_file_rename.clear();


                                            showDialog(context: context, builder: (context)=>WillPopScope(
                                              onWillPop: (){
                                                if(receipt_file_rename.text.isNotEmpty)
                                                {
                                                  Navigator.pop(context , receipt_file_rename.text);
                                                  receipt_file_rename.clear();

                                                }
                                                else
                                                {
                                                  showDialog(context: context , builder: (context)=>AlertDialog(
                                                    title: Text('Name is Compulsory'  ),
                                                    actions: [
                                                      TextButton(onPressed: (){
                                                        Navigator.pop(context , receipt_file_rename.text);

                                                      }, child: Text('OK' ,  textScaleFactor: AppTheme.alert,))
                                                    ],

                                                  ));


                                                }

                                              },
                                              child: GestureDetector(
                                                onTap: (){
                                                  if(receipt_file_rename.text.isNotEmpty)
                                                  {
                                                    Navigator.pop(context , receipt_file_rename.text);

                                                    receipt_file_rename.clear();


                                                  }
                                                  else
                                                  {

                                                    showDialog(context: context , builder: (context)=>AlertDialog(
                                                      title: Text('Name is Compulsory'  ),
                                                      actions: [
                                                        TextButton(onPressed: (){
                                                          Navigator.pop(context);

                                                        }, child: Text('OK' ,  textScaleFactor: AppTheme.alert,))
                                                      ],

                                                    ));

                                                  }
                                                },
                                                child: Scaffold(
                                                  backgroundColor: Colors.transparent,

                                                  body: Padding(
                                                    padding:  EdgeInsets.symmetric(horizontal: 2.w),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Card(

                                                          elevation: 2,
                                                          child: Column(

                                                            children: [

                                                              Padding(
                                                                padding:  EdgeInsets.symmetric(vertical: 2.w),
                                                                child: Text('Rename' , style: TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 20,


                                                                ),),
                                                              ),
                                                              Padding(
                                                                padding:  EdgeInsets.all( 2.w),
                                                                child: TextField(
                                                                  controller: receipt_file_rename,

                                                                  decoration: InputDecoration(


                                                                      enabledBorder: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                          color: Colors.grey,
                                                                          width: 2,),
                                                                        borderRadius: BorderRadius.circular(10),),

                                                                      focusedBorder: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                          color: Colors.teal,
                                                                          width: 2,),
                                                                        borderRadius: BorderRadius.circular(10),),

                                                                      labelText: 'Rename',
                                                                      prefixIcon: Icon(Icons.edit_outlined)),








                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:  EdgeInsets.symmetric(vertical: 2.w , horizontal: 2.w),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    TextButton(onPressed: (){

                                                                      Navigator.pop(context);

                                                                    }, child: Text('Cancel')),
                                                                    TextButton(onPressed: (){

                                                                      Navigator.pop(context , receipt_file_rename.text);
                                                                    }, child: Text('OK')),

                                                                  ],
                                                                ),
                                                              ),



                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )).then((value) {

                                              if(value !=null)
                                              {
                                                setState(() {

                                                  value = value + getFileExtension(receipt_file.path);

                                                  receipt_file_map[value] = receipt_file;

                                                  print('tbvds');








                                                });
                                              }
                                            });
                                          }


                                        });
                                      },
                                      icon: Icon(Icons.add),
                                      label: Text('Add Receipt'))),
                            ],
                          )
                        ],
                      );
                    }
                    else {
                      return const Text('errror');
                    }
                  },
                )),



            GestureDetector(
              onTap: () {
                setState(() {
                  is_other_doc = !is_other_doc;
                });
              },
              child: Card(
                elevation: 2,
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppTheme.teal,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text('Other Documents'),

                    ],
                  ),

                ),
              ),
            ),
            Visibility(
                visible: is_other_doc,
                child: FutureBuilder(
                  future: fother_doc,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (!snapshot.hasError) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          ListView(
                            shrinkWrap: true,
                            children: other_doc_list
                                .map<Widget>((e) => Card(
                              child: ListTile(
                                title: Row(
                                  children: [
                                    Icon(Icons.file_copy_outlined),
                                    SizedBox(width: 2.w),
                                    Text('${e.name}'),
                                  ],
                                ),
                                onTap: () async {
                                  final tempDir =
                                  await getTemporaryDirectory();

                                  print(tempDir.path);

                                  print(e.name);




                                  File f =
                                  await File('${tempDir.path}/${e.name}')
                                      .create();
                                  f.writeAsBytesSync(await e.getData());

                                  OpenFile.open(f.path);
                                },
                                trailing: IconButton(
                                  onPressed: () async{
                                    setState(() {
                                      other_doc_list.remove(e);
                                    });
                                    await FirebaseStorage.instance.refFromURL(await e.getDownloadURL()).delete();
                                    ischange = true;
                                  },
                                  icon: Icon(
                                    Icons.delete_outline_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ))
                                .toList(),
                          ),
                          ListView(
                            shrinkWrap: true,
                            children: other_doc_file_map.keys
                                .map<Widget>((e) => Card(
                              child: ListTile(
                                title: Row(
                                  children: [
                                    Icon(Icons.photo_library_outlined),
                                    SizedBox(width: 2.w),
                                    Text(e),
                                  ],
                                ),
                                onTap: () async {



                                  OpenFile.open(other_doc_file_map[e].path);
                                },
                                trailing: IconButton(
                                  onPressed: () async{
                                    setState(() {
                                      other_doc_file_map.remove(e);


                                    });


                                  },
                                  icon: Icon(
                                    Icons.delete_outline_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ))
                                .toList(),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Card(
                                  child: TextButton.icon(
                                      onPressed: () {
                                        print('dwee');

                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                              title: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextButton.icon(
                                                      icon: Icon(
                                                        FontAwesomeIcons.cameraRetro,
                                                        color: AppTheme.green,
                                                      ),
                                                      onPressed: () {
                                                        var r =  imagepicker_other_doc(ImageSource.camera);
                                                        Navigator.pop(context , r);
                                                      },
                                                      label: Text(
                                                        ' Camera',
                                                        style: AppTheme.Black,
                                                      )),
                                                  TextButton.icon(
                                                      icon: Icon(
                                                        FontAwesomeIcons.photoFilm,
                                                        color: AppTheme.green,
                                                      ),
                                                      onPressed: () {
                                                        var r = imagepicker_other_doc(ImageSource.gallery);
                                                        Navigator.pop(context , r);
                                                      },
                                                      label: Text(
                                                        ' Gallery',
                                                        style: AppTheme.Black,
                                                      ))
                                                ],
                                              )),
                                        ).then((value) {

                                          if(value != null)
                                            {
                                              other_doc_file_rename.clear();


                                              showDialog(context: context, builder: (context)=>WillPopScope(
                                                onWillPop: (){
                                                  if(other_doc_file_rename.text.isNotEmpty)
                                                  {
                                                    Navigator.pop(context , other_doc_file_rename.text);
                                                    other_doc_file_rename.clear();

                                                  }
                                                  else
                                                  {
                                                    showDialog(context: context , builder: (context)=>AlertDialog(
                                                      title: Text('Name is Compulsory'  ),
                                                      actions: [
                                                        TextButton(onPressed: (){
                                                          Navigator.pop(context , other_doc_file_rename.text);

                                                        }, child: Text('OK' ,  textScaleFactor: AppTheme.alert,))
                                                      ],

                                                    ));


                                                  }

                                                },
                                                child: GestureDetector(
                                                  onTap: (){
                                                    if(other_doc_file_rename.text.isNotEmpty)
                                                      {
                                                        Navigator.pop(context , other_doc_file_rename.text);

                                                        other_doc_file_rename.clear();


                                                      }
                                                    else
                                                      {

                                                        showDialog(context: context , builder: (context)=>AlertDialog(
                                                          title: Text('Name is Compulsory'  ),
                                                          actions: [
                                                            TextButton(onPressed: (){
                                                              Navigator.pop(context);

                                                            }, child: Text('OK' ,  textScaleFactor: AppTheme.alert,))
                                                          ],

                                                        ));

                                                      }
                                                  },
                                                  child: Scaffold(
                                                    backgroundColor: Colors.transparent,

                                                    body: Padding(
                                                      padding:  EdgeInsets.symmetric(horizontal: 2.w),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Card(

                                                            elevation: 2,
                                                            child: Column(

                                                              children: [

                                                                Padding(
                                                                  padding:  EdgeInsets.symmetric(vertical: 2.w),
                                                                  child: Text('Rename' , style: TextStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: 20,


                                                                  ),),
                                                                ),
                                                                Padding(
                                                                  padding:  EdgeInsets.all( 2.w),
                                                                  child: TextField(
                                                                    controller: other_doc_file_rename,

                                                                    decoration: InputDecoration(


                                                                        enabledBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                            color: Colors.grey,
                                                                            width: 2,),
                                                                          borderRadius: BorderRadius.circular(10),),

                                                                        focusedBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                            color: Colors.teal,
                                                                            width: 2,),
                                                                          borderRadius: BorderRadius.circular(10),),

                                                                        labelText: 'Rename',
                                                                        prefixIcon: Icon(Icons.edit_outlined)),








                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:  EdgeInsets.symmetric(vertical: 2.w , horizontal: 2.w),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                    TextButton(onPressed: (){

                                                                      Navigator.pop(context);

                                                                    }, child: Text('Cancel')),
                                                                      TextButton(onPressed: (){

                                                                        Navigator.pop(context , other_doc_file_rename.text);
                                                                      }, child: Text('OK')),

                                                                    ],
                                                                  ),
                                                                ),



                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )).then((value) {

                                                if(value !=null)
                                                  {
                                                    setState(() {

                                                      value = value + getFileExtension(other_doc_file.path);


                                                      other_doc_file_map[value] = other_doc_file;

                                                      print('tbvds');








                                                    });
                                                  }
                                              });
                                            }


                                        });
                                      },
                                      icon: Icon(Icons.add),
                                      label: Text('Add Document'))),
                            ],
                          )
                        ],
                      );
                    }
                     else {
                      return const Text('errror');
                    }
                  },
                )),



          ],
        ),
      ),
    );
  }
}
