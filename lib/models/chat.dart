// import 'package:flutter/material.dart';
import 'chat_message.dart';
import 'chat_user.dart';

class Chat {
  final String uid;
  final String currectUserUid;
  final bool activity;
  final bool group;
  final List<ChatUser> members;
  List<ChatMessage> messages;

  late final List<ChatUser> _recepients;
  Chat({
    required this.uid,
    required this.currectUserUid,
    required this.activity,
    required this.group,
    required this.members,
    required this.messages,
  }) {
    _recepients = members.where((_i) => _i.uid != currectUserUid).toList();
  }
  List<ChatUser> recepients() {
    return _recepients;
  }

  String title() {
    return !group ? _recepients.first.name : _recepients.map((_user) => _user.name).join(",  ");
  }

  String imageURL() {
    return !group
        ? _recepients.first.name
        : "https://www.shareicon.net/data/128x128/2016/05/24/770117_people_512x512.png";
  }
}
