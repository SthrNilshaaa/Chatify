import 'package:chatify/providers/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widgets/appTopBar.dart';
//import '../Widgets/custom_list_view.dart';
//import '../Widgets/Custom_input_field.dart';
import '../models/chat.dart';
//import '../models/chat_message.dart';
//import '../providers/chats_page_provider.dart';
import '../providers/onechatprovider.dart';

class PerPersonChatPage extends StatefulWidget {
  final Chat chat;

  const PerPersonChatPage({Key? key, required this.chat}) : super(key: key);

  @override
  State<PerPersonChatPage> createState() => _OneChatPaheState();
}

class _OneChatPaheState extends State<PerPersonChatPage> {
  late double _deviceHeight;
  late double _deviceWidght;
  late AuthenticationProvider _auth;
  late GlobalKey<FormState> _messageForState;
  late ScrollController _messagrListViewController;
  late ChatPageProvider _pageProvider;
  @override
  void initState() {
    super.initState();
    _messageForState = GlobalKey<FormState>();
    _messagrListViewController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<AuthenticationProvider>(context);

    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidght = MediaQuery.of(context).size.width;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatPageProvider>(
          create: (_) => ChatPageProvider(widget.chat.uid, _auth, _messagrListViewController),
        )
      ],
      child: BuildUi(),
    );
  }

  Widget BuildUi() {
    return Builder(
      builder: (BuildContext context) {
        _pageProvider = context.watch<ChatPageProvider>();
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _deviceWidght * 0.02,
                vertical: _deviceHeight * 0.03,
              ),
              child: Container(
                height: _deviceHeight,
                width: _deviceWidght * 0.98,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AppTopBar(
                      this.widget.chat.title(),
                      fontssize: 20,
                      secondryAction: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_rounded)),
                      primaryaction: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.delete),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
