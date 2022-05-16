import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outr/Components/textfieldcontainer.dart';

class EmailField extends StatelessWidget{
  late final TextEditingController textController;

  EmailField(TextEditingController controller, {Key? key}) : super(key: key){
    textController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return const TextContainer(key: null,
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Email',
          icon: Icon(
            Icons.person,
            color: Colors.black,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}