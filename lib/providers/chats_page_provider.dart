import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/database_service.dart';
import 'authentication_provider.dart';
import '../models/chat.dart';
import '../models/chat_message.dart';
import '../models/chat_user.dart';

class ChatsPageProvider extends ChangeNotifier {
  AuthenticationProvider _auth;
  late DatabaseService _db;
  late List<Chat> chats = [];
  late StreamSubscription _chatstream;
  ChatsPageProvider(
    this._auth,
  ) {
    _db = GetIt.instance.get<DatabaseService>();
    getChats();
  }
  @override
  void dispose() {
    _chatstream.cancel();
    super.dispose();
  }

  void getChats() async {
    try {
      _chatstream = _db.getChatsForUser(_auth.user.uid).listen(
        (snapshot) async {
          chats = await Future.wait(
            snapshot.docs.map(
              (_d) async {
                Map<String, dynamic> chatData = _d.data() as Map<String, dynamic>;

                //get user im chat
                List<ChatUser> _member = [];
                for (var _uid in chatData["members"]) {
                  DocumentSnapshot _userSnapshot = await _db.getUser(_uid);
                  Map<String, dynamic> _userData = _userSnapshot.data() as Map<String, dynamic>;
                  _userData["uid"] = _userSnapshot.id;
                  _member.add(ChatUser.fromJSON(_userData));
                }

                //get last message
                List<ChatMessage> _messages = [];
                QuerySnapshot _chatMessage = await _db.getLastMessageForChat(_d.id);
                if (_chatMessage != null) {
                  Map<String, dynamic> _messageData = _chatMessage.docs.first.data()! as Map<String, dynamic>;
                  ChatMessage _message = ChatMessage.fromJson(_messageData);
                  _messages.add(_message);
                }

                //return chat instance
                return Chat(
                  uid: _d.id,
                  currectUserUid: _auth.user.uid,
                  activity: chatData["is_activity"],
                  group: chatData["is_group"],
                  members: _member,
                  messages: _messages,
                );
              },
            ).toList(),
          );
          notifyListeners();
        },
      );
    } catch (e) {
      print("Error getting message");
      print(e);
    }
  }
}
