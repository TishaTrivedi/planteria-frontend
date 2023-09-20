import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantbackend/screens/checkout.dart';
class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  int quant=1;
  void increment(){
    setState(() {
      quant++;
    });
  }
  void decrement(){
    setState(() {
      if (quant > 1) {
        quant--;
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.lightGreen.shade50,
        appBar: AppBar(
          backgroundColor: Color(0xFF3C593B),
          title: Text("My Shopping Cart",
            style: GoogleFonts.lora(
              fontWeight: FontWeight.w600,
            ),),
          leading: Icon(Icons.arrow_back),
          shadowColor: Color(0xFF2F482D),
        ),

        body: SingleChildScrollView(
          child:Container(
            width: 360,
            height: 800,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: Colors.lightGreen.shade50),
            child: Stack(
              children: [

                Positioned(
                  left: 19,
                  top: 412,
                  child: SizedBox(
                    width: 272,
                    height: 40,
                    child: Text(
                      'Subtotal',
                      style: GoogleFonts.playfairDisplay(
                        color: Color(0xFF0D0D0D),
                        fontSize: 15,
                        //fontFamily: 'Playfair Display',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 19,
                  top: 452,
                  child: SizedBox(
                    width: 272,
                    height: 40,
                    child: Text(
                      'Shipping',
                      style: GoogleFonts.playfairDisplay(
                        color: Color(0xFF0D0D0D),
                        fontSize: 15,
                        //fontFamily: 'Playfair Display',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 489,
                  child: SizedBox(
                    width: 272,
                    height: 40,
                    child: Text(
                      'Bag total',
                      style: GoogleFonts.playfairDisplay(
                        color: Color(0xFF0D0D0D),
                        fontSize: 15,
                        //fontFamily: 'Playfair Display',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 271,
                  top: 412,
                  child: SizedBox(
                    width: 42.49,
                    height: 16.02,
                    child: Text(
                      '₹498',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.acme(
                        color: Color(0xFF0D0D0D),
                        fontSize: 15.50,
                        // fontFamily: 'Acme',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 271,
                  top: 452,
                  child: SizedBox(
                    width: 42.49,
                    height: 16.02,
                    child: Text(
                      '₹99',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.acme(
                        color: Color(0xFF0D0D0D),
                        fontSize: 15.50,
                        //fontFamily: 'Acme',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 271,
                  top:489,
                  child: SizedBox(
                    width: 42.49,
                    height: 16.02,
                    child: Text(
                      '₹597',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.acme(
                        color: Color(0xFF0D0D0D),
                        fontSize: 15.50,
                        //fontFamily: 'Acme',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 9,
                  top: 30,
                  child: Container(
                    width: 329,
                    height: 317.02,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 329,
                            height: 91,
                            decoration: BoxDecoration(color: Colors.transparent),
                          ),
                        ),
                        Positioned(
                          left: 80,
                          top: 20,
                          child: SizedBox(
                            width: 112,
                            height: 22,
                            child: Text(
                              'Mint Plant',
                              style: GoogleFonts.playfairDisplay(
                                color: Colors.black,
                                fontSize: 18,
                                //fontFamily: 'Playfair Display',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 80,
                          top: 38,
                          child: SizedBox(
                            width: 63.54,
                            height: 19.43,
                            child: Text(
                              'Indoor',
                              style: GoogleFonts.playfairDisplay(
                                color: Colors.black.withOpacity(0.6700000166893005),
                                fontSize: 12,
                                //fontFamily: 'Playfair Display',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 77,
                          top: 60,
                          child: SizedBox(
                            width: 42.49,
                            height: 16.02,
                            child: Text(
                              '₹249',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.acme(
                                color: Color(0xFF0D0D0D),
                                fontSize: 15.50,
                                //fontFamily: 'Acme',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          left: 212,
                          top: 42,
                          child: SizedBox(
                              width: 133,
                              height: 31.12,
                              child: Row(
                                children: [
                                  IconButton(onPressed: (){
                                    decrement();
                                  },
                                    icon: Icon(
                                        Icons.remove_circle_outline_sharp,
                                        color: Colors.black,
                                        size: 20),),

                                  Text(
                                    '$quant',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'Playfair Display',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),

                                  IconButton(onPressed: (){
                                    increment();
                                  },
                                    icon:Icon(
                                        Icons.add_circle_outline_sharp,
                                        color: Colors.black,
                                        size: 20),),
                                ],
                              )
                          ),
                        ),
                        Positioned(
                          left: 290,
                          top: 10,
                          child: SizedBox(
                            width: 42.49,
                            height: 16.02,
                            child: Icon(Icons.cancel,
                                size: 20,
                                color: Colors.black54),
                          ),
                        ),



                        Positioned(
                          left: 70,
                          top: 83,
                          child: Transform(
                            transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-3.14),
                            child: Container(
                              width: 67,
                              height: 68,
                              decoration: ShapeDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(0.00, -1.00),
                                  end: Alignment(0, 1),
                                  colors: [ Color(0xFF99A897),Color(0xFF50694C),Color(0xFF21411C)],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 21,
                          top: 19.43,
                          child: Transform(
                            transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.02),
                            child: Container(
                              width: 28.26,
                              height: 63.48,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/sample/i1.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 300,
                  top: 160,
                  child: SizedBox(
                    width: 42.49,
                    height: 16.02,
                    child: Icon(Icons.cancel,
                    size: 20,
                    color: Colors.black54),
                    ),
                  ),

                Positioned(
                  left: 12,
                  top: 153,
                  child: Container(
                    width: 329,
                    height: 317.02,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 329,
                            height: 91,
                            decoration: BoxDecoration(color: Colors.transparent)),
                          ),

                        Positioned(
                          left: 80,
                          top: 20,
                          child: SizedBox(
                            width: 112,
                            height: 22,
                            child: Text(
                              'Money Plant',
                              style: GoogleFonts.playfairDisplay(
                                color: Colors.black,
                                fontSize: 18,
                                //fontFamily: 'Playfair Display',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 80,
                          top: 38,
                          child: SizedBox(
                            width: 63.54,
                            height: 19.43,
                            child: Text(
                              'Indoor',
                              style: GoogleFonts.playfairDisplay(
                                color: Colors.black.withOpacity(0.6700000166893005),
                                fontSize: 12,
                                //fontFamily: 'Playfair Display',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 77,
                          top: 60,
                          child: SizedBox(
                            width: 42.49,
                            height: 16.02,
                            child: Text(
                              '₹249',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.acme(
                                color: Color(0xFF0D0D0D),
                                fontSize: 15.50,
                                //fontFamily: 'Acme',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          left: 212,
                          top: 42,
                          child: SizedBox(
                              width: 133,
                              height: 31.12,
                              child: Row(
                                children: [
                                  IconButton(onPressed: (){
                                    decrement();
                                  },
                                    icon: Icon(
                                        Icons.remove_circle_outline_sharp,
                                        color: Colors.black,
                                        size: 20),),

                                  Text(
                                    '$quant',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'Playfair Display',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),

                                  IconButton(onPressed: (){
                                    increment();
                                  },
                                    icon:Icon(
                                        Icons.add_circle_outline_sharp,
                                        color: Colors.black,
                                        size: 20),),
                                ],
                              )
                          ),
                        ),

                        Positioned(
                          left: 70,
                          top: 83,
                          child: Transform(
                            transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-3.14),
                            child: Container(
                              width: 67,
                              height: 68,
                              decoration: ShapeDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(0.00, -1.00),
                                  end: Alignment(0, 1),
                                  colors: [ Color(0xFF99A897),Color(0xFF50694C),Color(0xFF21411C)],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 21,
                          top: 19.43,
                          child: Transform(
                            transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.02),
                            child: Container(
                              width: 28.26,
                              height: 63.48,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/sample/i2.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 19,
                  top: 444,
                  child: Container(
                    width: 318,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.50,
                          //strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0x380D0D0D),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 19,
                  top: 481,
                  child: Container(
                    width: 318,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.50,
                          //strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0x380D0D0D),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 21,
                  top: 519,
                  child: Container(
                    width: 318,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.50,
                          //strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0x380D0D0D),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 283,
                  top: 602,
                  child: Transform(
                    transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-3.14),
                    child: Container(
                      width: 222,
                      height: 38,
                      decoration: ShapeDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0.00, -1.00),
                          end: Alignment(0, 1),
                          colors: [ Color(0xFF99A897),Color(0xFF50694C),Color(0xFF21411C)],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),

                    ),
                  ),
                ),
                Positioned(
                  left:60,
                  top: 562,
                  child: SizedBox(
                    width: 222,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>Checkout()));
                      },
                      child: Text(
                        'Checkout',
                        style: GoogleFonts.acme(
                          color: Colors.white.withOpacity(0.8600000143051147),
                          fontSize: 20,
                          //fontFamily: 'Playfair Display',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
