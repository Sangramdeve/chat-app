
import 'package:chats/View/login_screen/widgets/get_userNumber.dart';

import '../view_imports.dart';

class LoginMobile extends StatefulWidget {
  const LoginMobile({
    super.key,
  });


  @override
  State<LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {

  AuthServices authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Spacer(),
          CustomButtons(
            onTap: () {
             Navigator.push(context, MaterialPageRoute(builder: (context)=> PhoneNumberPicker()));
            },
            text: 'Sign in with Phone number',
            iconUrl: null,
          ),
          Consumer<LoginState>(builder: (context, snapshot, _) {
            return CustomButtons(
              onTap: () async {
                User? user = await authServices.signInWithGoogle();
                if (user != null) {
                  snapshot.updateUser(user);
                  await snapshot.logInStatus(true);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PhoneNumberPicker()));
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
      ),
    );
  }
}