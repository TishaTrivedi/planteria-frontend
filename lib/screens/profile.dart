import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantbackend/screens/address.dart';
import 'package:plantbackend/screens/wishlist.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.lightGreen[50],
        body: Column(
          children: [
            Container(
                padding: EdgeInsets.only(top: 45, left: 99),
                alignment: Alignment.topLeft,
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/tisha.jpg"),
                  radius: 80,
                )),
            Container(
                padding: EdgeInsets.only(top: 15, left: 119),
                alignment: Alignment.topLeft,
                child: Text(
                  "TISHA TRIVEDI",
                  style: GoogleFonts.acme(
                    color: Colors.black,
                    fontSize: 20,
                    //fontFamily: 'Playfair Display',
                    //fontWeight: FontWeight.w50,
                  ),
                )),
            SizedBox(
              height: 80,
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WishList()));
                },
                child: Row(
                  children: [
                    Text(
                      "My WishList",
                      style: GoogleFonts.acme(
                        color: Colors.white.withOpacity(0.8600000143051147),
                        fontSize: 20,
                        //fontFamily: 'Playfair Display',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      width: 145,
                    ),
                    Icon(
                      Icons.favorite_outlined,
                      size: 25,
                      color: Colors.white.withOpacity(0.8600000143051147),
                    )
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3C593B).withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  fixedSize: Size(405, 55),
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WishList()));
                },
                child: Row(
                  children: [
                    Text(
                      "My Orders",
                      style: GoogleFonts.acme(
                        color: Colors.white.withOpacity(0.8600000143051147),
                        fontSize: 20,
                        //fontFamily: 'Playfair Display',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      width: 160,
                    ),
                    Icon(
                      Icons.shopping_bag,
                      size: 25,
                      color: Colors.white.withOpacity(0.8600000143051147),
                    )
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3C593B).withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  fixedSize: Size(405, 55),
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Address()));
                },
                child: Row(
                  children: [
                    Text(
                      "My Addresses",
                      style: GoogleFonts.acme(
                        color: Colors.white.withOpacity(0.8600000143051147),
                        fontSize: 20,
                        //fontFamily: 'Playfair Display',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      width: 130,
                    ),
                    Icon(
                      Icons.home,
                      size: 25,
                      color: Colors.white.withOpacity(0.8600000143051147),
                    )
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3C593B).withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  fixedSize: Size(405, 55),
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "LOGOUT",
                  style: GoogleFonts.acme(
                    color: Colors.white.withOpacity(0.8600000143051147),
                    fontSize: 20,
                    //fontFamily: 'Playfair Display',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2F482D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  fixedSize: Size(200, 55),
                  alignment: Alignment.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
