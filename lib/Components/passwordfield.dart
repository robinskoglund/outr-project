import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outr/Components/textfieldcontainer.dart';

class PasswordField extends StatelessWidget{
  late final TextEditingController textController;

  PasswordField(TextEditingController controller, {Key? key}) : super(key: key){
    textController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return const TextContainer(key: null,
    child: TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        icon: Icon(
          Icons.lock,
          color: Colors.black,
        ),
        suffixIcon: Icon(
          Icons.visibility,
          color: Colors.black,
        ),
        border: InputBorder.none,
      ),
    ),
    );
  }
}