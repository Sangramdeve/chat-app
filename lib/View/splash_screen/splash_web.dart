import '../view_imports.dart';

class SplashWeb extends StatefulWidget {
  const SplashWeb({super.key});

  @override
  State<SplashWeb> createState() => _SplashWebState();
}

class _SplashWebState extends State<SplashWeb> {

  @override
  void initState() {
    final loginState = Provider.of<LoginState>(context, listen: false);
    loginState.getLoggedInStatus();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginState>(builder: (context, snapshot, _) {
        return Column(
          children: [
            Spacer(),
            ElevatedButton(
                onPressed: () {
                  if(snapshot.isLoggedIn == false){
                    Navigator.pushReplacementNamed(context, RouteName.loginScreen);
                  }else if(snapshot.isLoggedIn){
                    Navigator.pushReplacementNamed(context, RouteName.homeScreen);
                  }
                },
                child: Text('Splash Screen: ${snapshot.isLoggedIn}')),
            Center(
              child: Text('Splash Screen: ${snapshot.isLoggedIn ? "Logged In" : "Not Logged In"}'),
            ),
            Spacer(),
          ],
        );
      }),
    );
  }
}
