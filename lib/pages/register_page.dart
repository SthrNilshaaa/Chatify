//packeage
//import 'dart:io';

import 'package:chatify/Widgets/rounded_image.dart';
import 'package:chatify/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:provider/provider.dart';
//services
import '../services/media_picker.dart';
import '../services/cloud_services.dart';
import '../services/database_service.dart';
//widget
import '../Widgets/Custom_input_field.dart';
import '../Widgets/button.dart';
//provider
import '../providers/authentication_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late double _deviceheight;
  late double _devicesWidth;
  PlatformFile? _profileImage;
  String? _name;
  String? _password;
  String? _email;
  late AuthenticationProvider _auth;
  late DatabaseService _db;
  late CloudStorageServices _cloudStorageServices;
  late NavigationServices _navigation;

  final _registerFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<AuthenticationProvider>(context);
    _db = GetIt.instance.get<DatabaseService>();
    _cloudStorageServices = GetIt.instance.get<CloudStorageServices>();
    _navigation = GetIt.instance.get<NavigationServices>();
    _deviceheight = MediaQuery.of(context).size.height;
    _devicesWidth = MediaQuery.of(context).size.width;
    return _registerUI();
  }

  Widget _registerUI() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.only(top: _deviceheight * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _profileimage(),
            SizedBox(
              height: _deviceheight * 0.03,
            ),
            _registerForm(),
            SizedBox(
              height: _deviceheight * 0.03,
            ),
            _registerBottom(),
          ],
        ),
      ),
    );
  }

  Widget _registerBottom() {
    return Button(
        name: "Register",
        height: _deviceheight * 0.07,
        width: _devicesWidth * 0.5,
        onPressed: () async {
          bool result = await InternetConnection().hasInternetAccess;
          if (result == true) {
            if (_registerFormKey.currentState!.validate()) {
              if (_profileImage != null) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Wait For 2 Seconds'),
                  backgroundColor: Color.fromARGB(255, 70, 54, 244),
                ));
                _registerFormKey.currentState!.save();
                String? _uid = await _auth.regiterUserUsingEmailPassword(_email!, _password!);
                String? imageURL = await _cloudStorageServices.saveUserImageToStorage(_uid!, _profileImage!);
                await _db.createUser(_uid, _email!, _name!, imageURL!);
                await _db.updateuserlastTime(_uid);
                await _auth.logout();
                await _auth.loginusingEmailandpassword(_email!, _password!);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Please add Profile Picture', style: TextStyle(color: Colors.white)),
                  backgroundColor: Color.fromARGB(255, 70, 54, 244),
                ));
              }
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('No Internet Connection', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.red,
            ));
          }
        },
        textSize: 20,
        Bcolor: const Color.fromRGBO(0, 80, 218, 1));
  }

  Widget _registerForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: _deviceheight * 0.35,
        child: Form(
            key: _registerFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomInputField(
                    onSaved: (p0) {
                      setState(() {
                        _name = p0;
                      });
                    },
                    hintText: "Name",
                    regEx: r'.{5,}',
                    obscureText: false,
                    name: "Use Mininum 5 letters in Name"),
                CustomInputField(
                    onSaved: (p0) {
                      setState(() {
                        _email = p0;
                      });
                    },
                    hintText: "Email",
                    regEx: r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    obscureText: false,
                    name: "Use Currect Email"),
                CustomInputField(
                    onSaved: (p0) {
                      setState(() {
                        _password = p0;
                      });
                    },
                    hintText: "Password",
                    regEx: r'.{8,}',
                    obscureText: true,
                    name: "Use Mininum 8 letters in Password "),
              ],
            )),
      ),
    );
  }

  Widget _profileimage() {
    return GestureDetector(onTap: () {
      GetIt.instance.get<MediaService>().pickImageFromLibrary().then((value) {
        setState(() {
          _profileImage = value;
        });
      });
    }, child: () {
      if (_profileImage != null) {
        return RoundedImageFile(
          image: _profileImage!,
          size: _deviceheight * 0.20,
          key: UniqueKey(),
        );
      } else {
        return RoundedImageNetwork(key: UniqueKey(), imagePath: "assets/profile.jpg", size: _deviceheight * 0.15);
      }
    }());
  }
}
