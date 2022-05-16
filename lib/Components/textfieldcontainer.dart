import 'package:flutter/cupertino.dart';

class TextContainer extends StatelessWidget {
  final Widget child;

  const TextContainer({
    Key? key,
    required this.child,
  }) :super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
      margin: const EdgeInsets.symmetric(vertical: 6),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(28),
      ),
      child: child,
    );
  }
}