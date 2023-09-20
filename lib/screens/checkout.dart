import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantbackend/screens/payment.dart';
class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.lightGreen.shade50,
        appBar: AppBar(
          backgroundColor: Color(0xFF3C593B),
          title: Text("Shipping Details",
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
          decoration: BoxDecoration(color: Colors.lightGreen.shade50),
          child: Stack(
            children: [
              Positioned(
                left: 36,
                top: 69,
                child: SizedBox(
                  width: 272,
                  height: 40,
                  child: Text(
                    'Name',
                    style: TextStyle(
                      color: Color(0xFF0D0D0D),
                      fontSize: 15,
                      fontFamily: 'Playfair Display',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 33,
                top: 305,
                child: SizedBox(
                  width: 272,
                  height: 40,
                  child: Text(
                    'Phone number',
                    style: TextStyle(
                      color: Color(0xFF0D0D0D),
                      fontSize: 15,
                      fontFamily: 'Playfair Display',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 33,
                top: 167,
                child: SizedBox(
                  width: 272,
                  height: 40,
                  child: Text(
                    'Address',
                    style: TextStyle(
                      color: Color(0xFF0D0D0D),
                      fontSize: 15,
                      fontFamily: 'Playfair Display',
                      fontWeight: FontWeight.w600,
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
                left: 61,
                top: 562,
                child: SizedBox(
                  width: 222,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>Payment()));
                    },
                    child: Text(
                      'Proceed to Pay',
                      style: GoogleFonts.playfairDisplay(
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
                  ),),
              ),
              Positioned(
                left: 26,
                top: 109,
                child: Container(
                  width: 285,
                  height: 37,
                  decoration: ShapeDecoration(
                    color: Color(0x444F684B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 338,
                child: Container(
                  width: 285,
                  height: 37,
                  decoration: ShapeDecoration(
                    color: Color(0x444F684B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                ),
              ),
              Positioned(
                left: 26,
                top: 207,
                child: Container(
                  width: 285,
                  height: 77,
                  decoration: ShapeDecoration(
                    color: Color(0x444F684B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
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
