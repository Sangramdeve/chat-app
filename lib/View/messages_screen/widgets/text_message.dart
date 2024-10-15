import '../../view_imports.dart';


class TextMessage extends StatelessWidget {
  const TextMessage({
    super.key,
    this.message,
  });

  final Messages? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: MediaQuery.of(context).platformBrightness == Brightness.dark
      //     ? Colors.white
      //     : Colors.black,
      padding: const EdgeInsets.symmetric(
        horizontal: 20 * 0.75,
        vertical: 20 / 2,
      ),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(true ? 1 : 0.1),//message!.isSender
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        message!.text,
        style: TextStyle(
          color: true //message!.isSender
              ? Colors.white
              : Theme.of(context).textTheme.bodyLarge!.color,
        ),
      ),
    );
  }
}
