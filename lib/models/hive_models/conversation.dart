import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'conversation.g.dart';

@HiveType(typeId: 0)
class Conversation {
  @HiveField(0)
  final String conversationId;

  @HiveField(1)
  final List<String> members;

  @HiveField(2)
  final List<Messages> chats;

  @HiveField(3)
  final UserData userDetails;

  Conversation({
    required this.conversationId,
    required this.members,
    required this.chats,
    required this.userDetails,
  });

  // Factory method to create a Conversation from JSON
  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      conversationId: json['_id'] as String? ?? '', // Fallback if null
      members: (json['members'] != null) ? List<String>.from(json['members']) : <String>[],
      chats: (json['messages'] != null) ? (json['messages'] as List<dynamic>)
          .map((chat) => Messages.fromJson(chat as Map<String, dynamic>))
          .toList()
          : <Messages>[], // Handle null messages
      userDetails: json['userDetails'] != null
          ? UserData.fromJson(json['userDetails'])
          : UserData(uid: '', fullName: '', imageUrl: '', lastSeen: '', status: false),
    );
  }


  @override
  String toString() {
    return 'Conversation( conversationId: $conversationId,members: $members, chats: $chats, userDetails: $userDetails)';
  }

  Conversation copyWith({
    String? conversationId,
    List<String>? members,
    List<Messages>? chats,
    UserData? userDetails,
  }) {
    return Conversation(
      conversationId: conversationId ?? this.conversationId,
      members: members ?? this.members,
      chats: chats ?? this.chats,
      userDetails: userDetails ?? this.userDetails,
    );
  }
}

@HiveType(typeId: 1)
class Messages {
  @HiveField(0)
  final String messageId;

  @HiveField(1)
  final String senderId;

  @HiveField(2)
  final String text;

  @HiveField(3)
  final String timestamp;

  @HiveField(4)
  final bool read;

  Messages({
    required this.messageId,
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.read,
  });

  // Factory method to create Messages from JSON
  factory Messages.fromJson(Map<String, dynamic> json) {
    return Messages(
      messageId: json['_id'] as String,
      senderId: json['sender_id'] as String,
      text: json['text'] as String,
      timestamp: json['timestamp'] as String,
      read: json['read'] as bool,
    );
  }

  @override
  String toString() {
    return 'Messages(messageId: $messageId, senderId: $senderId, text: $text, timestamp: $timestamp, read: $read)';
  }
}

@HiveType(typeId: 2)
class UserData {
  @HiveField(0)
  final String uid;

  @HiveField(1)
  final String fullName;

  @HiveField(2)
  final String imageUrl;

  @HiveField(3)
  final String lastSeen;

  @HiveField(4)
  final bool status;

  UserData({
    required this.uid,
    required this.fullName,
    required this.imageUrl,
    required this.lastSeen,
    required this.status,
  });

  // Factory method to create UserData from JSON
  factory UserData.fromJson(Map<String, dynamic> json) {
    // Check if last_seen is a Timestamp and convert it
    String lastSeenValue = json['last_seen'] is Timestamp
        ? (json['last_seen'] as Timestamp).toDate().toString()
        : json['last_seen'] as String;

    return UserData(
      uid: json['uid'] as String,
      fullName: json['fullName'] as String,
      imageUrl: json['image_url'] as String,
      lastSeen: lastSeenValue, // Use the converted or raw String value
      status: json['status'] as bool,
    );
  }

  @override
  String toString() {
    return 'UserData(uid: $uid, fullName: $fullName, imageUrl: $imageUrl, lastSeen: $lastSeen, status: $status)';
  }
}