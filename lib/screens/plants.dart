import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:plantbackend/screens/descpage.dart';

class Plants extends StatefulWidget {
  const Plants({Key? key}) : super(key: key);

  @override
  State<Plants> createState() => _PlantsState();
}

class _PlantsState extends State<Plants> with SingleTickerProviderStateMixin {
  TextEditingController searchcontroller = TextEditingController();
  var button;
  bool isSelected = false;
  bool isSelected1 = false;
  bool isSelected2 = false;
  bool isSelected3 = false;
  bool isSelected4 = false;
  final List<PlantData> plantDataList = [
    PlantData(
        text: 'Money Plant',
        imagePath: 'assets/plants/plant.png',
        color: Colors.teal.shade100),
    PlantData(
        text: 'Plants',
        imagePath: 'assets/plants/rose.png',
        color: Colors.green.shade100),
    PlantData(
        text: 'Plants',
        imagePath: 'assets/plants/p3.png',
        color: Colors.green.shade100),
    PlantData(
        text: 'Plants',
        imagePath: 'assets/plants/p4.png',
        color: Colors.green.shade100),
    PlantData(
        text: 'Plants',
        imagePath: 'assets/plants/p5.png',
        color: Colors.green.shade100),
    PlantData(
        text: 'Plants',
        imagePath: 'assets/plants/plant.png',
        color: Colors.green.shade100),
    PlantData(
        text: 'Plants',
        imagePath: 'assets/plants/plant.png',
        color: Colors.green.shade100),
    PlantData(
        text: 'Plants',
        imagePath: 'assets/plants/plant.png',
        color: Colors.green.shade100),

    // Add more CardData objects for additional cards
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/bg.png"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          //padding: EdgeInsets.only(left: 20), // Add left padding to shift the content towards the left
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: AnimSearchBar(
                      width: 178,
                      textController: searchcontroller,
                      onSuffixTap: () {
                        setState(() {
                          searchcontroller.clear();
                        });
                      },
                      onSubmitted: (p0) => {},
                      color: Color(0xFC054B25),
                      searchIconColor: Colors.white,
                      helpText: "Search your fav plants..",
                      rtl: true,
                      animationDurationInMilli: 800,
                      autoFocus: true,
                      closeSearchOnSuffixTap: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Text(
                        "Find your\nFavourite plants",
                        style: GoogleFonts.acme(
                          color: Color(0xFC054B25),
                          fontSize: 22,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(10),
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isSelected1 = !isSelected1;
                          isSelected2 = false;
                          isSelected3 = false;
                          isSelected4 = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSelected1
                            ? Color(0xFC054B25)
                            : Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      child: Text(
                        'All',
                        style: TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 20,
                          color: isSelected1 ? Colors.white : Colors.teal,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isSelected1 = false;
                          isSelected2 = !isSelected2;
                          isSelected3 = false;
                          isSelected4 = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isSelected2 ? Colors.teal : Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      child: Text(
                        'Outdoor',
                        style: TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 20,
                          color: isSelected2 ? Colors.white : Colors.teal,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isSelected1 = false;
                          isSelected2 = false;
                          isSelected3 = !isSelected3;
                          isSelected4 = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isSelected3 ? Colors.teal : Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      child: Text(
                        'Popular',
                        style: TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 20,
                          color: isSelected3 ? Colors.white : Colors.teal,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isSelected1 = false;
                          isSelected2 = false;
                          isSelected3 = false;
                          isSelected4 = !isSelected4;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isSelected4 ? Colors.teal : Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      child: Text(
                        'Vastu',
                        style: TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 20,
                          color: isSelected4 ? Colors.white : Colors.teal,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.45,
                        crossAxisSpacing:
                            8.0 // Adjust this value to change card aspect ratio
                        ),
                    padding: EdgeInsets.only(left: 20, right: 20, top: 0),
                    scrollDirection: Axis.vertical,
                    itemCount: plantDataList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: GestureDetector(
                            onTap: () {
                              switch (index) {
                                case 0:
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DescPage()));
                                  break;
                                case 1:
                                  Navigator.pushNamed(context, '/tools');
                                  break;
                                case 2:
                                  Navigator.pushNamed(context, '/fertilizers');
                                  break;
                                case 3:
                                  Navigator.pushNamed(context, '/soil');
                                  break;
                              }
                            },
                            child: Container(
                              width: 400,
                              height: 349,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 50,
                                    child: Container(
                                      width: 160,
                                      height: 270,
                                      decoration: ShapeDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment(0.00, -1.00),
                                          end: Alignment(0, 1),
                                          colors: [
                                            Color(0xFF054B25),
                                            Colors.white
                                          ],
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      left: 20, top: 65, child: LikeButton()),
                                  Positioned(
                                    left: 50.77,
                                    top: 0,
                                    child: Container(
                                      width: 134.45,
                                      height: 191.74,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              plantDataList[index].imagePath),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 477.50,
                                    top: 267.23,
                                    child: Container(
                                      width: 20.50,
                                      height: 23.05,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0)),
                                    ),
                                  ),
                                  Positioned(
                                    left: 80,
                                    top: 275.60,
                                    child: Container(
                                      width: 70.50,
                                      height: 25.81,
                                      decoration: ShapeDecoration(
                                        color: Color(0xFFF9F9F9),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 11.48,
                                    top: 227.05,
                                    child: SizedBox(
                                      width: 213.15,
                                      height: 35.28,
                                      child: Text(
                                        'an evergreen vine growing\nup to 20 m tall',
                                        style: GoogleFonts.playfairDisplay(
                                          color: Colors.white
                                              .withOpacity(0.7200000286102295),
                                          fontSize: 14,
                                          //fontFamily: 'Playfair Display',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 16,
                                    top: 190,
                                    child: SizedBox(
                                      width: 193,
                                      height: 29,
                                      child: Text(
                                        'Money Plant\n',
                                        style: GoogleFonts.playfairDisplay(
                                          color: Colors.white,
                                          fontSize: 24,
                                          //fontFamily: 'Playfair Display',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 95.69,
                                    top: 277.14,
                                    child: SizedBox(
                                      width: 65.59,
                                      height: 29.28,
                                      child: Text(
                                        '\u{20B9}250',
                                        style: GoogleFonts.adamina(
                                          color: Color(0xFF054B25),
                                          fontSize: 18,
                                          //fontFamily: 'Playfair Display',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlantData {
  final String text;
  final String imagePath;
  final Color color;

  PlantData({required this.text, required this.imagePath, required this.color});
}
