import 'dart:convert';

import 'package:chats/cores/services/api_services/rest_api_services.dart';
import 'package:chats/cores/services/firebase_services.dart';
import 'package:chats/cores/services/hive_services.dart';
import 'package:chats/cores/services/shared_pref_services.dart';
import 'package:chats/models/hive_models/conversation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeState with ChangeNotifier {
  ApiServices apiServices = ApiServices();
  HiveServices hiveServices = HiveServices();
  FirebaseServices firebaseServices = FirebaseServices();
  List<Conversation> conversations = [];

  String mockJsonResponseListData = '''
{
    "conversations": [
        {
            "_id": "67123110ee867f43680865eb",
            "members": [
                "LvPofv5wznXEynnUvQUgw6ntNoq2",
                "dz5oah5b3HOYeJpNwThtyPLwMJ62"
            ],
            "messages": [
                {
                    "sender_id": "dz5oah5b3HOYeJpNwThtyPLwMJ62",
                    "text": "okay",
                    "timestamp": "2024-10-18T10:06:55.478Z",
                    "read": false,
                    "_id": "6712333fee867f43680865f1"
                },                                                 
                {
                    "sender_id": "dz5oah5b3HOYeJpNwThtyPLwMJ62",
                    "text": "okay",
                    "timestamp": "2024-10-18T11:45:37.617Z",
                    "read": false,
                    "_id": "67124a61d7f783c09f123d11"
                }
            ],
            "__v": 15
        }
    ]
}
''';

  /* String userId = 'LvPofv5wznXEynnUvQUgw6ntNoq2';
    final url = '${ApiUrls.getConversation}$userId';
    final response = await apiServices.getApi(url);*/
  Future<List<Conversation>> fetchConversations() async {
    String currentUserId = await SharedPrefServices.getPreference('uid');
    final List<dynamic> jsonResponse =
        json.decode(mockJsonResponseListData)['conversations'];

    for (var conv in jsonResponse) {
      Conversation conversation = Conversation.fromJson(conv);

      String partnerId = conversation.members
          .firstWhere((memberId) => memberId != currentUserId);

      UserData userData = await fetchUserData(partnerId);

      conversation = conversation.copyWith(userDetails: userData);
      conversations.add(conversation);
    }
    return conversations;
  }

  Future<UserData> fetchUserData(String partnerId) async {
    DocumentSnapshot user = await firebaseServices.getDocument(
        collectionPath: 'Users', userId: partnerId);
    UserData userData = UserData.fromJson(user.data() as Map<String, dynamic>);
    return userData;
  }

  Future<void> storeConversationFormApi() async {
    var box = await hiveServices.openBox();

    if (box.isEmpty) {
      print('Box is empty. Adding new conversations.');
      await fetchConversations();
      // Add all conversations to the box
      await Future.forEach(conversations, (conversation) async {
        await hiveServices.addConversation(conversation);
      });
    } else {
      print('Box is not empty. Updating conversations.');
      // Update existing conversations
      for (int i = 0; i < conversations.length; i++) {
        if (i < box.length) {
          await hiveServices.updateConversation(i, conversations[i]);
        } else {
          // If the box has fewer items, add new conversations
          await hiveServices.addConversation(conversations[i]);
        }
      }
    }
    // Optional: Print the conversations for debugging
    for (var conversation in conversations) {
      print('Conversation: $conversation');
    }
  }

  Future<void> clear() async {
    await hiveServices.clearBox();
  }
}
