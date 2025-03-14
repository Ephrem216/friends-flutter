import 'dart:io';

import 'package:flutter/material.dart';
import 'package:friends/friend.dart';
import 'package:image_picker/image_picker.dart';

class NewPage extends StatefulWidget {
  const NewPage({super.key, this.friend});
  final Friend? friend;
  @override
  State<StatefulWidget> createState() {
    return _NewPageState();
  }
}

class _NewPageState extends State<NewPage> {
  late String name;
  late String dream;
  late String profile;
  late TextEditingController nameController;
  late TextEditingController dreamController;
  final _formKey = GlobalKey<FormState>();
  File? _image;

  @override
  void initState() {
    super.initState();
    if (widget.friend != null) {
      name = widget.friend!.name;
      dream = widget.friend!.dream;
      profile = widget.friend!.profile;
      nameController = TextEditingController(text: name);
      dreamController = TextEditingController(text: dream);
    } else {
      name = '';
      dream = '';
      profile = '';
      nameController = TextEditingController();
      dreamController = TextEditingController();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    dreamController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource imageSource) async {
    final imagePicker = ImagePicker();
    final filePicked = await imagePicker.pickImage(source: imageSource);

    if (filePicked != null) {
      setState(() {
        _image = File(filePicked.path);
      });
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Color(0xFF505081),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(
          'Choose image source',
          style: TextStyle(
            color: Color(0xFFBABAE0),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                Icons.camera,
                color: Color(0xFFBABAE0),
              ),
              title: Text(
                'Camera',
                style: TextStyle(
                  color: Color(0xFFBABAE0),
                ),
              ),
              onTap: () {
                Navigator.pop(ctx);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.photo,
                color: Color(0xFFBABAE0),
              ),
              title: Text(
                'Gallery',
                style: TextStyle(
                  color: Color(0xFFBABAE0),
                ),
              ),
              onTap: () {
                Navigator.pop(ctx);
                _pickImage(ImageSource.gallery);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _imageWidget() {
    if (_image != null) {
      return Image.file(
        _image!,
        width: 120,
      );
    }

    return widget.friend != null
        ? widget.friend!.profile.startsWith('assets/')
            ? Image.asset(widget.friend!.profile)
            : Image.file(File(widget.friend!.profile))
        : Image.asset('assets/avatar2.png');
  }

  String _getProfile() {
    if (_image != null) {
      return _image!.path;
    }

    return widget.friend != null ? profile : 'assets/avatar2.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0F0E47),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xFFBABAE0),
        ),
        title: Text(
          widget.friend == null ? 'New friend' : 'Edit Freind',
          style: TextStyle(
            color: Color(0xFFBABAE0),
          ),
        ),
        backgroundColor: Color(0xff272757),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 30,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      // color: Color(0xff505081),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xff505081),
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: _imageWidget(),
                    ),
                  ),
                  IconButton(
                    onPressed: _showImageSourceDialog,
                    icon: Icon(
                      Icons.camera_enhance,
                      size: 30,
                    ),
                    color: Color(0xff505081),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                maxLength: 30,
                controller: nameController,
                cursorColor: Color(0xFFBABAE0),
                style: TextStyle(
                  color: Color(0xFFBABAE0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter you name here';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    // borderSide: BorderSide(
                    //   color: Color(0xFFBABAE0),
                    // ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xff505081),
                    ),
                  ),
                  labelText: 'Name',
                  hintText: 'Enter your friend\'s full name',
                  hintStyle: TextStyle(
                    color: Color(0xFF4A4A7E),
                  ),
                  labelStyle: TextStyle(
                    color: Color(0xFFBABAE0),
                    fontSize: 16,
                  ),
                ),
              ),
              TextFormField(
                maxLines: 3,
                maxLength: 300,
                controller: dreamController,
                cursorColor: Color(0xFFBABAE0),
                style: TextStyle(
                  color: Color(0xFFBABAE0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter you dream here';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xFFBABAE0),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xff505081),
                    ),
                  ),
                  labelText: 'Dream',
                  hintText: 'Describe what your friend aspires to achieve',
                  hintStyle: TextStyle(
                    color: Color(0xFF4A4A7E),
                  ),
                  labelStyle: TextStyle(
                    color: Color(0xFFBABAE0),
                    fontSize: 16,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(
                          context,
                          Friend(
                            name: nameController.text,
                            dream: dreamController.text,
                            profile: _getProfile(),
                          ),
                        );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith(
                        (states) {
                          if (states.contains(WidgetState.pressed)) {
                            return Color(0xFF5757A6);
                          }
                          return Color(0xFF505081);
                        },
                      ),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    child: Text(
                      widget.friend == null ? 'Add Friend' : 'Save',
                      style: TextStyle(
                        color: Color(0xFFFFffff),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // TextButton(
                  //   onPressed: () {},
                  //   style: ButtonStyle(
                  //     backgroundColor: WidgetStateProperty.all(
                  //       Color(0xFF577BC1),
                  //     ),
                  //     shape: WidgetStatePropertyAll(
                  //       RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.all(Radius.circular(10)),
                  //       ),
                  //     ),
                  //   ),
                  //   child: Text(
                  //     'Cancel',
                  //     style: TextStyle(
                  //       color: Color(0xFFFFffff),
                  //       fontSize: 18,
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //   ),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
