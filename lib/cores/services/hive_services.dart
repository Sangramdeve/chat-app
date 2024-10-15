import 'package:chats/models/hive_models/conversation.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveServices {
  String boxName = 'conversation';

  Future<Box<Conversation>> openBox() async {
    return await Hive.openBox<Conversation>(boxName);
  }

  ValueListenable<Box<Conversation>> getConversationListenable() {
    return Hive.box<Conversation>(boxName).listenable();
  }

  Future<void> addConversation(Conversation value) async {
    var box = await openBox();
    await box.add(value);
  }

  Future<List<Conversation>> getConversation() async {
    var box = await openBox();
    return box.values.toList();
  }

  Future<void> updateConversation(index, value) async {
    var box = await openBox();
    box.putAt(index, value);
  }

  Future<void> deleteConversation(index) async {
    var box = await openBox();
    box.deleteAt(index);
  }
}