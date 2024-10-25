import 'package:chats/View-models/message_state.dart';
import 'package:chats/View/home_screen/home_mobile.dart';
import 'package:chats/View/home_screen/home_web.dart';

import '../view_imports.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
     Future.microtask(() {
      Provider.of<HomeState>(context, listen: false).storeConversationFormApi();
    });
  }

  @override
  void dispose() {
    // Unregister the observer
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      print('application in background');
    } else if (state == AppLifecycleState.detached) {
      print('application closed');
    } else if (state == AppLifecycleState.resumed) {
      // App is resumed (comes to the foreground)
    }
  }

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
