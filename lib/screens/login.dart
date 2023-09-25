import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Animations/slide_animation.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 800,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: Colors.lightGreen.shade50),
      child: Stack(
        children: [
          Positioned(
              left: 80,
              top: 666,
              child: SlideAnimation(
                  duration: Duration(seconds: 2),
                  begin: Offset(0, 100), // Slide from below
                  end: Offset(0, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'login2');
                    },
                    child: Text("Login",
                        style: GoogleFonts.playfairDisplay(
                            fontSize: 26,
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF50694C),
                        shadowColor: Colors.black54,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        fixedSize: Size(200, 50)),
                  ))),
          Positioned(
              left: 80,
              top: 556,
              child: SlideAnimation(
                  duration: Duration(seconds: 2),
                  begin: Offset(0, -100), // Slide from below
                  end: Offset(0, 0),
                  child: Container(
                    child: Text(
                      'PLANTERIA',
                      style: GoogleFonts.playfairDisplay(
                          fontSize: 40,
                          color: Color(0xFF50694C),
                          fontWeight: FontWeight.w300),
                    ),
                  ))),
          Positioned(
              left: 202,
              top: 46,
              child: SlideAnimation(
                duration: Duration(seconds: 2),
                begin: Offset(0, 100), // Slide from below
                end: Offset(0, 0),
                child: Container(
                  width: 126,
                  height: 170,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/login/l3.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )),
          Positioned(
              left: 20,
              top: 148,
              child: SlideAnimation(
                duration: Duration(seconds: 2),
                begin: Offset(0, -100), // Slide from below
                end: Offset(0, 0),
                child: Container(
                  width: 166,
                  height: 123,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/login/l14.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )),
          Positioned(
              left: 276,
              top: 228,
              child: SlideAnimation(
                duration: Duration(seconds: 2),
                begin: Offset(-200, 0), // Slide from below
                end: Offset(0, 0),
                child: Container(
                  width: 55,
                  height: 73,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/login/l5.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )),
          Positioned(
              left: 276,
              top: 320,
              child: SlideAnimation(
                duration: Duration(seconds: 2),
                begin: Offset(-200, 0), // Slide from below
                end: Offset(0, 0),
                child: Container(
                  width: 57,
                  height: 43,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/login/l13.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )),
          Positioned(
              left: 102,
              top: 290,
              child: SlideAnimation(
                duration: Duration(seconds: 2),
                begin: Offset(0, 100), // Slide from below
                end: Offset(0, 0),
                child: Container(
                  width: 155,
                  height: 208,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/login/l1.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )),
          Positioned(
              left: 17,
              top: 405,
              child: SlideAnimation(
                duration: Duration(seconds: 2),
                begin: Offset(0, -100), // Slide from below
                end: Offset(0, 0),
                child: Container(
                  width: 72,
                  height: 97,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/login/l10.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )),
          Positioned(
            left: 17,
            top: 46,
            child: SlideAnimation(
                duration: Duration(seconds: 2),
                begin: Offset(-200, 0), // Slide from below
                end: Offset(0, 0),
                child: Container(
                  width: 122,
                  height: 91,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/login/l9.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                )),
          ),
          Positioned(
              left: 273,
              top: 387,
              child: SlideAnimation(
                duration: Duration(seconds: 2),
                begin: Offset(0, 100), // Slide from below
                end: Offset(0, 0),
                curve: Curves.easeIn,

                child: Container(
                  width: 58,
                  height: 64,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/login/l8.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )),
          Positioned(
              left: 271,
              top: 457,
              child: SlideAnimation(
                duration: Duration(seconds: 2),
                begin: Offset(0, -100), // Slide from below
                end: Offset(0, 0),

                child: Container(
                  width: 60,
                  height: 46,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/login/l12.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )),
          Positioned(
              left: 17,
              top: 290,
              child: SlideAnimation(
                duration: Duration(seconds: 2),
                begin: Offset(-200, 0), // Slide from below
                end: Offset(0, 0),

                child: Container(
                  width: 72,
                  height: 94,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/login/l7.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )),
          Positioned(
              left: 198,
              top: 228,
              child: SlideAnimation(
                duration: Duration(seconds: 2),
                begin: Offset(0, -100), // Slide from below
                end: Offset(0, 0),

                child: Container(
                  width: 67,
                  height: 49,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/login/l6.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )),
          Positioned(
              left: 148,
              top: 46,
              child: SlideAnimation(
                duration: Duration(seconds: 2),
                begin: Offset(0, 100), // Slide from below
                end: Offset(0, 0),

                child: Container(
                  width: 41,
                  height: 56,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/login/l11.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )),
          Positioned(
              left: 148,
              top: 106,
              child: SlideAnimation(
                duration: Duration(seconds: 2),
                begin: Offset(0, -100), // Slide from below
                end: Offset(0, 0),

                child: Container(
                  width: 41,
                  height: 32,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/login/l4.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
