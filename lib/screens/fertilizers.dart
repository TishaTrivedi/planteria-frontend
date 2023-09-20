import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:plantbackend/Animations/slide_animation.dart';
class Fertilizers extends StatefulWidget {
  //const Fertilizers({Key? key}) : super(key: key);


  late final String plantId;
  Fertilizers({required this.plantId});
  @override
  State<Fertilizers> createState() => _FertilizersState();
}

class _FertilizersState extends State<Fertilizers> with SingleTickerProviderStateMixin {
  late TabController _tabController;
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

  final HttpLink httpLink = HttpLink('http://192.168.1.112:8000/graphql');

  late GraphQLClient client;

  final String fetchPlantQuery = r'''
    query($id: ID!) {
      plantsById(id: $id) {
        id
        plantName
        desc
        category
        subcategory
        price
        family
        size
        images
        water
        sunlight
        fertilizer
        temperature
       
        
      }
    }
  ''';
  @override
  void initState() {
    super.initState();
    client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),

    );
    _tabController = TabController(length: 2, vsync: this);
    quant=1;
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  bool isLiked = false;

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.lightGreen.shade50,
          body: Query(
      options: QueryOptions(
      document: gql(fetchPlantQuery),
        variables: {'id': widget.plantId,} // Replace with the actual plant ID
    ),
    builder: (QueryResult result, {fetchMore, refetch}) {
    if (result.hasException) {
    return Center(
    child: Text(
    'Error fetching plants: ${result.exception.toString()}',
    ),
    );
    }

    if (result.isLoading) {
    return Center(
    child: CircularProgressIndicator(),
    );
    }

    final Map<String, dynamic> plants = result.data?['plantsById'];
    return SingleChildScrollView(
    child: Container(
    width: 371,
    height: 1201,
    color: Colors.lightGreen.shade50,
    child: Stack(
    children: [

    Positioned(
    left: -152,
    top: -45,
    child: Container(
    width: 722,
    height: 2000,
    child: Stack(
    children: [
      Positioned(
          left: 180,
          top: 750,
          child: Container(
            width: 350,
            height: 500,
            padding: EdgeInsets.only(right: 40),

            child:Center(
              child:Text(
                "•	The image displayed is indicative in nature.\n•	Actual product may vary in shape or design as per the availability.\n•	The number of leaves and the size of the plant depends on seasonal availability.\n•	Since flowers are seasonal in nature, flowering plants may be delivered without the bloom. Flowers, if present in plant, may be in fully bloomed, semi-bloomed or bud stage.\n•	Pots will be provided as per the requirement of the plant.\n•	Delivery will be attempted on the same day, but there may be a delay of 3-5 hours depending on the traffic and the weather.\n•	Our courier partners do not call prior to delivering an order, so we recommend that you provide an address at which someone will be present to receive the package.\n•	The delivery, once dispatched, cannot be redirected to any other address.",
                style: GoogleFonts.playfairDisplay(
                  color: Colors.black,
                  fontSize: 13,
                  // fontFamily: 'Playfair Display',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )),
    Positioned(
    left: 260.67,
    top: 370.79,
    child: SizedBox(
    width: 230.22,
    height: 100.03,
    child: Text(
    plants['plantName'],
    style: GoogleFonts.playfairDisplay(
    color: Colors.black,
    fontSize: 25,
    fontWeight: FontWeight.w500,
    ),
    ),
    ),
    ),
    Positioned(
    left: 290.67,
    top: 425.79,
    child: SizedBox(
    width: 270.22,
    height: 60.03,
    child: Text(
    plants['subcategory'],
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
    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
    ),
    ),
    Positioned(
    left: 176.27,
    top: 298.96,
    child: SizedBox(
    width: 120.10,
    height: 31.12,
    child: Text(
    '₹' + plants['price']
        .toString(),
    style: GoogleFonts.acme(
    color: Colors.black.withOpacity(0.6600000262260437),
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
    plants['family'],
    style: GoogleFonts.acme(
    color: Colors.black.withOpacity(0.6600000262260437),
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
    plants['size'],
    style: GoogleFonts.acme(
    color: Colors.black.withOpacity(0.6600000262260437),
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
    duration: Duration(seconds:1),
    child: Container(
    width: 188.62,
    height: 286.84,
    decoration: BoxDecoration(
    image: DecorationImage(
    image: NetworkImage("http://192.168.1.112:8000/media/${plants['images']}"),
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
    Positioned(
    top: 100,
    left: 167.24,
    child: IconButton(
    icon:Icon(
    isLiked ? Icons.favorite : Icons.favorite_border,
    color: isLiked ? Colors.red.shade600 : null, // Set the color to red if it's liked
    ),
    onPressed: _toggleLike,)),

    // TabView
    Positioned(
    left: 176,
    top: 450,
    right: 0,
    bottom: 0,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    SizedBox(
    height: 10,
    ),
    FractionallySizedBox(
    widthFactor: 0.5,

    child:TabBar(
    controller: _tabController,
    physics: AlwaysScrollableScrollPhysics(),
    // padding: EdgeInsets.only(left: 20),
    indicatorColor: Colors.black12,
    labelStyle: GoogleFonts.acme(
    color: Colors.black
    ),
    labelColor: Colors.black,
    unselectedLabelStyle:GoogleFonts.acme(
    color: Colors.black
    ),
    unselectedLabelColor: Colors.black,


    tabs: [
    Tab(
    child: SizedBox(
    width: 100, // Expand the width to take half of the space
    child: Center(
    child: Text(
    'Description',
    textAlign: TextAlign.center,
    ),
    ),
    ),
    ),
    // Custom layout for the second tab (Plant care)
    Tab(
    child: SizedBox(
    width:100, // Expand the width to take half of the space
    child: Center(
    child: Text(
    'Plant care',
    textAlign: TextAlign.center,
    ),
    ),
    ),
    ),


    ],
    labelPadding: EdgeInsets.symmetric(horizontal:20),
    ),),
    SizedBox(
    height: 10,
    ),
      Container(
        height: 150,
        width: 320,
        child: Container(
          width: 350,
          height: 200,

          decoration: ShapeDecoration(

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),),
          child: TabBarView(
              controller: _tabController,
              children: [
                // Description Tab Content
                Container(
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: [Color(0xFDBBDA9B).withOpacity(0.4),Color(
                          0xFDC8DEAE).withOpacity(0.4),Color(
                          0xFDE1ECD3).withOpacity(0.4)],
                    ),
                    // color: Colors.lightGreen[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),),
                  padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                  child: Text(
                    //textAlign: TextAlign.center,
                    plants['desc'],
                    style: GoogleFonts.playfairDisplay(
                      color: Colors.black,
                      fontSize: 13,
                      // fontFamily: 'Playfair Display',
                      fontWeight: FontWeight.w400,
                    ),
                  ),),
                // About Tab Content
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(

                        width: 220,
                        height:140,
                        child: Stack(
                          children: [
                            Positioned(
                              left:10,
                              top: 7,
                              child: Container(
                                width:200,
                                height: 130,
                                decoration: ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(0.00, -1.00),
                                    end: Alignment(0, 1),
                                    colors: [Color(0xFDEFE73B).withOpacity(0.5), Color(0xFFF5E9A3).withOpacity(0.5), ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              top:25,
                              child: Container(
                                width: 25,
                                height: 25,
                                child: Icon(Icons.sunny,
                                    color: Colors.orange.shade700),
                              ),

                            ),
                            Positioned(
                              left: 20,
                              top: 55,
                              child: SizedBox(
                                width: 200,
                                height: 50,
                                child: Text(
                                  'Sunlight ',
                                  style: GoogleFonts.playfairDisplay(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    //fontFamily: 'Playfair Display',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              top: 80,
                              child: SizedBox(
                                width: 200,
                                height: 50,
                                child: Text(
                                  plants['sunlight'],
                                  style: GoogleFonts.playfairDisplay(
                                    color: Colors.black,
                                    fontSize: 15,
                                    //fontFamily: 'Playfair Display',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: 220,
                        height:140,
                        child: Stack(
                          children: [
                            Positioned(
                              //left:10,
                              top: 7,
                              child: Container(
                                width:200,
                                height: 130,
                                decoration: ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(0.00, -1.00),
                                    end: Alignment(0, 1),
                                    colors: [Color(0xFD48B5AF).withOpacity(0.4), Color(0xFDA8E8E4).withOpacity(0.4)],                                                          ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              top:25,
                              child: Container(
                                width: 25,
                                height: 25,
                                child: Icon(Icons.water_drop,
                                    color: Colors.blue.shade900),
                              ),

                            ),
                            Positioned(
                              left: 20,
                              top: 55,
                              child: SizedBox(
                                width: 200,
                                height: 50,
                                child: Text(
                                  'Water ',
                                  style: GoogleFonts.playfairDisplay(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    //fontFamily: 'Playfair Display',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              top: 80,
                              child: SizedBox(
                                width: 200,
                                height: 50,
                                child: Text(
                                  plants['water'],
                                  style: GoogleFonts.playfairDisplay(
                                    color: Colors.black,
                                    fontSize: 15,
                                    //fontFamily: 'Playfair Display',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 220,
                        height:140,
                        child: Stack(
                          children: [
                            Positioned(
                              left:10,
                              top: 7,
                              child: Container(
                                width:200,
                                height: 130,
                                decoration: ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(0.00, -1.00),
                                    end: Alignment(0, 1),
                                    colors: [Color(0xFDF5890B).withOpacity(0.3), Color(0xFFEFAC77).withOpacity(0.3)],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              top:25,
                              child: Container(
                                width: 25,
                                height: 25,
                                child: Icon(Icons.thermostat_rounded,
                                    color: Colors.red.shade700),
                              ),

                            ),
                            Positioned(
                              left: 20,
                              top: 55,
                              child: SizedBox(
                                width: 200,
                                height: 50,
                                child: Text(
                                  'Temperature ',
                                  style: GoogleFonts.playfairDisplay(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    //fontFamily: 'Playfair Display',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              top: 80,
                              child: SizedBox(
                                width: 200,
                                height: 50,
                                child: Text(
                                  plants['temperature'],
                                  style: GoogleFonts.playfairDisplay(
                                    color: Colors.black,
                                    fontSize: 15,
                                    //fontFamily: 'Playfair Display',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 220,
                        height:140,
                        child: Stack(
                          children: [
                            Positioned(
                              left:10,
                              top: 7,
                              child: Container(
                                width:200,
                                height: 130,
                                decoration: ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(0.00, -1.00),
                                    end: Alignment(0, 1),
                                    colors: [Color(0xFD8979EC).withOpacity(0.3),Color(0xFDBDB3F5).withOpacity(0.3)],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              top:25,
                              child: Container(
                                width: 25,
                                height: 25,
                                child: Icon(Icons.waves_outlined,
                                    color: Colors.deepPurple.shade700),
                              ),

                            ),
                            Positioned(
                              left: 20,
                              top: 55,
                              child: SizedBox(
                                width: 200,
                                height: 50,
                                child: Text(
                                  'Fertilizer',
                                  style: GoogleFonts.playfairDisplay(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    //fontFamily: 'Playfair Display',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              top: 75,
                              child: SizedBox(
                                width: 160,
                                height: 70,
                                child: Text(
                                  plants['fertilizer'],
                                  style: GoogleFonts.playfairDisplay(
                                    color: Colors.black,
                                    fontSize: 15,
                                    //fontFamily: 'Playfair Display',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),


                ),
              ]),
        ),

      )
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
          // Positioned(
          // left: 178,
          // top: 828,
          // child: SizedBox(
          // width: 293.46,
          // height:150.37,
          // child: Text(
          // "•	The image displayed is indicative in nature.\n•	Actual product may vary in shape or design as per the availability.\n•	The number of leaves and the size of the plant depends on seasonal availability.\n•	Since flowers are seasonal in nature, flowering plants may be delivered without the bloom. Flowers, if present in plant, may be in fully bloomed, semi-bloomed or bud stage.\n•	Pots will be provided as per the requirement of the plant.\n•	Delivery will be attempted on the same day, but there may be a delay of 3-5 hours depending on the traffic and the weather.\n•	Our courier partners do not call prior to delivering an order, so we recommend that you provide an address at which someone will be present to receive the package.\n•	The delivery, once dispatched, cannot be redirected to any other address.",
          // style: GoogleFonts.playfairDisplay(
          // color: Colors.black,
          // fontSize: 13,
          // // fontFamily: 'Playfair Display',
          // fontWeight: FontWeight.w400,
          // ),
          // ),
          // ),
          // ),
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
          IconButton(onPressed: (){
          decrement();
          },
          icon: Icon(
          Icons.remove_circle_outline_sharp,
          color: Colors.white,
          size: 20),),
          SizedBox(
          width: 15,
          ),
          Text(
          '$quant',
          style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Playfair Display',
          fontWeight: FontWeight.w400,
          ),
          ),
          SizedBox(
          width:10,
          ),
          IconButton(onPressed: (){
          increment();
          },
          icon:Icon(
          Icons.add_circle_outline_sharp,
          color: Colors.white,
          size: 20),),
          ],
          )
          ),
          ),
          Positioned(
          left: 423.79,
          top: 470.35,
          child: Container(
          width: 24.21,
          height: 24.31,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.black.withOpacity(0)),
          ),
          ),
          Positioned(
          left: 697.79,
          top: 486.05,
          child: Container(
          width: 24.21,
          height: 24.31,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.black.withOpacity(0)),
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
          decoration: BoxDecoration(color: Colors.black.withOpacity(0)),
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
          Icon(Icons.shopping_cart,
          color: Colors.white,
          size: 18,),
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
          ),)),
          ],
          ),
          ),
          ),
          ],
          ),
          ),


          );
          }),
          ));
  }
}
