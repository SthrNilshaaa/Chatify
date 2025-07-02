import 'package:chatify/Widgets/appTopBar.dart';
import 'package:chatify/models/chat.dart';
import 'package:chatify/models/chat_message.dart';
import 'package:chatify/models/chat_user.dart';
import 'package:chatify/providers/chats_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../services/navigation_services.dart';
import '../Widgets/custom_list_view.dart';
import '../providers/authentication_provider.dart';
import 'one_chat_pahe.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late double _deviceHigth;
  late AuthenticationProvider _auth;
  late double _deviceWigth;
  late ChatsPageProvider _pageProvider;
  late NavigationServices _navigationServices;
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
    _navigationServices = GetIt.instance.get<NavigationServices>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatsPageProvider>(
          create: (_) => ChatsPageProvider(_auth),
        ),
      ],
      child: _buitUi(),
    );
  }

  Widget _buitUi() {
    return Builder(
      builder: (BuildContext context) {
        _pageProvider = context.watch<ChatsPageProvider>();
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
                  "Chatify",
                  fontssize: 40,
                  primaryaction: IconButton(
                      onPressed: () async {},
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      )),
                ),
              ),
              _chatList()
              // else Container(height: 20,width: double.infinity,color: Colors.red,child: Center(child: Text("NO Internet",style: TextStyle(color: Colors.white),),),)
            ],
          ),
        );
      },
    );
  }

  Widget _chatList() {
    List<Chat>? chats = _pageProvider.chats;

    return Expanded(
      child: (() {
        if (chats != null) {
          if (chats.isNotEmpty) {
            return ListView.builder(
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return _chatTile(
                  chats[index],
                );
              },
            );
          } else {
            return Center(
              child: GradientText(
                "No Chats",
                style: GoogleFonts.sansita(fontSize: 30, fontWeight: FontWeight.bold),
                colors: const [Colors.blue, Colors.red, Colors.purple],
              ),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }
      })(),
    );
  }

  Widget _chatTile(Chat _chat) {
    List<ChatUser> _recepients = _chat.recepients();
    bool _isActive = _recepients.any(
      (element) => element.wasRecentlyActive(),
    );
    String _subtitleText = "";
    if (_chat.messages.isNotEmpty) {
      _subtitleText = _chat.messages.first.type != MessageType.TEXT ? "Media Attachment" : _chat.messages.first.content;
    }
    return Padding(
      padding: EdgeInsets.only(left: _deviceWigth * 0.02),
      child: CustomListView(
        Height: _deviceHigth * 0.1,
        title: _chat.title(),
        subtitle: _subtitleText,
        imagePath: _chat.imageURL(),
        isActive: _isActive,
        isActivity: _chat.activity,
        onTap: () {
          _navigationServices.navigaterToPage(
            PerPersonChatPage(chat: _chat),
          );
        },
      ),
    );
  }
}
