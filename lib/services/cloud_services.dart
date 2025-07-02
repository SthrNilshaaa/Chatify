import 'package:file_picker/file_picker.dart';
//import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

const String USER_COLLECTION = "Users";

class CloudStorageServices {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  CloudStorageServices() {}
  Future<String?> saveUserImageToStorage(String _uid, PlatformFile _file) async {
    try {
      Reference _ref = _storage.ref().child("image/users/$_uid/profile.${_file.extension}");
      UploadTask _task = _ref.putFile(File(_file.path as String));
      return await _task.then((result) => result.ref.getDownloadURL());
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<String?> saveChatImageToStoorage(String _chatID, String _userId, PlatformFile _file) async {
    try {
      Reference _ref = _storage.ref().child(
            "image/chats/$_chatID/${_userId}_${Timestamp.now().millisecondsSinceEpoch}.${_file.extension}",
          );
      UploadTask _task = _ref.putFile(
        File(_file.path as String),
      );
      return await _task.then((result) => result.ref.getDownloadURL());
    } catch (e) {
      print(e);
    }
    return null;
  }
}
