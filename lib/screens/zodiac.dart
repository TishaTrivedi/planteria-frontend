import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantbackend/Animations/scale_animation.dart';
import 'package:plantbackend/screens/fertilizers.dart';
class Zodiac extends StatefulWidget {
  const Zodiac({Key? key}) : super(key: key);

  @override
  State<Zodiac> createState() => _ZodiacState();
}

class _ZodiacState extends State<Zodiac> {
  final List<PlantsData> plantList =[
    PlantsData(plantImage: "assets/sample/i7.png", plantName: "Rose Plant", plantCategory: "Indoor", plantPrice: "299"),
    PlantsData(plantImage: "assets/sample/i8.png", plantName: "Money Plant", plantCategory: "Indoor", plantPrice: "79"),
    PlantsData(plantImage: "assets/sample/i11.png", plantName: "Money Plant", plantCategory: "Indoor", plantPrice: "179"),
    PlantsData(plantImage: "assets/sample/i10.png", plantName: "Money Plant", plantCategory: "Indoor", plantPrice: "279"),
    PlantsData(plantImage: "assets/sample/i1.png", plantName: "Money Plant", plantCategory: "Indoor", plantPrice: "149"),
    PlantsData(plantImage: "assets/sample/i2.png", plantName: "Silly Plant", plantCategory: "Indoor", plantPrice: "49"),
    PlantsData(plantImage: "assets/sample/i3.png", plantName: "Snake Plant", plantCategory: "Indoor", plantPrice: "249"),
    PlantsData(plantImage: "assets/sample/i12.png", plantName: "Turmeric", plantCategory: "Indoor", plantPrice: "349"),
    PlantsData(plantImage: "assets/sample/i5.png", plantName: "Jasmine", plantCategory: "Indoor", plantPrice: "99"),
    PlantsData(plantImage: "assets/sample/i6.png", plantName: "Peace Lilly", plantCategory: "Indoor", plantPrice: "199"),



  ];


  List<PlantsData> wishlist = [];


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.lightGreen[50],
        body: Container(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),

              Expanded(
                //height: 1000,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:2,
                    childAspectRatio: 0.95,
                    //crossAxisSpacing: 2.0// Adjust this value to change card aspect ratio
                  ),

                  padding: EdgeInsets.only(left:0,right:0,top: 0),
                  scrollDirection: Axis.vertical,
                  itemCount: plantList.length,
                  itemBuilder: (context, index) {
                    final plant = plantList[index];
                    return Container(
                        width:210, // Adjust the width of each item as needed
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                          onTap: (){

                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Fertilizers(plantId: "",)));
                          },
                          child:Stack(
                            children: [
                              Positioned(
                                left: 160,
                                top: 190,
                                child: Transform(
                                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-3.14),
                                  child: Container(
                                    width: 160,
                                    height: 156,
                                    decoration: ShapeDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment(0.00, -1.00),
                                        end: Alignment(0, 1),
                                        colors: [ Color(0xFF99A897),Color(0xFF50694C),Color(0xFF21411C)],

                                        // colors: [ Color(0xFF56887D),Color(0xFF317873),Color(0xFF004B49)],
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 12,
                                top: 111,
                                child: SizedBox(
                                  width: 147,
                                  height: 24,
                                  child: Text(
                                    plantList[index].plantName,
                                    style: GoogleFonts.playfairDisplay(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 100,
                                top: 145.34,
                                child: Container(
                                  width: 35,
                                  height: 30.45,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(color: Colors.black.withOpacity(0)),
                                  child: IconButton(
                                    onPressed: (){},
                                    icon: Icon(Icons.shopping_cart),
                                    color:Colors.white.withOpacity(0.7400000095367432),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 12,
                                top: 161,
                                child: Container(
                                  width: 55.23,
                                  height: 18.57,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 55.23,
                                          height: 18.57,
                                          decoration: ShapeDecoration(
                                            color: Colors.white.withOpacity(0.7099999785423279),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(24),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 3,
                                        top: 0,
                                        child: SizedBox(
                                          width: 45,
                                          height: 18,
                                          child: Text(
                                            '₹'+plantList[index].plantPrice,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.acme(
                                              color: Color(0xFF20401B),
                                              fontSize: 15.50,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 12,
                                top: 135,
                                child: SizedBox(
                                  width: 111,
                                  height: 22.51,
                                  child: Text(
                                    plantList[index].plantCategory,
                                    style: GoogleFonts.playfairDisplay(
                                      color: Colors.white.withOpacity(0.7400000095367432),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 13,
                                top: 45.31,
                                child: Container(
                                  width: 40,
                                  height: 43.45,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(color: Colors.black.withOpacity(0)),
                                  child: IconButton(
                                    icon: Icon(
                                      plant.isLiked ? Icons.favorite : Icons.favorite_border,
                                      color: plant.isLiked ? Colors.red.shade600 : null,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        plant.toggleLike();
                                        if (plant.isLiked) {
                                          wishlist.add(plant);
                                        } else {
                                          wishlist.remove(plant);
                                        }
                                      });
                                    },
                                    color: Colors.white,
                                  ),
                                ),),
                              Positioned(
                                left: 71,
                                top: -10,
                                child:ScaleAnimation(
                                  begin: 0.06,
                                  child:Container(
                                    width: 89,
                                    height: 132,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(plantList[index].plantImage),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),),)

                            ],
                          ),
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class PlantsData {
  final String plantImage;
  final String plantName;
  final String plantCategory;
  final String plantPrice;
  bool isLiked;

  PlantsData(
      {required this.plantImage, required this.plantName, required this.plantCategory, required this.plantPrice})
      :isLiked = false;

  void toggleLike() {
    isLiked = !isLiked;
  }


}