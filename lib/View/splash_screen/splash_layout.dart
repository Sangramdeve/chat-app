

import '../view_imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late LoginState loginState;

  @override
  void initState() {
    super.initState();
    loginState = Provider.of<LoginState>(context, listen: false);
    _initializeApp();
  }

  Future<void> _initializeApp() async {
   if(loginState.isLoggedIn){
     print('Set the user online status');
     await loginState.setOnlineStatus(); // Set the user online status.
   }

    await Future.delayed(
        const Duration(seconds: 3)); // Wait for the splash screen delay.

    _navigateBasedOnLoginState();
  }

  void _navigateBasedOnLoginState() {
    final routeName =
        loginState.isLoggedIn ? RouteName.homeScreen : RouteName.loginScreen;

    Navigator.pushReplacementNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 600) {
            return const SplashWeb();
          } else {
            return const SplashMobile();
          }
        },
      ),
    );
  }
}
