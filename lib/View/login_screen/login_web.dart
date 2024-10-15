import '../view_imports.dart';

class LoginWeb extends StatefulWidget {
  const LoginWeb({super.key});

  @override
  State<LoginWeb> createState() => _LoginWebState();
}

class _LoginWebState extends State<LoginWeb> {

  AuthServices authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Container(
            height: 500,
            width: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 5),
                  blurRadius: 15.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
            child: Column(
              children: [
                const Spacer(),
                CustomButtons(
                  onTap: () {},
                  text: 'Sign in with Phone number',
                  iconUrl: null,
                ),
                Consumer<LoginState>(builder: (context, snapshot, _) {
                  return CustomButtons(
                    onTap: () async {
                      User? user = await authServices.signInWithGoogle();
                      if (user != null) {
                        await snapshot.storeCred();
                        await snapshot.logInStatus(true);
                        Navigator.pushReplacementNamed(
                            context, RouteName.homeScreen);
                      }
                    },
                    text: 'Sign in with Google',
                    iconUrl: 'assets/ic_google.png',
                  );
                }),
                Column(
                  children: [
                    const Text(
                      'By continuing, you agree to our ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            /* Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WebViewPage()),
                  );*/
                          },
                          child: const Text(
                            'Terms of Use',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const Text(
                          ' and ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            /* Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => privacyPolicy()),
                  );*/
                          },
                          child: const Text(
                            'Privacy Policy',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Divider(
                      color: Colors.grey[300],
                      thickness: 1,
                      indent: 32,
                      endIndent: 32,
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
