import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantbackend/screens/checkout.dart';
class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.lightGreen.shade50,
        appBar: AppBar(
          backgroundColor: Color(0xFF3C593B),
          title: Text("Payment Method",
            style: GoogleFonts.lora(
              fontWeight: FontWeight.w600,
            ),),
          leading: IconButton(
              onPressed: (){
                Navigator.pop(context);

              },
              icon: Icon(Icons.arrow_back)),

          shadowColor: Color(0xFF2F482D),
        ),
        body: Container(
          width: 360,
          height: 800,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: -22,
                top: -6,
                child: Container(
                  width: 382,
                  height: 817,
                  decoration: BoxDecoration(color: Color(0xF7D5E2D3)),
                ),
              ),
              Positioned(
                left: -22,
                top: -6,
                child: Container(
                  width: 382,
                  height: 817,
                  decoration: BoxDecoration(color: Color(0xF7D5E2D3)),
                ),
              ),

              Positioned(
                left: 33,
                top: 94,
                child: Container(
                  width: 280,
                  height: 50,
                  decoration: ShapeDecoration(
                    //color: Color(0x444F684B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 33,
                top: 173,
                child: Container(
                  width: 280,
                  height: 50,
                  decoration: ShapeDecoration(
                   //color: Color(0x444F684B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top:62,
                child: Container(
                  width: 165,
                  height: 200,
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: [Color(0xFF21411C), Color(0xFF50694C),Color(0xFF99A897),],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: (){
                      //Navigator.push(context,MaterialPageRoute(builder: (context)=>Checkout()));
                    },
                    child: Column(
                      children: [
                        Image.asset("assets/onBoard/cod.png",
                            height: 150),
                        SizedBox(
                          width: 250,

                          child:  Text(
                            'Cash On Delivery',
                            style: GoogleFonts.playfairDisplay(
                              color: Colors.white,
                              fontSize: 16,
                              //fontFamily: 'Playfair Display',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),

                      ],
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
              Positioned(
                left:189,
                top: 62,
                child: SizedBox(
                  width: 165,
                  height: 200,
                  child: Container(
                    width: 165,
                    height: 200,
                    decoration: ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [Color(0xFF21411C), Color(0xFF50694C),Color(0xFF99A897),],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: (){
                        //Navigator.push(context,MaterialPageRoute(builder: (context)=>Checkout()));
                      },
                      child: Column(
                        children: [
                          Image.asset("assets/onBoard/gpay.png",
                              height: 150),
                          SizedBox(
                            width: 250,

                            child:  Text(
                              'Pay Online',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.playfairDisplay(
                                color: Colors.white,
                                fontSize: 16,
                                //fontFamily: 'Playfair Display',
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),

                        ],
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
              ),
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
                left: 19,
                top: 481,
                child: Container(
                  width: 318,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.50,
                       // strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0x380D0D0D),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 486,
                child: SizedBox(
                  width: 272,
                  height: 40,
                  child: Text(
                    'Bag total',
                    style: GoogleFonts.playfairDisplay(
                      color: Color(0xFF0D0D0D),
                      fontSize: 15,
                     // fontFamily: 'Playfair Display',
                      fontWeight: FontWeight.w600,
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
                left: 276,
                top: 413,
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
                left: 270,
                top: 453,
                child: SizedBox(
                  width: 42.49,
                  height: 16.02,
                  child: Text(
                    '₹99',
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
                top: 494,
                child: SizedBox(
                  width: 42.49,
                  height: 16.02,
                  child: Text(
                    '₹348',
                    textAlign: TextAlign.center,
                    style:GoogleFonts.acme(
                      color: Color(0xFF0D0D0D),
                      fontSize: 15.50,
                      //fontFamily: 'Acme',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
