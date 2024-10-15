import 'package:chats/Routing/route_name.dart';
import 'package:chats/View-models/contact_state.dart';
import 'package:chats/View-models/home_state.dart';
import 'package:chats/View-models/login_state.dart';
import 'package:chats/View-models/message_state.dart';
import 'package:chats/firebase_options.dart';
import 'package:chats/models/hive_models/conversation.dart';
import 'package:chats/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'Routing/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  Hive.registerAdapter(ConversationAdapter());
  Hive.registerAdapter(MessagesAdapter());
  Hive.registerAdapter(UserDataAdapter());
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LoginState()),
      ChangeNotifierProvider(create: (context) => HomeState()),
      ChangeNotifierProvider(create: (context) => MessageState()),
      ChangeNotifierProvider(create: (context)=> ContactState())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      initialRoute: RouteName.splashScreen,
      onGenerateRoute: Routes.generateRoutes,
    );
  }
}
