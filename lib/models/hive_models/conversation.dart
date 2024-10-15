import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'conversation.g.dart';

@HiveType(typeId: 0)
class Conversation {
  @HiveField(0)
  final List<String> members;

  @HiveField(1)
  String lastMessage;

  @HiveField(2)
  final List<Messages> chats;

  @HiveField(3)
  final UserData userDetails;

  Conversation({
    required this.members,
    required this.lastMessage,
    required this.chats,
    required this.userDetails,
  });

  // Factory method to create a Conversation from JSON
  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      members: List<String>.from(json['members']),
      lastMessage: json['lastMessage'] as String,
      chats: (json['chats'] as List<dynamic>)
          .map((chat) => Messages.fromJson(chat as Map<String, dynamic>))
          .toList(),
      userDetails: UserData.fromJson(json['userDetails']),
    );
  }


  @override
  String toString() {
    return 'Conversation(members: $members, lastMessage: $lastMessage, chats: $chats, userDetails: $userDetails)';
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
      messageId: json['messageId'] as String,
      senderId: json['senderId'] as String,
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
        ? (json['last_seen'] as Timestamp).toDate().toString() // Convert Timestamp to DateTime, then to String
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