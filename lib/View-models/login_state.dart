import 'package:chats/cores/services/firebase_services.dart';
import 'package:chats/cores/services/shared_pref_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class LoginState with ChangeNotifier {
  FirebaseServices firebaseServices = FirebaseServices();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool _isLoggedIn = false;
  String? _phoneNumber;

  User? get user => _user;

  bool get isLoggedIn => _isLoggedIn;

  String? get phoneNumber => _phoneNumber;

  void updateUser(User? user) {
    _user = user;
    notifyListeners();
  }

  void updatePhone(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  Future<void> logInStatus(bool status) async {
    await SharedPrefServices.savePreference('userLoggedIn', status);
    _isLoggedIn = status;
    print('object$_isLoggedIn');
    notifyListeners();
  }

  Future<void> getLoggedInStatus() async {
    bool? status = await SharedPrefServices.getPreference('userLoggedIn');
    _isLoggedIn = status ?? false; // Default to false if null
    notifyListeners(); // Notify listeners for UI updates
  }

  Future<void> storeCred() async {
    final userCred = {
      'uid': user!.uid,
      'image_url': user!.photoURL ?? '',
      'fullName': user!.displayName ?? '',
      'contact': _phoneNumber ?? '',
      'status': true,
      "last_seen": FieldValue.serverTimestamp(),
    };
    try {
      await firebaseServices.addDocuments(
          collectionPath: 'Users', document: user!.uid, data: userCred);
      await SharedPrefServices.savePreference('uid', user!.uid);
    } catch (e) {
      debugPrint('Error uploading user data: $e');
    }
  }

  Future<void> setOnlineStatus() async {
    User? user = _auth.currentUser;
    final data = {
      'status': true,
      "last_seen": FieldValue.serverTimestamp(),
    };
    if (user != null) {
      firebaseServices.updateDocument(
          collectionPath: 'Users', document: user.uid, data: data);
    }
  }

  void setOfflineStatus() async {
    User? user = _auth.currentUser;
    final data = {
      'status': false,
      "last_seen": FieldValue.serverTimestamp(),
    };
    if (user != null) {
      await firebaseServices.updateDocument(
          collectionPath: 'Users', document: user.uid, data: data);
    }
  }
}
