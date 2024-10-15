class Values{
  static List<Map<String, dynamic>> mockJsonResponseList = [
    {
      "members": ["user1", "user2"],
      "lastMessage": "See you later!",
      "chats": [
        {
          "messageId": "msg123",
          "senderId": "user1",
          "text": "Hey, how are you?",
          "timestamp": "2024-10-05T12:34:56Z",
          "read": true
        },
        {
          "messageId": "msg124",
          "senderId": "user2",
          "text": "I'm good, how about you?",
          "timestamp": "2024-10-05T12:36:00Z",
          "read": false
        },
        {
          "messageId": "msg124",
          "senderId": "user2",
          "text": "See you later!",
          "timestamp": "2024-10-05T12:36:00Z",
          "read": false
        }
      ],
      "userDetails": {
        "uid": "user1",
        "fullName": "John Doe",
        "image_url": "https://example.com/johndoe.jpg",
        "last_seen": "2024-10-05T10:02:51.719Z",
        "status": true
      }
    },
    {
      "members": ["user1", "user2"],
      "lastMessage": "Let's meet tomorrow.",
      "chats": [
        {
          "messageId": "msg123",
          "senderId": "user1",
          "text": "Hey, how are you?",
          "timestamp": "2024-10-05T12:34:56Z",
          "read": true
        },
        {
          "messageId": "msg124",
          "senderId": "user2",
          "text": "I'm good, how about you?",
          "timestamp": "2024-10-05T12:36:00Z",
          "read": false
        },
      ],
      "userDetails": {
        "uid": "user3",
        "fullName": "Jane Smith",
        "image_url": "https://example.com/janesmith.jpg",
        "last_seen": "2024-10-05T11:00:34.772Z",
        "status": false
      }
    },
    {
      "members": ["user1", "user2"],
      "lastMessage": "Goodnight!",
      "chats": [
        {
          "messageId": "msg789",
          "senderId": "user1",
          "text": "Had a great day, thanks!",
          "timestamp": "2024-10-03T22:45:00Z",
          "read": true
        },
        {
          "messageId": "msg789",
          "senderId": "user1",
          "text": "Goodnight",
          "timestamp": "2024-10-03T22:45:00Z",
          "read": true
        }
      ],
      "userDetails": {
        "uid": "user5",
        "fullName": "Bob Johnson",
        "image_url": "https://example.com/bobjohnson.jpg",
        "last_seen": "2024-10-05T10:02:51.719Z",
        "status": true
      }
    }
  ];
}