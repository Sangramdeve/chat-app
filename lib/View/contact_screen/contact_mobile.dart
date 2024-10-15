import 'package:chats/View-models/contact_state.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

import '../view_imports.dart';

class ContactMobile extends StatefulWidget {
  const ContactMobile({super.key});

  @override
  State<ContactMobile> createState() => _ContactMobileState();
}

class _ContactMobileState extends State<ContactMobile> {
  List<Contact> _contacts = [];

  @override
  void initState() {
    super.initState();
    _getContactsPermission();
  }

  Future<void> _getContactsPermission() async {
    if (await Permission.contacts.request().isGranted) {
      _getContacts();
    } else {
      // Handle permission denied
    }
  }

  Future<void> _getContacts() async {
    List<Contact> contacts =  await FlutterContacts.getContacts(
        withProperties: true, withPhoto: true);

    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: ListTile(
          title:const Text('Select contacts'),
          subtitle: Text('${_contacts.length} contacts'),
        ),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 10,),
          Icon(Icons.more_vert_outlined)
        ],
      ),
      body:  Column(
        children: [
          const Text('Contacts on chats'),
          Expanded(
            child: ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                final contact = _contacts[index];
                return Consumer<ContactState>(
                  builder: (context, snapshot,_) {
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 24,
                        backgroundImage: contact.photo != null
                            ? MemoryImage(contact.photo!)  // Use the contact's photo if available
                            : const AssetImage('assets/placeholder.jpg'),  // Fallback to placeholder image
                      ),
                      title: Text(contact.displayName ?? 'No Name'),
                      subtitle: Text(contact.phones.isNotEmpty ? contact.phones.first.number : 'No Phone'),
                      onTap: ()  {
                        snapshot.findUser(contact.phones.first.number);
                        Navigator.pushNamed(context, RouteName.messageScreen,
                          arguments: {
                            'conversation': snapshot.conversation,
                            'index': 3,
                          },
                        );
                      },
                    );
                  }
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
