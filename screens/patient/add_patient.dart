import 'package:flutter/material.dart';

//Firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

//Other
import 'package:email_validator/email_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:io';

//Apptheme
import 'package:flutter_app/default.dart';

//Widgets
import 'package:flutter_app/custom_widgets/loading_screen.dart';
import 'package:flutter_app/list_search/list_search.dart';

//Storage
import 'package:flutter_app/storage/cloud_storage.dart';
import 'package:flutter_app/storage/storage.dart';

//Model
import 'package:flutter_app/classes/Patient_name_list.dart';

class AddPatient extends StatefulWidget {
  Patient_name_data_list? patient_data;

  List<String> all_patient_name_list;

  bool icon_tap;

  AddPatient(this.all_patient_name_list, this.icon_tap, {this.patient_data});

  @override
  _AddPatientState createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  File? file;

  Patient_name_data_list? patient_instace;

  late List<String> patient_name_list;

  List<String> Blood_Group = [];

  bool is_saving= false;


  var name_edit = TextEditingController();
  var age_edit = TextEditingController();
  var address_edit = TextEditingController();
  var email_edit = TextEditingController();
  var mobile_edit = TextEditingController();
  var group_edit = TextEditingController();
  var blood_group_edit = TextEditingController();

  String? profile_link = '';

  bool profile_img_delete = false;

  bool male = false, female = false;

  String? getFileExtension(String fileName) {
    try {
      return "." + fileName.split('.').last;
    } catch (e) {
      return null;
    }
  }
  Future<void> imagepicker(ImageSource source) async {
    final image =
        await ImagePicker().pickImage(source: source, imageQuality: 50);

    if (image == null) return null;

    setState(() {
      this.file = File(image.path);
      profile_link = "";
    });

    return;
  }

  void init_start() {

    if (widget.patient_data != null) {
      setState(() {
        final x = widget.patient_data!;

        name_edit.text = x.name;

        mobile_edit.text = x.mobile.toString();

        age_edit.text = x.age ?? '';

        Blood_Group.add(x.blood_group ?? "");

        x.gender == "Male"
            ? male = true
            : x.gender == "Female"
                ? female = true
                : null;

        profile_link = x.profile_link ?? '';
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init_start();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: WillPopScope(
        onWillPop: ()async{

          if(is_saving);
          else
            {
              Navigator.pop(context   , 'back');
            }

          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppTheme.teal,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                if(is_saving);
                else
                {
                  Navigator.pop(context   , 'back');
                }
              },
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Patient'),
                IconButton(
                  onPressed: () async {

                    is_saving = true;

                    if (name_edit.text != null && name_edit.text.isNotEmpty) {

                      bool isSame = false;

                      if (widget.icon_tap) {

                        for (int i = 0; i < patient_name_list.length; i++) {
                          if (name_edit.text == patient_name_list[i]) {
                            isSame = true;
                            break;
                          }
                        }
                      }
                      if (isSame && widget.icon_tap) {
                        ShowDialogue(context,
                            'Name is similar to another patient\nPlease change the name');
                      } else {

                        SnackOn(context, 'Saving Patient Details...');

                        if (email_edit.text.isNotEmpty) {
                          if (!EmailValidator.validate(email_edit.text)) {
                            ShowDialogue(context, 'Invalid Email Address');
                          }
                        }

                        if (mobile_edit.text.isEmpty) {
                          ShowDialogue(context, ' Mobile no. is Compulsory');
                        }

                        if (mobile_edit.text.length != 10) {
                          ShowDialogue(context, 'Invalid Mobile no.');
                        }

                        Map<String,dynamic>  json={};
                        male == true
                            ? json['gender'] = 'Male'
                            : female == true
                            ? json['gender'] = 'Female'
                            : null;

                        if (age_edit.text.isNotEmpty) {
                          json['age'] = age_edit.text;
                        }
                        if (address_edit.text.isNotEmpty) {
                          json['address'] = address_edit.text;
                        }
                        if (email_edit.text.isNotEmpty) {
                          json['email'] = email_edit.text;
                        }
                        if (blood_group_edit.text.isNotEmpty) {
                          json['blood_group'] = blood_group_edit.text;
                        }
                        if (profile_link != null) {
                          profile_link!.isNotEmpty
                              ? json['profile_link'] = profile_link!
                              : null;
                        }



                        if (widget.icon_tap) {

                          final doc = await FirebaseFirestore.instance
                              .collection('Patient')
                              .doc();

                          if (file != null) {
                            if (getFileExtension(file!.path) != null) {
                              var link =
                                  Cloud_Storage.Patient_Profile_Image_Upload(
                                      doc_id: doc.id,
                                      file: file!,
                                      file_name: "Profile" +
                                          getFileExtension(file!.path)!);

                              final snapshot = await link.whenComplete(() {});
                              profile_link = await snapshot.ref.getDownloadURL();
                            }
                          }

                         json = {
                            'name': name_edit.text,
                            'mobile': mobile_edit.text,
                            'doc_id': doc.id,
                          };



                          doc.set(json);
                        }

                        else if (widget.icon_tap == false) {

                          if (file != null) {
                            if (getFileExtension(file!.path) != null) {
                              var link =
                                  Cloud_Storage.Patient_Profile_Image_Upload(
                                      doc_id: widget.patient_data!.doc_id,
                                      file: file!,
                                      file_name: "Profile" +
                                          getFileExtension(file!.path)!);

                              final snapshot = await link.whenComplete(() {});
                              profile_link = await snapshot.ref.getDownloadURL();
                            }
                          }

                          json = {
                            'name': name_edit.text,
                            'mobile': mobile_edit.text,
                          };



                          await FirebaseFirestore.instance
                              .collection('Patient')
                              .doc(widget.patient_data!.doc_id)
                              .update(json);
                        }

                        SnackOff(context: context);

                        Navigator.pop(context);
                      }
                    }

                    else {
                      ShowDialogue(
                          context, 'Name is Compulsory\nPlease write the name');
                    }

                    is_saving = false;

                  },
                  icon: Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          body: SingleChildScrollView(
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
                      child: file != null
                          ? Image.file(
                              file!,
                              fit: BoxFit.cover,
                              height: 40.w,
                              width: 40.w,
                            )
                          : profile_link != null
                              ? Image.network(
                                  profile_link!,
                                  height: 40.w,
                                  width: 40.w,
                                  fit: BoxFit.fill,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircleAvatar(
                                        radius: 20.w,
                                        backgroundColor: Colors.white70,
                                        child: const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : CircleAvatar(
                                  backgroundColor: AppTheme.grey,
                                  radius: 20.w,
                                  child: Icon(
                                    Icons.person_add_outlined,
                                    color: Colors.white,
                                  ),
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
                          profile_link != null
                              ? profile_link!.isNotEmpty
                                  ? FirebaseStorage.instance
                                      .refFromURL(profile_link!)
                                      .delete()
                                  : null
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

                txtfield(
                  name_edit,
                  "Name",
                  TextInputType.text,
                  Icon(Icons.person_outline),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ChoiceChip(
                      label: Text('Male'),
                      selected: male,
                      selectedColor: Colors.teal,
                      onSelected: (bool selected) {
                        setState(() {
                          male = true;
                          female = false;
                        });
                      },
                    ),
                    ChoiceChip(
                      label: Text(
                        'Female',
                      ),
                      selected: female,
                      selectedColor: Colors.teal,
                      onSelected: (bool a) {
                        setState(() {
                          male = false;
                          female = true;
                        });
                      },
                    ),
                    Container(
                        width: 39.w,
                        child: TextField(
                          controller: age_edit,
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
                            hintText: "Age",
                            prefixIcon: Icon(Icons.cake_outlined),
                          ),
                          keyboardType: TextInputType.number,
                        )),
                  ],
                ),

                txtfield(
                  address_edit,
                  "Address",
                  TextInputType.text,
                  Icon(Icons.place_outlined),
                ),
                txtfield(
                  email_edit,
                  "Email",
                  TextInputType.emailAddress,
                  Icon(Icons.email),
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
                        labelText: 'Mobile no.',
                        prefixIcon: Icon(Icons.call)),
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                  ),
                ),

                Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 6.w),
                    child: TextField(
                      controller: blood_group_edit,
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
                          labelText: "Blood Group",
                          prefixIcon: Icon(Icons.medication),
                          // ignore: void_checks
                          suffixIcon: IconButton(
                            icon: Icon(Icons.arrow_drop_down_circle_outlined),
                            onPressed: () {
                              setState(() {
                                blood_group_edit.text = "";
                              });


                                Blood_Group[0] = blood_group_edit.text;

                                showDialog(
                                    context: context,
                                    builder: (context) => List_Search(
                                        result: Blood_Group,
                                        get: Storage.get,
                                        set: Storage.set,
                                        group: 'blood_group',
                                        Group: 'Blood_Group',
                                        one_select: true,
                                        ky: Storage.blood_group)).then((value) {



                                      setState(() {
                                        blood_group_edit.text = value[0];
                                        if(value.isEmpty)
                                          {
                                            blood_group_edit.text='';
                                          }
                                      });


                                });

                            },
                          )),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class txtfield extends StatefulWidget {
  txtfield(
    this.text_edit,
    this.hint,
    this.keyboard,
    this.icon,
  );

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
