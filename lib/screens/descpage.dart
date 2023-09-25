import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantbackend/Animations/slide_animation.dart';

class DescPage extends StatefulWidget {
  const DescPage({Key? key}) : super(key: key);

  @override
  State<DescPage> createState() => _DescPageState();
}

class _DescPageState extends State<DescPage>
    with SingleTickerProviderStateMixin {
  // final List<PlantData> plantlist=[
  //   PlantData(icons: Icon(Icons.sunny,color: Colors.yellow,),
  //       heading: "Sunlight Requirement",
  //       text: "Money Plants prefer bright, indirect light. They can tolerate lower light conditions but thrive in bright, filtered light. Avoid placing them in direct sunlight, as it can scorch their leaves."),
  //   PlantData(icons: Icon(Icons.water_drop,color: Colors.lightBlueAccent,),
  //       heading: "Water Requirement",
  //       text: "Money Plants prefer moderate watering. Here are some guidelines:\n\nSoil Moisture: Allow the top inch (2.5 cm) of the soil to dry out before watering again. Overwatering can lead to root rot, so it's essential to avoid waterlogged conditions. \n\nWatering Frequency: Water the plant when the soil feels slightly dry to the touch. The frequency will depend on factors such as the temperature, humidity, and pot size. In general, watering once every 7-10 days is a good starting point.\n\nWatering Method: Water thoroughly, ensuring the water reaches the root zone. Allow any excess water to drain away from the pot to prevent waterlogged conditions."
  // ),
  //   PlantData(icons: Icon(Icons.thermostat,color: Colors.red,),
  //       heading: "Temperature Requirement",
  //       text: "Money Plants prefer average room temperatures between 65-85°F (18-29°C). They can tolerate slightly cooler temperatures but should be protected from drafts and extreme temperature fluctuations."),
  //   PlantData(icons: Icon(Icons.waves,color: Colors.brown,),
  //       heading: "Fertiliser Requirement",
  //       text: "Money Plants benefit from occasional feeding to promote healthy growth.\nHere are some fertilizer recommendations:\n\nFrequency: During the growing season (spring and summer), fertilize the plant every 4-6 weeks.\n\nFertilizer Type: Use a balanced, water-soluble houseplant fertilizer or a slow-release granular fertilizer formulated for indoor plants. Follow the package instructions for the correct dosage.\n\nDilution: If using a water-soluble fertilizer, dilute it to half the recommended strength to avoid overfertilization."
  // ),
  // ];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.lightGreen[300],
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Container(
                width: 371,
                height: 1111,
                color: Colors.lightGreen[100],
                child: Stack(
                  children: [
                    Positioned(
                      left: -152,
                      top: -45,
                      child: Container(
                        width: 722,
                        height: 1156,
                        color: Colors.lightGreen[100],
                        child: Stack(
                          children: [
                            Positioned(
                              left: 148,
                              top: 37,
                              child: Container(
                                width: 394,
                                height: 1119,
                                decoration:
                                    BoxDecoration(color: Color(0xC6F9F9F9)),
                              ),
                            ),
                            Positioned(
                              left: 230.67,
                              top: 370.79,
                              child: SizedBox(
                                width: 270.22,
                                height: 60.03,
                                child: Text(
                                  'Money Plant',
                                  style: GoogleFonts.playfairDisplay(
                                    color: Colors.black,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 290.67,
                              top: 410.79,
                              child: SizedBox(
                                width: 270.22,
                                height: 60.03,
                                child: Text(
                                  'Indoor',
                                  style: GoogleFonts.playfairDisplay(
                                    color: Colors.black45,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 96.85,
                                height: 97.24,
                                decoration:
                                    BoxDecoration(color: Color(0xFFD9D9D9)),
                              ),
                            ),
                            Positioned(
                              left: 176.27,
                              top: 298.96,
                              child: SizedBox(
                                width: 120.10,
                                height: 31.12,
                                child: Text(
                                  '₹250',
                                  style: GoogleFonts.acme(
                                    color: Colors.black
                                        .withOpacity(0.6600000262260437),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 177.24,
                              top: 234.48,
                              child: SizedBox(
                                width: 120.10,
                                height: 31.12,
                                child: Text(
                                  'Araceae',
                                  style: GoogleFonts.acme(
                                    color: Colors.black
                                        .withOpacity(0.6600000262260437),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 178.21,
                              top: 179.33,
                              child: SizedBox(
                                width: 120.10,
                                height: 31.12,
                                child: Text(
                                  'Small',
                                  style: GoogleFonts.acme(
                                    color: Colors.black
                                        .withOpacity(0.6600000262260437),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 320.59,
                              top: 89.05,
                              child: SlideAnimation(
                                duration: Duration(seconds: 1),
                                child: Container(
                                  width: 188.62,
                                  height: 286.84,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/sample/i1.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 177.24,
                              top: 272.68,
                              child: SizedBox(
                                width: 105.57,
                                height: 41.81,
                                child: Text(
                                  'Price\n',
                                  style: GoogleFonts.playfairDisplay(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 177.24,
                              top: 206.56,
                              child: SizedBox(
                                width: 105.57,
                                height: 37.92,
                                child: Text(
                                  'Family\n',
                                  style: GoogleFonts.playfairDisplay(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 177.24,
                              top: 151.41,
                              child: SizedBox(
                                width: 105.57,
                                height: 37.92,
                                child: Text(
                                  'Size',
                                  style: GoogleFonts.playfairDisplay(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),

                            // TabView
                            Positioned(
                              left: 70,
                              top: 450,
                              right: 0,
                              bottom: 0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TabBar(
                                    controller: _tabController,
                                    padding: EdgeInsets.only(left: 20),
                                    indicatorColor: Colors.black12,
                                    labelStyle:
                                        GoogleFonts.acme(color: Colors.black),
                                    labelColor: Colors.black,
                                    tabs: [
                                      Tab(text: 'Description'),
                                      Tab(text: 'About'),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 150,
                                    width: 500,
                                    child: Center(
                                      child: Container(
                                        width: 300,
                                        height: 200,
                                        color: Colors.lightGreen[
                                            100], // Replace with your desired color
                                        child: TabBarView(
                                          controller: _tabController,
                                          children: [
                                            // Description Tab Content
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10, top: 10),
                                              child: Text(
                                                //textAlign: TextAlign.center,
                                                'The Money Plant (Epipremnum aureum) is a vine with heart-shaped leaves that have a glossy texture. The leaves are typically variegated with green and yellow, although there are also solid green varieties available. The plant produces long, trailing stems that can reach several feet in length.',
                                                style:
                                                    GoogleFonts.playfairDisplay(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                  // fontFamily: 'Playfair Display',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            // About Tab Content
                                            Center(
                                              child: Text('About Content'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              left: 176,
                              top: 785,
                              child: SizedBox(
                                width: 326,
                                height: 27,
                                child: Text(
                                  'Product Delivery Information:',
                                  style: GoogleFonts.playfairDisplay(
                                    color: Colors.black,
                                    fontSize: 20,
                                    // fontFamily: 'Playfair Display',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 178,
                              top: 828,
                              child: SizedBox(
                                width: 293.46,
                                height: 150.37,
                                child: Text(
                                  "•	The image displayed is indicative in nature.\n•	Actual product may vary in shape or design as per the availability.\n•	The number of leaves and the size of the plant depends on seasonal availability.\n•	Since flowers are seasonal in nature, flowering plants may be delivered without the bloom. Flowers, if present in plant, may be in fully bloomed, semi-bloomed or bud stage.\n•	Pots will be provided as per the requirement of the plant.\n•	Delivery will be attempted on the same day, but there may be a delay of 3-5 hours depending on the traffic and the weather.\n•	Our courier partners do not call prior to delivering an order, so we recommend that you provide an address at which someone will be present to receive the package.\n•	The delivery, once dispatched, cannot be redirected to any other address.",
                                  style: GoogleFonts.playfairDisplay(
                                    color: Colors.black,
                                    fontSize: 13,
                                    // fontFamily: 'Playfair Display',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 267,
                              top: 685,
                              child: Container(
                                width: 125,
                                height: 29.17,
                                decoration: ShapeDecoration(
                                  color: Color(0xFF21411C),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 262,
                              top: 682,
                              child: SizedBox(
                                  width: 133,
                                  height: 31.12,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                            Icons.remove_circle_outline_sharp,
                                            color: Colors.white,
                                            size: 20),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        '2',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: 'Playfair Display',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                            Icons.add_circle_outline_sharp,
                                            color: Colors.white,
                                            size: 20),
                                      ),
                                    ],
                                  )),
                            ),
                            Positioned(
                              left: 423.79,
                              top: 470.35,
                              child: Container(
                                width: 24.21,
                                height: 24.31,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0)),
                              ),
                            ),
                            Positioned(
                              left: 697.79,
                              top: 486.05,
                              child: Container(
                                width: 24.21,
                                height: 24.31,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0)),
                                child: Icon(Icons.add_circle_outline_sharp),
                              ),
                            ),
                            Positioned(
                              left: 697.79,
                              top: 486.05,
                              child: Container(
                                width: 24.21,
                                height: 24.31,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0)),
                              ),
                            ),
                            Positioned(
                              left: 232,
                              top: 727,
                              child: Container(
                                width: 191.77,
                                height: 32.09,
                                decoration: ShapeDecoration(
                                  color: Color(0xFF21411C),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 255,
                              top: 727.68,
                              child: SizedBox(
                                width: 165.95,
                                height: 26.46,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.shopping_cart,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Add To Cart',
                                      style: GoogleFonts.playfairDisplay(
                                        color: Colors.white,
                                        fontSize: 20,
                                        //fontFamily: 'Playfair Display',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                                left: 697.79,
                                top: 506.05,
                                child: Container(
                                  width: 24.21,
                                  height: 24.31,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF21411C),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));

    // return Container(
    //
    //
    //       width: 300,
    //       height: 300,
    //       decoration: BoxDecoration(
    //         color: Colors.lightGreen[50],
    //
    //       ),
    //
    //
    //   child: Scaffold(
    //
    //       backgroundColor:Colors.transparent,
    //
    //    body: SingleChildScrollView(
    //      child:Container(
    //        width: 371,
    //        height: 1111,
    //
    //        child: Stack(
    //          children: [
    //            Positioned(
    //              left: 11,
    //              top: 78,
    //              child: Container(
    //                width: 350,
    //                height: 493,
    //
    //                // decoration: BoxDecoration(
    //                //   image: DecorationImage(
    //                //     image: AssetImage("assets/sample/i1.png"),
    //                //     fit: BoxFit.fill,
    //                //   ),
    //                // ),
    //              ),
    //            ),
    //            Positioned(
    //              left: -152,
    //              top: -45,
    //              child: Container(
    //                width: 722,
    //                height: 1156,
    //                child: Stack(
    //                  children: [
    //                    Positioned(
    //                      left: 148,
    //                      top: 37,
    //                      child: Container(
    //                        width: 394,
    //                        height: 1119,
    //                        decoration: BoxDecoration(color: Color(0xC6F9F9F9)),
    //                      ),
    //                    ),
    //                    Positioned(
    //                      left: 230.67,
    //                      top: 370.79,
    //                      child: SizedBox(
    //                        width: 270.22,
    //                        height: 60.03,
    //                        child: Text(
    //                          'Money Plant',
    //                          style:GoogleFonts.playfairDisplay(
    //                            color: Colors.black,
    //                            fontSize: 32,
    //                            //fontFamily: 'Playfair Display',
    //                            fontWeight: FontWeight.w700,
    //                          ),
    //                        ),
    //                      ),
    //                    ),
    //                    Positioned(
    //                      left: 290.67,
    //                      top: 410.79,
    //                      child: SizedBox(
    //                        width: 270.22,
    //                        height: 60.03,
    //                        child: Text(
    //                          'Indoor',
    //                          style:GoogleFonts.playfairDisplay(
    //                            color: Colors.black45,
    //                            fontSize: 22,
    //                            //fontFamily: 'Playfair Display',
    //                            fontWeight: FontWeight.w400,
    //                          ),
    //                        ),
    //                      ),
    //                    ),
    //                    Positioned(
    //                      left: 0,
    //                      top: 0,
    //                      child: Container(
    //                        width: 96.85,
    //                        height: 97.24,
    //                        decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
    //                      ),
    //                    ),
    //                    Positioned(
    //                      left: 176.27,
    //                      top: 298.96,
    //                      child: SizedBox(
    //                        width: 120.10,
    //                        height: 31.12,
    //                        child: Text(
    //                          '₹250',
    //                          style: GoogleFonts.acme(
    //                            color: Colors.black.withOpacity(0.6600000262260437),
    //                            fontSize: 16,
    //                            //fontFamily: 'Playfair Display',
    //                            fontWeight: FontWeight.w500,
    //                          ),
    //                        ),
    //                      ),
    //                    ),
    //                    Positioned(
    //                      left: 177.24,
    //                      top: 234.48,
    //                      child: SizedBox(
    //                        width: 120.10,
    //                        height: 31.12,
    //                        child: Text(
    //                          'Araceae',
    //                          style: GoogleFonts.acme(
    //                            color: Colors.black.withOpacity(0.6600000262260437),
    //                            fontSize: 16,
    //
    //                            fontWeight: FontWeight.w500,
    //                          ),
    //                        ),
    //                      ),
    //                    ),
    //                    Positioned(
    //                      left: 178.21,
    //                      top: 179.33,
    //                      child: SizedBox(
    //                        width: 120.10,
    //                        height: 31.12,
    //                        child: Text(
    //                          'Small',
    //                          style: GoogleFonts.acme(
    //                            color: Colors.black.withOpacity(0.6600000262260437),
    //                            fontSize: 16,
    //                           // fontFamily: 'Playfair Display',
    //                            fontWeight: FontWeight.w500,
    //                          ),
    //                        ),
    //                      ),
    //                    ),
    //                    Positioned(
    //                      left: 320.59,
    //                      top: 89.05,
    //                      child: SlideAnimation(
    //                        duration: Duration(seconds: 3),
    //                        child: Container(
    //                        width: 188.62,
    //                        height: 286.84,
    //                        decoration: BoxDecoration(
    //                          image: DecorationImage(
    //                            image: AssetImage("assets/sample/i1.png"),
    //                            fit: BoxFit.fill,
    //                          ),
    //                        ),
    //                      ),
    //                    ),),
    //                    Positioned(
    //                      left: 177.24,
    //                      top: 272.68,
    //                      child: SizedBox(
    //                        width: 105.57,
    //                        height: 41.81,
    //                        child: Text(
    //                          'Price\n',
    //                          style: GoogleFonts.playfairDisplay(
    //                            color: Colors.black,
    //                            fontSize: 24,
    //                            //fontFamily: 'Playfair Display',
    //                            fontWeight: FontWeight.w700,
    //                          ),
    //                        ),
    //                      ),
    //                    ),
    //                    Positioned(
    //                      left: 177.24,
    //                      top: 206.56,
    //                      child: SizedBox(
    //                        width: 105.57,
    //                        height: 37.92,
    //                        child: Text(
    //                          'Family\n',
    //                          style: GoogleFonts.playfairDisplay(
    //                            color: Colors.black,
    //                            fontSize: 24,
    //                            //fontFamily: 'Playfair Display',
    //                            fontWeight: FontWeight.w700,
    //                          ),
    //                        ),
    //                      ),
    //                    ),
    //                    Positioned(
    //                      left: 177.24,
    //                      top: 151.41,
    //                      child: SizedBox(
    //                        width: 105.57,
    //                        height: 37.92,
    //                        child: Text(
    //                          'Size',
    //                          style:GoogleFonts.playfairDisplay(
    //                            color: Colors.black,
    //                            fontSize: 24,
    //                            //fontFamily: 'Playfair Display',
    //                            fontWeight: FontWeight.w700,
    //                          ),
    //                        ),
    //                      ),
    //                    ),
    //                    // Positioned(
    //                    //     top: 450,
    //                    //     left: 150,
    //                    //     child:
    //                    //     Container(
    //                    //       width: 330,
    //                    //       height: 180,
    //                    //
    //                    //       child: ListView.builder(
    //                    //         scrollDirection: Axis.horizontal,
    //                    //         itemCount: 3,
    //                    //         padding: EdgeInsets.only(left: 10,right: 20),
    //                    //         itemBuilder:(context, index) {
    //                    //           return Container(
    //                    //             height:80,
    //                    //             width: 330,
    //                    //             decoration: BoxDecoration(
    //                    //                 color: Colors.lightGreen[100],
    //                    //                 border: Border.all(color: Colors.lightGreen.shade900)
    //                    //             ),
    //                    //           );
    //                    //         },),
    //                    //     )),
    //                    Positioned(
    //                      left: 176,
    //                      top:455,
    //                      child: SizedBox(
    //                        width: 126,
    //                        height: 27,
    //                        child: Text(
    //                          'Description',
    //                          style: GoogleFonts.playfairDisplay(
    //                            color: Colors.black,
    //                            fontSize: 20,
    //                           // fontFamily: 'Playfair Display',
    //                            fontWeight: FontWeight.w700,
    //                          ),
    //                        ),
    //                      ),
    //                    ),
    //                    Positioned(
    //                      left: 178,
    //                      top: 488,
    //                      child: SizedBox(
    //                        width: 293.46,
    //                        height:150.37,
    //                        child: Text(
    //                          'The Money Plant (Epipremnum aureum) is a vine with heart-shaped leaves that have a glossy texture. The leaves are typically variegated with green and yellow, although there are also solid green varieties available. The plant produces long, trailing stems that can reach several feet in length.',
    //                          style: GoogleFonts.playfairDisplay(
    //                            color: Colors.black,
    //                            fontSize: 13,
    //                           // fontFamily: 'Playfair Display',
    //                            fontWeight: FontWeight.w400,
    //                          ),
    //                        ),
    //                      ),
    //                    ),
    //                    Positioned(
    //                      left: 176,
    //                      top: 945,
    //                      child: SizedBox(
    //                        width: 326,
    //                        height: 27,
    //                        child: Text(
    //                          'Product Delivery Information:',
    //                          style: GoogleFonts.playfairDisplay(
    //                            color: Colors.black,
    //                            fontSize: 20,
    //                            // fontFamily: 'Playfair Display',
    //                            fontWeight: FontWeight.w700,
    //                          ),
    //                        ),
    //                      ),
    //                    ),
    //                    Positioned(
    //                      left: 178,
    //                      top: 988,
    //                      child: SizedBox(
    //                        width: 293.46,
    //                        height:150.37,
    //                        child: Text(
    //                          "•	The image displayed is indicative in nature.\n•	Actual product may vary in shape or design as per the availability.\n•	The number of leaves and the size of the plant depends on seasonal availability.\n•	Since flowers are seasonal in nature, flowering plants may be delivered without the bloom. Flowers, if present in plant, may be in fully bloomed, semi-bloomed or bud stage.\n•	Pots will be provided as per the requirement of the plant.\n•	Delivery will be attempted on the same day, but there may be a delay of 3-5 hours depending on the traffic and the weather.\n•	Our courier partners do not call prior to delivering an order, so we recommend that you provide an address at which someone will be present to receive the package.\n•	The delivery, once dispatched, cannot be redirected to any other address.",
    //                          style: GoogleFonts.playfairDisplay(
    //                            color: Colors.black,
    //                            fontSize: 13,
    //                            // fontFamily: 'Playfair Display',
    //                            fontWeight: FontWeight.w400,
    //                          ),
    //                        ),
    //                      ),
    //                    ),
    //                    Positioned(
    //                      left: 267,
    //                      top: 665,
    //                      child: Container(
    //                        width: 125,
    //                        height: 29.17,
    //                        decoration: ShapeDecoration(
    //                          color: Color(0xFF054B25),
    //                          shape: RoundedRectangleBorder(
    //                            borderRadius: BorderRadius.circular(24),
    //                          ),
    //                        ),
    //                      ),
    //                    ),
    //                    Positioned(
    //                      left: 262,
    //                      top: 662,
    //                      child: SizedBox(
    //                        width: 133,
    //                        height: 31.12,
    //                        child: Row(
    //                          children: [
    //                            IconButton(onPressed: (){},
    //                                icon: Icon(
    //                                    Icons.remove_circle_outline_sharp,
    //                                     color: Colors.white,
    //                                size: 20),),
    //                            SizedBox(
    //                              width: 15,
    //                            ),
    //                            Text(
    //                              '2',
    //                              style: TextStyle(
    //                                color: Colors.white,
    //                                fontSize: 20,
    //                                fontFamily: 'Playfair Display',
    //                                fontWeight: FontWeight.w400,
    //                              ),
    //                            ),
    //                            SizedBox(
    //                              width:10,
    //                            ),
    //                            IconButton(onPressed: (){},
    //                              icon:Icon(
    //                                  Icons.add_circle_outline_sharp,
    //                                  color: Colors.white,
    //                                  size: 20),),
    //                          ],
    //                        )
    //                      ),
    //                    ),
    //                    Positioned(
    //                      left: 423.79,
    //                      top: 450.35,
    //                      child: Container(
    //                        width: 24.21,
    //                        height: 24.31,
    //                        clipBehavior: Clip.antiAlias,
    //                        decoration: BoxDecoration(color: Colors.black.withOpacity(0)),
    //                      ),
    //                    ),
    //                    Positioned(
    //                      left: 697.79,
    //                      top: 466.05,
    //                      child: Container(
    //                        width: 24.21,
    //                        height: 24.31,
    //                        clipBehavior: Clip.antiAlias,
    //                        decoration: BoxDecoration(color: Colors.black.withOpacity(0)),
    //                        child: Icon(Icons.add_circle_outline_sharp),
    //                      ),
    //                    ),
    //                    Positioned(
    //                      left: 697.79,
    //                      top: 466.05,
    //                      child: Container(
    //                        width: 24.21,
    //                        height: 24.31,
    //                        clipBehavior: Clip.antiAlias,
    //                        decoration: BoxDecoration(color: Colors.black.withOpacity(0)),
    //                      ),
    //                    ),
    //                    Positioned(
    //                      left: 232,
    //                      top: 707,
    //                      child: Container(
    //                        width: 191.77,
    //                        height: 32.09,
    //                        decoration: ShapeDecoration(
    //                          color: Color(0xFF054B25),
    //                          shape: RoundedRectangleBorder(
    //                            borderRadius: BorderRadius.circular(24),
    //                          ),
    //                        ),
    //                      ),
    //                    ),
    //                    Positioned(
    //                      left: 255,
    //                      top: 707.68,
    //                      child: SizedBox(
    //                        width: 165.95,
    //                        height: 26.46,
    //                        child: Row(
    //                          children: [
    //                            Icon(Icons.shopping_cart,
    //                            color: Colors.white,
    //                            size: 18,),
    //                            SizedBox(
    //                              width: 10,
    //                            ),
    //                            Text(
    //                              'Add To Cart',
    //                              style: GoogleFonts.playfairDisplay(
    //                                color: Colors.white,
    //                                fontSize: 20,
    //                                //fontFamily: 'Playfair Display',
    //                                fontWeight: FontWeight.w700,
    //                              ),
    //                            ),
    //                          ],
    //                        ),
    //                      ),
    //                    ),
    //                    Positioned(
    //                      left: 697.79,
    //                      top: 466.05,
    //                      child: Container(
    //                        width: 24.21,
    //                        height: 24.31,
    //
    //                        clipBehavior: Clip.antiAlias,
    //                        decoration: ShapeDecoration(
    //                          color: Color(0xFF054B25),
    //                          shape: RoundedRectangleBorder(
    //                            borderRadius: BorderRadius.circular(24),
    //                          ),
    //                        ),
    //
    //                      ),
    //                    ),
    //                  ],
    //                ),
    //              ),
    //            ),
    //
    //
    //          ],
    //        ),
    //      )
    //      // child:Container(
    //      //   width: 765.47,
    //      //   height: 893,
    //      //   child: Stack(
    //      //     children: [
    //      //       Positioned(
    //      //         left: 0,
    //      //         top: 40,
    //      //         child: Container(
    //      //           width: 479,
    //      //           height: 850,
    //      //           decoration: BoxDecoration(color: Color(0xC6F9F9F9)),
    //      //         ),
    //      //       ),
    //      //       Positioned(
    //      //         left: 70,
    //      //         top: 410,
    //      //         child: SizedBox(
    //      //           width: 279,
    //      //           height: 45,
    //      //           child: Text(
    //      //             'Money Plant',
    //      //             style: GoogleFonts.playfairDisplay(
    //      //               color: Colors.black,
    //      //               fontSize: 40,
    //      //               //fontFamily: 'Playfair Display',
    //      //               fontWeight: FontWeight.w700,
    //      //             ),
    //      //           ),
    //      //         ),
    //      //       ),
    //      //       // Positioned(
    //      //       //   left: 0,
    //      //       //   top: 0,
    //      //       //   child: Container(
    //      //       //     width: 100,
    //      //       //     height: 100,
    //      //       //     decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
    //      //       //   ),
    //      //       // ),
    //      //       Positioned(
    //      //         left: 20,
    //      //         top: 327,
    //      //         child: SizedBox(
    //      //           width: 124,
    //      //           height: 32,
    //      //           child: Text(
    //      //             '\u{20B9}250',
    //      //             style: GoogleFonts.playfairDisplay(
    //      //               color: Colors.black.withOpacity(0.6600000262260437),
    //      //               fontSize: 16,
    //      //               //fontFamily: 'Playfair Display',
    //      //               fontWeight: FontWeight.w500,
    //      //             ),
    //      //           ),
    //      //         ),
    //      //       ),
    //      //       Positioned(
    //      //         left:20,
    //      //         top: 240,
    //      //         child: SizedBox(
    //      //           width: 124,
    //      //           height: 32,
    //      //           child: Text(
    //      //             'Catcasus',
    //      //             style: GoogleFonts.playfairDisplay(
    //      //               color: Colors.black.withOpacity(0.6600000262260437),
    //      //               fontSize: 16,
    //      //              // fontFamily: 'Playfair Display',
    //      //               fontWeight: FontWeight.w500,
    //      //             ),
    //      //           ),
    //      //         ),
    //      //       ),
    //      //       Positioned(
    //      //         left: 20,
    //      //         top: 153,
    //      //         child: SizedBox(
    //      //           width: 124,
    //      //           height: 32,
    //      //           child: Text(
    //      //             'Small',
    //      //             style: GoogleFonts.playfairDisplay(
    //      //               color: Colors.black.withOpacity(0.6600000262260437),
    //      //               fontSize: 16,
    //      //               //fontFamily: 'Playfair Display',
    //      //               fontWeight: FontWeight.w500,
    //      //             ),
    //      //           ),
    //      //         ),
    //      //       ),
    //      //       Positioned(
    //      //         left: 130,
    //      //         top: 80,
    //      //         child: Container(
    //      //           width: 298,
    //      //           height: 295,
    //      //           decoration: BoxDecoration(
    //      //             image: DecorationImage(
    //      //               image: AssetImage("assets/plants/plant.png"),
    //      //               fit: BoxFit.fill,
    //      //             ),
    //      //           ),
    //      //         ),
    //      //       ),
    //      //       Positioned(
    //      //         left: 20,
    //      //         top: 290,
    //      //         child: SizedBox(
    //      //           width: 109,
    //      //           height: 39,
    //      //           child: Text(
    //      //             'Price\n',
    //      //             style: GoogleFonts.playfairDisplay(
    //      //               color: Colors.black,
    //      //               fontSize: 24,
    //      //               //fontFamily: 'Playfair Display',
    //      //               fontWeight: FontWeight.w700,
    //      //             ),
    //      //           ),
    //      //         ),
    //      //       ),
    //      //       Positioned(
    //      //         left: 20,
    //      //         top: 201,
    //      //         child: SizedBox(
    //      //           width: 109,
    //      //           height: 39,
    //      //           child: Text(
    //      //             'Family\n',
    //      //             style: GoogleFonts.playfairDisplay(
    //      //               color: Colors.black,
    //      //               fontSize: 24,
    //      //               //fontFamily: 'Playfair Display',
    //      //               fontWeight: FontWeight.w700,
    //      //             ),
    //      //           ),
    //      //         ),
    //      //       ),
    //      //       Positioned(
    //      //         left:20,
    //      //         top: 127,
    //      //         child: SizedBox(
    //      //           width: 109,
    //      //           height: 39,
    //      //           child: Text(
    //      //             'Size',
    //      //             style: GoogleFonts.playfairDisplay(
    //      //               color: Colors.black,
    //      //               fontSize: 24,
    //      //               //fontFamily: 'Playfair Display',
    //      //               fontWeight: FontWeight.w700,
    //      //             ),
    //      //           ),
    //      //         ),
    //      //       ),
    //      //       Positioned(
    //      //         left: 115,
    //      //         top: 480,
    //      //         child: Container(
    //      //           width: 134,
    //      //           height: 30,
    //      //           decoration: ShapeDecoration(
    //      //             color: Color(0xFF054B25),
    //      //             shape: RoundedRectangleBorder(
    //      //               borderRadius: BorderRadius.circular(24),
    //      //             ),
    //      //           ),
    //      //         ),
    //      //       ),
    //      //       Positioned(
    //      //         left: 150,
    //      //         top: 480,
    //      //         child: Text(
    //      //           'Indoor',
    //      //           style: GoogleFonts.playfairDisplay(
    //      //             color: Colors.white,
    //      //             fontSize: 20,
    //      //             //fontFamily: 'Playfair Display',
    //      //             fontWeight: FontWeight.w700,
    //      //           ),
    //      //         ),
    //      //       ),
    //      //       Positioned(
    //      //         left: 20,
    //      //         top: 532,
    //      //         child: Text(
    //      //           'Description',
    //      //           style: TextStyle(
    //      //             color: Colors.black,
    //      //             fontSize: 20,
    //      //             fontFamily: 'Playfair Display',
    //      //             fontWeight: FontWeight.w700,
    //      //           ),
    //      //         ),
    //      //       ),
    //      //       Positioned(
    //      //         left: 20,
    //      //         top: 726,
    //      //         child: Text(
    //      //           'Reviews',
    //      //           style: GoogleFonts.playfairDisplay(
    //      //             color: Colors.black,
    //      //             fontSize: 20,
    //      //             //fontFamily: 'Playfair Display',
    //      //             fontWeight: FontWeight.w700,
    //      //           ),
    //      //         ),
    //      //       ),
    //      //       // Positioned(
    //      //       //   left: 20,
    //      //       //   top: 559,
    //      //       //   child: Container(
    //      //       //     width: 110,
    //      //       //     decoration: ShapeDecoration(
    //      //       //       shape: RoundedRectangleBorder(
    //      //       //         side: BorderSide(
    //      //       //           width: 0.50,
    //      //       //          // strokeAlign: BorderSide.strokeAlignCenter,
    //      //       //         ),
    //      //       //       ),
    //      //       //     ),
    //      //       //   ),
    //      //       // ),
    //      //       Positioned(
    //      //         left: 20,
    //      //         top: 561,
    //      //         child: SizedBox(
    //      //           width: 303,
    //      //           height: 86,
    //      //           child: Text(
    //      //             'Money plant marbel queen are best to fill the house with greenery and to bring prosperity and good luck. As well as they are perfect to gift your loved ones on festivals and housewarming functions and promote the concept of green gifting.',
    //      //             style: TextStyle(
    //      //               color: Colors.black,
    //      //               fontSize: 13,
    //      //               fontFamily: 'Playfair Display',
    //      //               fontWeight: FontWeight.w400,
    //      //             ),
    //      //           ),
    //      //         ),
    //      //       ),
    //      //       Positioned(
    //      //         left:118,
    //      //         top: 680,
    //      //         child: Container(
    //      //           width: 120,
    //      //           height: 30,
    //      //           decoration: ShapeDecoration(
    //      //             color: Color(0xFF054B25),
    //      //             shape: RoundedRectangleBorder(
    //      //               borderRadius: BorderRadius.circular(24),
    //      //             ),
    //      //           ),
    //      //         ),
    //      //       ),
    //      //       Positioned(
    //      //         left: 170,
    //      //         top: 680,
    //      //         child: Text(
    //      //           '2',
    //      //           style: TextStyle(
    //      //             color: Colors.white,
    //      //             fontSize: 24,
    //      //             fontFamily: 'Playfair Display',
    //      //             fontWeight: FontWeight.w400,
    //      //           ),
    //      //         ),
    //      //       ),
    //      //       Positioned(
    //      //         left: 437.57,
    //      //         top: 463.15,
    //      //         child: Container(
    //      //           width: 25,
    //      //           height: 25,
    //      //           clipBehavior: Clip.antiAlias,
    //      //           decoration: BoxDecoration(color: Colors.black.withOpacity(0)),
    //      //         ),
    //      //       ),
    //      //       // Positioned(
    //      //       //   left: 720.47,
    //      //       //   top: 479.30,
    //      //       //   child: Container(
    //      //       //     width: 25,
    //      //       //     height: 25,
    //      //       //     clipBehavior: Clip.antiAlias,
    //      //       //     decoration: BoxDecoration(color: Colors.black.withOpacity(0)),
    //      //       //   ),
    //      //       // ),
    //      //       Positioned(
    //      //         left:20,
    //      //         top: 753,
    //      //         child: Container(
    //      //           width: 75,
    //      //           decoration: ShapeDecoration(
    //      //             shape: RoundedRectangleBorder(
    //      //               side: BorderSide(
    //      //                 width: 0.50,
    //      //                 //strokeAlign: BorderSide.strokeAlignCenter,
    //      //               ),
    //      //             ),
    //      //           ),
    //      //         ),
    //      //       ),
    //      //       Positioned(
    //      //         left: 20.47,
    //      //         top: 479.30,
    //      //         child: Container(
    //      //           width: 25,
    //      //           height: 25,
    //      //           clipBehavior: Clip.antiAlias,
    //      //           decoration: BoxDecoration(color: Colors.black.withOpacity(0)),
    //      //         ),
    //      //       ),
    //      //       Positioned(
    //      //         left: 80,
    //      //         top: 807,
    //      //         child: Container(
    //      //           width: 198,
    //      //           height: 33,
    //      //           decoration: ShapeDecoration(
    //      //             color: Color(0xFF054B25),
    //      //             shape: RoundedRectangleBorder(
    //      //               borderRadius: BorderRadius.circular(24),
    //      //             ),
    //      //           ),
    //      //         ),
    //      //       ),
    //      //       Positioned(
    //      //         left: 127,
    //      //         top: 810,
    //      //         child: Text(
    //      //           'Add To Cart',
    //      //           style: GoogleFonts.playfairDisplay(
    //      //             color: Colors.white,
    //      //             fontSize: 20,
    //      //             //fontFamily: 'Playfair Display',
    //      //             fontWeight: FontWeight.w700,
    //      //           ),
    //      //         ),
    //      //       ),
    //      //       // Positioned(
    //      //       //   left: 720.47,
    //      //       //   top: 479.30,
    //      //       //   child: Container(
    //      //       //     width: 25,
    //      //       //     height: 25,
    //      //       //     clipBehavior: Clip.antiAlias,
    //      //       //     decoration: BoxDecoration(color: Colors.black.withOpacity(0)),
    //      //       //   ),
    //      //       // ),
    //      //     ],
    //      //   ),
    //      // )
    //
    //    )
    //
    //
    //
    // ));
  }
}

class PlantData {
  final String heading;
  final String text;
  final Icon icons;

  PlantData({required this.heading, required this.text, required this.icons});
}
