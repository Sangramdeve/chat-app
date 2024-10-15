import 'package:chats/cores/const/const_value.dart';
import 'package:chats/cores/services/api_services/rest_api_services.dart';
import 'package:chats/cores/services/hive_services.dart';
import 'package:chats/models/hive_models/conversation.dart';
import 'package:flutter/material.dart';

import '../cores/const/api_urls.dart';

class HomeState with ChangeNotifier {
  ApiServices apiServices = ApiServices();
  HiveServices hiveServices = HiveServices();


  Future<void> findConversation() async {
    // Fetch conversations (mocked in this case)
    final List<Conversation> conversations = Values.mockJsonResponseList
        .map((json) => Conversation.fromJson(json))
        .toList();

    var box = await hiveServices.openBox();

    if (box.isEmpty) {
      print('Box is empty. Adding new conversations.');
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


  Future<void> createConversation() async {
    final data = {
      "members": ["user_id_2", "user_id_4"],
      "messages": []
    };
    final url = ApiUrls.createConversation;
    final response = await apiServices.postApi(url, data);
    print('home state $response');
  }

  Future<void> sendMessages() async {
    final data = {"sender_id": 'user_id_2', "text": 'hello'};
    String id = '66fe28037970483b2f4d0698';
    final url = '${ApiUrls.sendMessages}$id';
    final response = await apiServices.postApi(url, data);
    print('home state $response');
  }
}
