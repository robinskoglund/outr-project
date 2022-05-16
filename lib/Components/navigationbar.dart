import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'outr_icon_icons.dart';

final Color backgroundColor = Color(0xFF353535);

class OutrNavigationBar extends StatefulWidget {
  @override
  _OutrNavigationBarState createState() => _OutrNavigationBarState();
}

class _OutrNavigationBarState extends State<OutrNavigationBar> with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  late double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _menuScaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() { //asdasd
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          menu(context),
          dashboard(context),
        ],
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[


                Text.rich( // OutR Hemknappen
                  TextSpan(
                    style: const TextStyle(
                      fontFamily: "Dongle",
                      color: Colors.white,
                      fontSize: 28,
                      decoration: TextDecoration.underline,
                    ),
                    children: [
                      TextSpan(
                        text: 'OutR ',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('OutR!!!!!!!!!');
                          },
                      ),
                      WidgetSpan(
                        child: Icon(OutrIcon.outrgubben, color: Colors.white),
                        alignment: PlaceholderAlignment.top,
                      ),
                    ],
                  ),
                ),


                Text.rich( //Profil knappen
                  TextSpan(
                    style: const TextStyle(
                      fontFamily: "Dongle",
                      color: Colors.white,
                      fontSize: 22,
                      decoration: TextDecoration.underline,
                    ),
                    children: [
                      TextSpan(
                        text: 'Profile ',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('Profileeeeee!!!!!');
                          },
                      ),
                      const WidgetSpan(
                        child: Icon(Icons.account_circle_outlined, color: Colors.white),
                        alignment: PlaceholderAlignment.top,
                      ),
                    ],
                  ),
                ),

                Text.rich( //Historia knappen
                  TextSpan(
                    style: const TextStyle(
                      fontFamily: "Dongle",
                      color: Colors.white,
                      fontSize: 22,
                      decoration: TextDecoration.underline,
                    ),
                    children: [
                      TextSpan(
                        text: 'History ',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('Historyyyyy!!!!');
                          },
                      ),
                      const WidgetSpan(
                        child: Icon(Icons.history, color: Colors.white),
                        alignment: PlaceholderAlignment.top,
                      ),
                    ],
                  ),
                ),

                Text.rich( //Sparade rutter knappen
                  TextSpan(
                    style: const TextStyle(
                      fontFamily: "Dongle",
                      color: Colors.white,
                      fontSize: 22,
                      decoration: TextDecoration.underline,
                    ),
                    children: [
                      TextSpan(
                        text: 'Saved Routes ',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('Saved Routeeeees!!!!!');
                          },
                      ),
                      const WidgetSpan(
                        child: Icon(Icons.star_border_outlined, color: Colors.white),
                        alignment: PlaceholderAlignment.top,
                      ),
                    ],
                  ),
                ),

                Text.rich(
                  TextSpan(
                    style: const TextStyle(
                      fontFamily: "Dongle",
                      color: Colors.white,
                      fontSize: 22,
                      decoration: TextDecoration.underline,
                    ),
                    children: [
                      TextSpan(
                        text: 'Settings ',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('Settingssss!!!!');
                          },
                      ),
                      const WidgetSpan(
                        child: Icon(Icons.settings, color: Colors.white),
                        alignment: PlaceholderAlignment.top,
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : -0.2 * screenWidth,
      right: isCollapsed ? 0 : 0.6 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: backgroundColor,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(Icons.arrow_left, color: Colors.white),
                      const Text("OutR", style: TextStyle(fontFamily: "Dongle", fontSize: 40, color: Colors.white)),
                      InkWell(
                        child: Icon(Icons.menu, color: Colors.white),
                        onTap: () {
                          setState(() {
                            if (isCollapsed)
                              _controller.forward();
                            else
                              _controller.reverse();

                            isCollapsed = !isCollapsed;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}