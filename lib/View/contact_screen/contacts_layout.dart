import 'package:chats/View/contact_screen/contact_mobile.dart';
import 'package:chats/View/contact_screen/contact_web.dart';
import 'package:chats/View/view_imports.dart';


class ContactsAccess extends StatefulWidget {
  const ContactsAccess({super.key});

  @override
  State<ContactsAccess> createState() => _ContactsAccessState();
}

class _ContactsAccessState extends State<ContactsAccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LayoutBuilder(
            builder: (context,BoxConstraints constraints){
              if(constraints.maxWidth > 600){
                return const ContactWeb();
              }else{
                return const ContactMobile();
              }
            }
        )
    );
  }
}