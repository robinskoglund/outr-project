import 'package:flutter/cupertino.dart';
import '../Components/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




class ChangeThemeButton extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    return Switch.adaptive(
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
            provider.toggleTheme(value);
      },
    );

  }



}