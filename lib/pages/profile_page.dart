import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:provider/provider.dart';

import '../Widgets/appTopBar.dart';
import '../providers/authentication_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late double _deviceHigth;

  late AuthenticationProvider _auth;
  late double _deviceWigth;
  Future<bool> result = InternetConnection().hasInternetAccess;
  @override
  void initState() {
    super.initState();
    result;
  }

  @override
  Widget build(BuildContext context) {
    _deviceHigth = MediaQuery.of(context).size.height;
    _deviceWigth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    return _buitUi();
  }

  Widget _buitUi() {
    return Container(
      padding: EdgeInsets.only(
        top: _deviceHigth * 0.03,
      ),
      height: _deviceHigth * 0.98,
      width: _deviceWigth * 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: _deviceWigth * 0.05),
            child: AppTopBar(
              "Profile",
              fontssize: 40,
              primaryaction: IconButton(
                onPressed: () async {
                  _auth.logout();
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
