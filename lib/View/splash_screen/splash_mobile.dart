import '../view_imports.dart';

class SplashMobile extends StatelessWidget {
  const SplashMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_image.png'), // Replace with your background image path
            fit: BoxFit.cover, // This will cover the entire screen
          ),
        ),
        child: Column(
          children: [
            Spacer(),
            Center(child: Image.asset('assets/real_time_chat.png')),
            Spacer(),
          ],
        ),
      ),
    );
  }

}
