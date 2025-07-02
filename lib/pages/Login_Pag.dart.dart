import 'package:chatify/providers/authentication_provider.dart';
import 'package:chatify/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:get_it/get_it.dart';
import '../Widgets/Custom_input_field.dart';
import '../Widgets/button.dart';

class LoginPagDart extends StatefulWidget {
  const LoginPagDart({Key? key}) : super(key: key);

  @override
  _LoginPagDartState createState() => _LoginPagDartState();
}

class _LoginPagDartState extends State<LoginPagDart> {
  late double _dHeight;
  late double _dWeight;
  final _loginFormKey = GlobalKey<FormState>();

  String? _email;
  String? _password;
  late AuthenticationProvider _auth;
  late NavigationServices _navigation;

  @override
  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<AuthenticationProvider>(context);
    _navigation = GetIt.instance.get<NavigationServices>();
    _dHeight = MediaQuery.of(context).size.height;
    _dWeight = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(10, 10, 10, 1),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GradientText(
              "Chatify",
              style: GoogleFonts.sansita(fontSize: 60, fontWeight: FontWeight.bold),
              colors: const [Colors.blue, Colors.red, Colors.purple],
            ),
            SizedBox(
              height: _dHeight * 0.05,
            ),
            _FormFild(),
            SizedBox(
              height: _dHeight * 0.02,
            ),
            _loginbotton(),
            SizedBox(
              height: _dHeight * 0.03,
            ),
            _registerAccount()
          ],
        ),
      ),
    );
  }

  _FormFild() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            CustomInputField(
                onSaved: (_value) {
                  setState(() {
                    _email = _value;
                  });
                },
                name: "Enter a valid Email",
                hintText: "Email",
                obscureText: false,
                regEx: r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'),
            const SizedBox(
              height: 20,
            ),
            CustomInputField(
                name: "Enter a valid Password",
                onSaved: (_value) {
                  setState(() {
                    _password = _value;
                  });
                },
                hintText: "Password",
                obscureText: true,
                regEx: r".{8,}")
          ],
        ),
      ),
    );
  }

  Widget _loginbotton() {
    return Button(
      Bcolor: const Color.fromRGBO(0, 80, 218, 1),
      name: 'Login',
      height: _dHeight * 0.07,
      onPressed: () async {
        bool result = await InternetConnection().hasInternetAccess;
        if (result == true) {
          if (_loginFormKey.currentState!.validate()) {
            _loginFormKey.currentState!.save();
            _auth.loginusingEmailandpassword(_email!, _password!);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'No Internet Connection',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      width: _dWeight * 0.4,
      textSize: 25,
    );
  }

  Widget _registerAccount() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/register');
      },
      child: GradientText(
        "Don't have account?",
        style: const TextStyle(fontSize: 15),
        colors: const [Colors.blue, Colors.red, Colors.purple],
      ),
    );
  }
}
