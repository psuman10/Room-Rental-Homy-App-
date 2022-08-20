import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:homy_app/app/data/models/user.dart';
import 'package:homy_app/app/data/services/profile_service.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/values/colors.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key, required this.user}) : super(key: key);

  final UserModel user;

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  UserModel get _user => widget.user;

  late TextEditingController _fullNameController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();
  XFile? image;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: _user.fullName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Edit Profile", style: Theme.of(context).textTheme.headline4),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return Dialog(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        GestureDetector(
                          onTap: () async {
                            final _image = await _picker.pickImage(
                                source: ImageSource.camera);
                            Navigator.pop(context);
                            setState(() {
                              image = _image;
                            });
                          },
                          child: Container(
                            height: 200.0,
                            color: primaryBlue,
                            width: double.infinity,
                            child: const Icon(
                              Icons.camera_alt,
                              size: 50.0,
                              color: white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final _image = await _picker.pickImage(
                                source: ImageSource.gallery);
                            Navigator.pop(context);

                            setState(() {
                              image = _image;
                            });
                          },
                          child: Container(
                            height: 200.0,
                            color: white,
                            child: const Icon(
                              Icons.photo,
                              size: 50.0,
                              color: primaryBlue,
                            ),
                          ),
                        )
                      ]),
                    );
                  });
            },
            child: Container(
              height: 100.0,
              alignment: Alignment.center,
              width: 100.0,
              decoration: BoxDecoration(
                border: Border.all(color: primaryBlue),
                borderRadius: BorderRadius.circular(12.0),
                image: image != null
                    ? DecorationImage(
                        image: FileImage(File(image!.path)),
                        fit: BoxFit.cover,
                      )
                    : (_user.profileURL != null
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              _user.profileURL!,
                            ))
                        : const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              "assets/images/user.png",
                            ),
                          )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(_user.email!.toString()),
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextFormField(
                controller: _fullNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Full Name is required";
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(labelText: "Full Name"),
              ),
            ),
          ),
          SizedBox(
            width: 200.0,
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  if (image != null) {
                    EasyLoading.show(status: "Uploading..");
                    final updatedResponse = await ProfileService().uploadImage(
                      File(image!.path),
                      _fullNameController.text,
                      _user.uuid!,
                    );
                    updatedResponse.fold((fail) {
                      EasyLoading.showError(fail.message);
                    }, (success) {
                      EasyLoading.showSuccess("Successfully updated profile");
                    });
                  }
                }
              },
              child: const Text("Update"),
            ),
          )
        ],
      ),
    );
  }
}
