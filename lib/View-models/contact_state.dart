import 'package:chats/View/view_imports.dart';
import 'package:chats/cores/const/api_urls.dart';
import 'package:chats/cores/services/api_services/rest_api_services.dart';
import 'package:chats/cores/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactState with ChangeNotifier {
  ApiServices apiServices = ApiServices();
  FirebaseServices firebaseServices = FirebaseServices();
  late Conversation _conversation;

  Conversation get conversation => _conversation;

  Future<void> findUser(String value) async {
    String phoneNumber = value.replaceAll(' ', '');
    // String phoneNumber = '+91$cleanedNumber';
    String senderId = await SharedPrefServices.getPreference('uid');
    try {
      List<DocumentSnapshot> userDocs = await firebaseServices.querySnapshot(
        collectionPath: 'Users',
        param: 'contact',
        value: phoneNumber,
      );
      if (userDocs.isNotEmpty) {
        DocumentSnapshot user = userDocs.first;
        UserData userData =
            UserData.fromJson(user.data() as Map<String, dynamic>);
        _conversation = Conversation(
            members: [senderId,userData.uid],
            lastMessage: '',
            chats: [],
            userDetails: userData);

        print('_conversation object: $_conversation');
        notifyListeners();
      } else {
        print('No user found with contact: $phoneNumber');
      }
      await createConversation();
    } catch (e) {
      print('Error finding user: $e');
    }
  }

  Future<void> createConversation() async {
    final currentUser = await SharedPrefServices.getPreference('uid');
    final otherUser = _conversation.userDetails.uid;
    final data = {
      'members': [currentUser, otherUser],
      'messages': [],
    };
    print('otherUser: $data');
    final response = apiServices.postApi(ApiUrls.createConversation, data);
  }
}
