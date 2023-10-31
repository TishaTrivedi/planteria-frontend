import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantbackend/screens/bottomnavigate.dart';
import 'package:plantbackend/screens/checkout.dart';
import 'package:plantbackend/screens/confirmOrder.dart';
import 'package:upi_india/upi_india.dart';

class Payment extends StatefulWidget {
  //const Payment({Key? key}) : super(key: key);
  final int totalBagTotal;
  final int totalShippingCost;
  final int totalItemTotal;

  Payment({
    required this.totalBagTotal,
    required this.totalShippingCost,
    required this.totalItemTotal,
  });
  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Future<UpiResponse>? _transaction;
  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;

  TextStyle header = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  TextStyle value = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  @override
  void initState() {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    super.initState();
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    double amount = widget.totalBagTotal.toDouble();
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: "tishatrivedi115@okicici",
      receiverName: 'Tisha Trivedi',
      transactionRefId: 'TestingUpiIndiaPlugin',
      transactionNote: 'Not actual. Just an example.',
      amount: amount,
    );
  }

  Widget displayUpiApps() {
    if (apps == null)
      return Center(child: CircularProgressIndicator());
    else if (apps!.length == 0)
      return Center(
        child: Text(
          "No apps found to handle transaction.",
          style: header,
        ),
      );
    else
      return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Wrap(
            children: apps!.map<Widget>((UpiApp app) {
              return Container(
                width: 165,
                height: 200,
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.00, -1.00),
                    end: Alignment(0, 1),
                    colors: [
                      Color(0xFF21411C),
                      Color(0xFF50694C),
                      Color(0xFF99A897),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    initiateTransaction(app);
                    //Navigator.push(context,MaterialPageRoute(builder: (context)=>Checkout()));
                  },
                  child: Column(
                    children: [
                      Image.asset("assets/onBoard/gpay.png", height: 150),
                      SizedBox(
                        width: 250,
                        child: Text(
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
              );
            }).toList(),
          ),
        ),
      );
  }

  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException:
        return 'Requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException:
        return 'Requested app cannot handle the transaction';
      default:
        return 'An Unknown error has occurred';
    }
  }

  void _checkTxnStatus(String status) {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        print('Transaction Successful');
        break;
      case UpiPaymentStatus.SUBMITTED:
        print('Transaction Submitted');
        break;
      case UpiPaymentStatus.FAILURE:
        print('Transaction Failed');
        break;
      default:
        print('Received an Unknown transaction status');
    }
  }

  Widget displayTransactionData(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title: ", style: header),
          Flexible(
              child: Text(
            body,
            style: value,
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int bagTotal = widget.totalBagTotal;
    int shippingCost = widget.totalShippingCost;
    int itemTotal = widget.totalItemTotal;

    return Container(
      child: Scaffold(
        backgroundColor: Colors.lightGreen.shade50,
        appBar: AppBar(
          backgroundColor: Color(0xFF3C593B),
          title: Text(
            "Payment Method",
            style: GoogleFonts.lora(
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
              onPressed: () {
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
                top: 62,
                child: Container(
                  width: 165,
                  height: 200,
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: [
                        Color(0xFF21411C),
                        Color(0xFF50694C),
                        Color(0xFF99A897),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(

                          content: Container(
                            height: 300,
                            width: 100,
                            child: Column(
                            children: [
                              Image.asset("assets/cnf.png"),
                              Text("Order confirmed",
                                style: GoogleFonts.acme(
                                  color: Colors.black,
                                  fontSize: 20,
                                  //fontFamily: 'Playfair Display',
                                  fontWeight: FontWeight.w400,
                                ),),
                              TextButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));
                              },
                                  child: Text("OK"))
                            ],)
                          ),
                          
                          
                        )
                      );
                    },
                    child: Column(
                      children: [
                        Image.asset("assets/onBoard/cod.png", height: 150),
                        SizedBox(
                          width: 250,
                          child: Text(
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
                  left: 189,
                  top: 62,
                  child: SizedBox(
                    width: 165,
                    height: 500,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: displayUpiApps(),
                        ),
                        Expanded(
                          child: FutureBuilder(
                            future: _transaction,
                            builder: (BuildContext context,
                                AsyncSnapshot<UpiResponse> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text(
                                      _upiErrorHandler(
                                          snapshot.error.runtimeType),
                                      style: header,
                                    ), // Print's text message on screen
                                  );
                                }

                                // If we have data then definitely we will have UpiResponse.
                                // It cannot be null
                                UpiResponse _upiResponse = snapshot.data!;

                                // Data in UpiResponse can be null. Check before printing
                                String txnId =
                                    _upiResponse.transactionId ?? 'N/A';
                                String resCode =
                                    _upiResponse.responseCode ?? 'N/A';
                                String txnRef =
                                    _upiResponse.transactionRefId ?? 'N/A';
                                String status = _upiResponse.status ?? 'N/A';
                                String approvalRef =
                                    _upiResponse.approvalRefNo ?? 'N/A';
                                _checkTxnStatus(status);

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      displayTransactionData(
                                          'Transaction Id', txnId),
                                      displayTransactionData(
                                          'Response Code', resCode),
                                      displayTransactionData(
                                          'Reference Id', txnRef),
                                      displayTransactionData(
                                          'Status', status.toUpperCase()),
                                      displayTransactionData(
                                          'Approval No', approvalRef),
                                    ],
                                  ),
                                );
                              } else
                                return Center(
                                  child: Text(''),
                                );
                            },
                          ),
                        )
                      ],
                    ),
                  )
                  // Container(
                  //   width: 165,
                  //   height: 200,
                  //   decoration: ShapeDecoration(
                  //     gradient: LinearGradient(
                  //       begin: Alignment(0.00, -1.00),
                  //       end: Alignment(0, 1),
                  //       colors: [Color(0xFF21411C), Color(0xFF50694C),Color(0xFF99A897),],
                  //     ),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(24),
                  //     ),
                  //   ),
                  //   child: ElevatedButton(
                  //     onPressed: (){
                  //       displayUpiApps();
                  //       //Navigator.push(context,MaterialPageRoute(builder: (context)=>Checkout()));
                  //     },
                  //     child: Column(
                  //       children: [
                  //         Image.asset("assets/onBoard/gpay.png",
                  //             height: 150),
                  //         SizedBox(
                  //           width: 250,
                  //
                  //           child:  Text(
                  //             'Pay Online',
                  //             textAlign: TextAlign.center,
                  //             style: GoogleFonts.playfairDisplay(
                  //               color: Colors.white,
                  //               fontSize: 16,
                  //               //fontFamily: 'Playfair Display',
                  //               fontWeight: FontWeight.w900,
                  //             ),
                  //           ),
                  //         ),
                  //
                  //       ],
                  //     ),
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Colors.transparent,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(24),
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
                    '₹' + itemTotal.toString(),
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
                    '₹' + shippingCost.toString(),
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
                    '₹' + bagTotal.toString(),
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
            ],
          ),
        ),
      ),
    );
  }
}
