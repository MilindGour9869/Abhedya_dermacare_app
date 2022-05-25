import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/classes/Patient_name_list.dart';
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

  bool profile = false;
  bool prescription = false;
  bool receipt = false;

  Uint8List result;

  Future fprescription;

  List prescript = [];
  Map<String, dynamic> map = {};

  Future imagepicker(ImageSource source) async {
    final image =
        await ImagePicker().pickImage(source: source, imageQuality: 50);

    if (image == null) return null;

    setState(() {
      this.file = File(image.path);

      print(file.path);
    });

    return 'change';
  }

  Future f_profile() async {
    try {
      var r = await FirebaseStorage.instance
          .ref('Patient/${widget.patient_data.doc_id}/Profile/Profile');

      Uint8List a = await r.getData();

      result = a;
      return a;
    } catch (e) {
      print(e);
    }
  }

  File file;

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
  Future fprofile;

  @override
  void initState() {
    // TODO: implement initState

    print('cddcddsaas');

    fprofile = f_profile();
    fprescription = f_prescription();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Add Document'),
          backgroundColor: AppTheme.teal,
          actions: [
            IconButton(
                onPressed: () async {
                  Navigator.pop(context, 'save');
                },
                icon: Icon(Icons.save))
          ]),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                profile = !profile;
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
              visible: profile,
              child: FutureBuilder(
                future: fprofile,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (result != null || file != null) {
                    print('erevdd\n');

                    print(snapshot.data);

                    return GestureDetector(
                      onTap: () async {
                        print(snapshot.hasData);

                        if (result != null) {
                          final tempDir = await getTemporaryDirectory();

                          print(tempDir.path);

                          File f = await File('${tempDir.path}/profile.png')
                              .create();
                          f.writeAsBytesSync(result);

                          OpenFile.open(f.path);
                        } else if (file != null) {
                          final tempDir = await getTemporaryDirectory();

                          print(tempDir.path);
                          File f = await File('${tempDir.path}/profile.png')
                              .create();
                          f = file;
                          OpenFile.open(f.path);
                        }
                      },
                      child: Card(
                        child: ListTile(
                          title: Row(
                            children: [
                              Icon(Icons.person_outline),
                              SizedBox(width: 2.w),
                              Text('Profile'),
                            ],
                          ),
                          trailing: GestureDetector(
                              onTap: () {
                                print('deelete');

                                setState(() {
                                  result = null;
                                  file = null;
                                });
                              },
                              child: Icon(
                                Icons.delete_outline_outlined,
                                color: Colors.red,
                              )),
                        ),
                      ),
                    );
                  }

                  if (result == null) {
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
                                          imagepicker(ImageSource.camera);
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
                                          imagepicker(ImageSource.gallery);
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
                prescription = !prescription;
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
              visible: prescription,
              child: FutureBuilder(
                future: fprescription,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (prescript.isNotEmpty) {
                    return Card(
                      child: ListView(
                        shrinkWrap: true,
                        children: prescript
                            .map<Widget>((e) => ListTile(
                                  title: Row(
                                    children: [
                                      Icon(Icons.picture_as_pdf_outlined),
                                      SizedBox(width: 2.w),
                                      Text('${e.name}.pdf'),
                                    ],
                                  ),
                                  onTap: () async {
                                    final tempDir =
                                        await getTemporaryDirectory();

                                    print(tempDir.path);


                                    File f =
                                        await File('${tempDir.path}/${e.name}.pdf')
                                            .create();
                                    f.writeAsBytesSync(await e.getData());

                                    OpenFile.open(f.path);
                                  },
                                  trailing: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        prescript.remove(e);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.delete_outline_outlined,
                                      color: Colors.red,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
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
              ))
        ],
      ),
    );
  }
}
