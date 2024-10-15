


import 'package:chats/View/login_screen/login_mobile.dart';
import 'package:chats/View/login_screen/login_web.dart';

import '../view_imports.dart';

class LoginLayout extends StatefulWidget {
  const LoginLayout({super.key});

  @override
  State<LoginLayout> createState() => _LoginLayoutState();
}

class _LoginLayoutState extends State<LoginLayout> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if(constraints.maxWidth > 600){
            return const LoginWeb();
          }else{
            return const LoginMobile();
          }
        },
      ),
    );
  }
}


