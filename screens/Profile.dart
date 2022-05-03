import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/default.dart';
import 'package:flutter_app/list_search/blood_group_list_search.dart';

import 'package:email_validator/email_validator.dart';
import 'package:flutter_app/list_search/list_search.dart';
import 'package:flutter_app/list_search/select_practice_list_search.dart';
import 'package:flutter_app/storage/cloud_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'dart:io';

import 'package:flutter_app/classes/Patient_name_list.dart';

import '../storage/storage.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File file;

  var name_edit = TextEditingController();
  var password_edit = TextEditingController();
  var username_edit = TextEditingController();
  var email_edit = TextEditingController();
  var mobile_edit = TextEditingController();
  var address_edit = TextEditingController();
  var pincode_edit = TextEditingController();
  var display_practice = TextEditingController();
  var select_practice_edit = TextEditingController();

  String profile_link;

  bool profile_img_delete = false;

  String result = "";

  Future imagepicker(ImageSource source) async {
    final image =
        await ImagePicker().pickImage(source: source, imageQuality: 50);

    if (image == null) return null;

    setState(() {
      this.file = File(image.path);
      profile_link = "";
    });

    return 'change';
  }

  bool male = false, female = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.teal,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context, 'back');
          },
        ),
        title: Text(
          'Admin',
          textScaleFactor: 1,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: IconButton(
              onPressed: () async {
                if (name_edit.text != null && name_edit.text.isNotEmpty) {
                  if (email_edit.text.isNotEmpty) {
                    if (!EmailValidator.validate(email_edit.text)) {
                      return showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text('Invalid Email ID'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'OK',
                                        textScaleFactor: AppTheme.alert,
                                      ))
                                ],
                              ));
                    }
                  }
                  if (mobile_edit.text.isNotEmpty) {
                    print('in else if');

                    if (mobile_edit.text.length != 10) {
                      return showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text(
                                  'Invalid Mobile No.',
                                  textScaleFactor: AppTheme.alert,
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'OK',
                                        textScaleFactor: AppTheme.alert,
                                      ))
                                ],
                              ));
                    }
                  }

                  if (file != null) {
                    print('file no null');

                    var link = Cloud_Storage.Patient_Profile_Image_Upload(
                      file: file,
                    );

                    final snapshot = await link.whenComplete(() {});

                    profile_link = await snapshot.ref.getDownloadURL();
                  }

                  final json = {
                    'name': name_edit.text,
                    'username': username_edit.text,
                    'address': address_edit.text,
                    'clinic_contact_no': mobile_edit.text,
                    'clinic_email': email_edit.text,
                    'profile_link': profile_link == null ? "" : profile_link,
                  };

                  await FirebaseFirestore.instance
                      .collection('Administration')
                      .doc('Admin')
                      .update(json);
                }
                else
                {
                  return showDialog(context: context , builder: (context)=>AlertDialog(

                    title: Text('Name is Compulsory\nPlease write the name'  , textScaleFactor: AppTheme.alert,),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);

                      }, child: Text('OK' ,  textScaleFactor: AppTheme.alert,))
                    ],
                  ));

                }

                return Navigator.pop(context, 'save');
              },
              icon: Icon(
                Icons.save,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 2.h),
                child: GestureDetector(
                  onTap: () {
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
                  onDoubleTap: () {
                    setState(() {
                      profile_img_delete = !profile_img_delete;
                    });
                  },
                  child: ClipOval(
                    child: CircleAvatar(
                      radius: AppTheme.circle,
                      child: profile_link == null
                          ? Icon(
                              Icons.person_add_outlined,
                              color: Colors.white,
                            )
                          : file != null
                              ? Image.file(
                                  file,
                                  fit: BoxFit.fill,
                                )
                              : Image.network(profile_link),
                      backgroundColor: AppTheme.offwhite,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: profile_img_delete,
                child: CircleAvatar(
                  backgroundColor: AppTheme.white,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        profile_link.isNotEmpty
                            ? FirebaseStorage.instance
                                .refFromURL(profile_link)
                                .delete()
                            : null;

                        profile_link = null;
                        file = null;
                        profile_img_delete = false;
                      });
                    },
                    icon: Icon(
                      Icons.delete_outline_outlined,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 6.w),
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Information will be used in Client App :")),
              ),
              txtfield(
                text_edit: name_edit,
                hint: "Display Name",
                keyboard: TextInputType.text,
                icon: Icon(Icons.person_outline),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 6.w),
                  child: TextField(
                    controller: select_practice_edit,
                    autofocus: false,
                    readOnly: true,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.teal,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Select Practice",
                        prefixIcon: Icon(Icons.medication),
                        // ignore: void_checks
                        suffixIcon: IconButton(
                          icon: Icon(Icons.arrow_drop_down_circle_outlined),
                          onPressed: () {
                            setState(() {
                              select_practice_edit.text = "";
                            });

                            return showDialog(
                                context: context,
                                builder: (context) => List_Search(
                                      result: [result],
                                      one_select: true,
                                      group: 'select_practice',
                                      get: Storage.get_select_practice,
                                      set: Storage.set_select_practice,
                                      Group: 'Select_Practice',
                                    )).then((value) {
                              print('ff');

                              if (value != null) {
                                if (value.isNotEmpty) {
                                  setState(() {
                                    select_practice_edit.text = value[0];
                                    result = value[0];
                                  });
                                } else
                                  result = null;
                              } else {
                                result = null;
                              }
                            });
                          },
                        )),
                  )),
              txtfield(
                text_edit: display_practice,
                hint: "Display Practice",
                keyboard: TextInputType.text,
                icon: Icon(Icons.place_outlined),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Divider(
                  thickness: 2,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 6.w),
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Account Credential :")),
              ),
              txtfield(
                text_edit: username_edit,
                hint: "Username",
                keyboard: TextInputType.text,
                icon: Icon(Icons.place_outlined),
              ),
              txtfield(
                text_edit: password_edit,
                hint: "Password",
                keyboard: TextInputType.text,
                icon: Icon(Icons.place_outlined),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Divider(
                  thickness: 2,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 6.w),
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "Fill Clinic Information , will be used in Client App :")),
              ),
              txtfield(
                text_edit: address_edit,
                hint: "Clinic Address",
                keyboard: TextInputType.text,
                icon: Icon(Icons.place_outlined),
              ),
              txtfield(
                text_edit: email_edit,
                hint: "Clinic Email",
                keyboard: TextInputType.emailAddress,
                icon: Icon(Icons.email),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                child: TextField(
                  controller: mobile_edit,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.teal,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Clinic Contact No.',
                      prefixIcon: Icon(Icons.call)),
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                child: TextField(
                  controller: pincode_edit,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.teal,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Clinic Area Pincode',
                      prefixIcon: Icon(Icons.location_on)),
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class txtfield extends StatefulWidget {
  txtfield({
    Key key,
    @required this.text_edit,
    @required this.hint,
    @required this.keyboard,
    @required this.icon,
  }) : super(key: key);

  TextEditingController text_edit;
  String hint;
  TextInputType keyboard;
  Icon icon;

  @override
  State<txtfield> createState() => _txtfieldState();
}

class _txtfieldState extends State<txtfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 6.w),
      child: TextField(
        controller: widget.text_edit,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.teal,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            labelText: widget.hint,
            prefixIcon: widget.icon),
        keyboardType: widget.keyboard,
      ),
    );
  }
}
