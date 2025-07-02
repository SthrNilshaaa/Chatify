//import 'package:chatify/Widgets/button.dart';
import 'package:chatify/pages/chats_page.dart';
import 'package:chatify/pages/profile_page.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
//import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../providers/authentication_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentpage = 0;
  late AuthenticationProvider _auth;
  final List<Widget> _pages = [
    ChatPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<AuthenticationProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: _pages[_currentpage],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentpage,
          onTap: (value) {
            setState(() {
              _currentpage = value;
            });
          },
          iconSize: 25,
          elevation: 3,
          backgroundColor: Colors.black,
          selectedFontSize: 18,
          fixedColor: Color.fromARGB(255, 40, 79, 209),
          items: const [
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.chat_rounded),
              icon: Icon(
                Icons.chat_outlined,
              ),
              label: "Chats",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.supervisor_account),
              icon: Icon(
                Icons.supervisor_account_outlined,
              ),
              label: " Profile",
            ),
          ]),
    );
  }
}
