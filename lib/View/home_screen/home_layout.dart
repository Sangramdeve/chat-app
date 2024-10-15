
import 'package:chats/View/home_screen/home_mobile.dart';
import 'package:chats/View/home_screen/home_web.dart';

import '../view_imports.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {

/*
 @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<HomeState>(context, listen: false).findConversation();
    });
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hPrimaryColor,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 600) {
            return const HomeWeb();
          } else {
            return const HomeMobile();
          }
        },
      ),
    );
  }
}
