import 'dart:async';
//import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../services/cloud_services.dart';
import '../services/media_picker.dart';
import 'authentication_provider.dart';
import '../services/navigation_services.dart';
import '../models/chat_message.dart';

class ChatPageProvider extends ChangeNotifier {
  late DatabaseService _db;
  late CloudStorageServices _storage;
  late MediaService _media;
  late NavigationServices _navigation;
  AuthenticationProvider _auth;
  ScrollController _messageListViewController;
  String _chatId;
  List<ChatMessage>? messages;
  late StreamSubscription _messagesStream;

  String? _message;
  String get message {
    return message;
  }

  ChatPageProvider(this._chatId, this._auth, this._messageListViewController) {
    _db = GetIt.instance.get<DatabaseService>();
    _media = GetIt.instance.get<MediaService>();
    _storage = GetIt.instance.get<CloudStorageServices>();
    _navigation = GetIt.instance.get<NavigationServices>();
    listenToMessages();
  }
  @override
  void dispose() {
    _messagesStream.cancel();
    super.dispose();
  }

  void listenToMessages() {
    try {
      _messagesStream = _db.streamMessageForchat(_chatId).listen(
        (_snapshot) {
          List<ChatMessage> _messages = _snapshot.docs.map(
            (_m) {
              Map<String, dynamic> _message = _m.data() as Map<String, dynamic>;
              return ChatMessage.fromJson(_message);
            },
          ).toList();
          messages = _messages;
          notifyListeners();
        },
      );
    } catch (e) {
      print("Error geting messages");
      print(e);
    }
  }

  void goback() {
    _navigation.gobback();
  }
}
