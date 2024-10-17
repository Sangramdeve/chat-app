
import 'package:chats/View/contact_screen/contacts_layout.dart';
import 'package:chats/View/home_screen/home_layout.dart';
import 'package:chats/View/login_screen/login_layout.dart';
import 'package:chats/View/messages_screen/message_layout.dart';
import 'package:chats/View/splash_screen/splash_layout.dart';
import 'package:chats/View/view_imports.dart';

class Routes{
 static Route<dynamic> generateRoutes(RouteSettings setting){
    switch(setting.name){
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RouteName.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeLayout());
      case RouteName.messageScreen:
      // Retrieve the arguments map containing conversation and index
        final arguments = setting.arguments as Map<String, dynamic>;
        final conversation = arguments['conversation'] as Conversation;
        final index = arguments['index'] as int;
        final length = arguments['length'] as int;
        return MaterialPageRoute(
          builder: (context) => MessageLayout(
            conversation: conversation,
            index: index,
              length: length
          ),
        );
      case RouteName.loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginLayout());
      case RouteName.contactScreen:
        return MaterialPageRoute(builder: (context) =>  ContactsAccess());
      default:
        return MaterialPageRoute(builder: (context){
          return const Scaffold(
            body: Center(
                child: Text('no route Generated')),
          );
        });
    }
  }
}