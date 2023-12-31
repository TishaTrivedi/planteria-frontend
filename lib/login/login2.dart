import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql/client.dart';
import 'package:plantbackend/graphql_client.dart';
import 'package:plantbackend/login/registration.dart';

import 'package:plantbackend/graphql_client.dart';
import 'package:plantbackend/screens/bottomnavigate.dart';

import '../sharedPreferences.dart';

class Login2 extends StatefulWidget {
  const Login2({Key? key}) : super(key: key);

  // static int userId = 0;

  @override
  State<Login2> createState() => _Login2State();
}

class _Login2State extends State<Login2> {
  final _formKey = GlobalKey<FormState>();

  static Future<int> _getUsersCountByMobileNumber(String mobileNumber) async {
    print("getUsersCountByMobileNumber");

    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        cache: GraphQLCache(),
        link: httpLink,
      ),
    );

    final String getUsersCountQuery = '''
    query GetUsersCount(\$mobileNumber: String!) {
      displayUserByMobileNumber(mobileNumber: \$mobileNumber) {
        id
      }
    }
  ''';

    final QueryOptions options = QueryOptions(
      document: gql(getUsersCountQuery),
      variables: {'mobileNumber': mobileNumber},
    );

    try {
      final QueryResult result = await client.value.query(options);

      if (result.hasException) {
        throw result.exception!;
      }

      final dynamic user = result.data?['displayUserByMobileNumber'];
      if (user == null) {
        return 0; // User not found
      } else if (user is List<dynamic>) {
        return user.length; // Return the count of users
      } else {
        return 1; // Single user found
      }
    } catch (error) {
      throw error;
    }
  }

  static Future<int> _getUsersCountByMobileNumberAndPassword(String mobileNumber, String password) async {
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        cache: GraphQLCache(),
        link: httpLink,
      ),
    );

    final String getUsersCountQuery = '''
    query GetUsersCount(\$mobileNumber: String!, \$password: String!) {
      countUsersByMobileAndPassword(mobileNumber: \$mobileNumber, password: \$password)
    }
  ''';

    final QueryOptions options = QueryOptions(
      document: gql(getUsersCountQuery),
      variables: {'mobileNumber': mobileNumber, 'password': password},
    );

    try {
      final QueryResult result = await client.value.query(options);

      if (result.hasException) {
        throw result.exception!;
      }

      final int userCount = result.data?['countUsersByMobileAndPassword'] ?? 0;
      return userCount;
    } catch (error) {
      throw error;
    }
  }

  Future<void> _storeUserId(int userId) async {
    try {
      // Use your shared preferences utility to store the user ID
      await SharedPreferencesUtil.setInt('userId', userId);
      print('User ID stored successfully: $userId');
    } catch (error) {
      // Handle any errors that might occur during storage
      print('Error storing user ID: $error');
    }
  }

  Future<int> _getUserId(String mobileNumber, String password) async {

    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        cache: GraphQLCache(),
        link: httpLink,
      ),
    );

    final String getUsersCountQuery = '''
      query(\$mobileNumber: String!, \$password: String!) {
        displayUserByMobileNumberAndPassword(mobileNumber: \$mobileNumber, password: \$password) {
          id
          username
          password
        }
      }
    ''';

    final QueryOptions options = QueryOptions(
      document: gql(getUsersCountQuery),
      variables: {'mobileNumber': mobileNumber, 'password': password},
    );

    try {
      final QueryResult result = await client.value.query(options);

      if (result.hasException) {
        throw result.exception!;
      }

      final dynamic user = result.data?['displayUserByMobileNumberAndPassword'];
      UserFormFields.userPassword = user['password'];
      if (user == null) {
        return 0; // User not found
      } else if (user is List<dynamic>) {
        final int userId = user.isNotEmpty ? int.parse(user[0]['id']) : 0;
        return userId; // Return the user ID
      } else {
        final int userId = int.parse(user['id']);
        return userId; // Single user found
      }
    } catch (error) {
      throw error;
    }
  }

  bool _isSelectedTextBox = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();

  var mobileNumber;
  void _createUser(BuildContext context) async {
    print("In Create User");
    SharedPreferencesUtil.setString(
        'mobileNumber', UserFormFields.userMobileNumber.toString());
    final userId = await _getUserId(UserFormFields.userMobileNumber.toString(),UserFormFields.userPassword);
    print('User ID: $userId');
    print(UserFormFields.userName);
    print(UserFormFields.userPassword);
    print(UserFormFields.userMobileNumber);

    final String createUserMutation = '''
    mutation CreateCustomer(\$username: String!, \$password: String!, \$mobileNumber: String!) {
      createCustomer(username: \$username, password: \$password, mobileNumber: \$mobileNumber) {
        customer {
          id
          username
          password
          mobileNumber
        }
      }
    }
  ''';

    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink, // Replace with your GraphQL API endpoint
    );

    final Map<String, dynamic> variables = {
      'username': UserFormFields.userName.toString(),
      'password': UserFormFields.userPassword.toString(),
      'mobileNumber': UserFormFields.userMobileNumber.toString(),
    };

    try {
      final QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(createUserMutation),
          variables: variables,
        ),
      );

      if (result.hasException) {
        // Handle error here
        print("Mutation error: ${result.exception}");

        // Check if it's an HttpException
        if (result.exception is HttpLinkServerException) {
          final HttpLinkServerException httpException =
          result.exception as HttpLinkServerException;
          final response = httpException.response;
          print("Response Status Code: ${response?.statusCode}");
          print("Response Body: ${response?.body}");
        }
      } else {
        // Mutation was successful, you can access data here if needed
        print('User Created');

        // After creating the user, get the userId
        final userId = await _getUserId(UserFormFields.userMobileNumber.toString(),UserFormFields.userPassword);
        print('User ID: $userId'); // Print the user ID

        // Check if userId is not 0 (meaning a valid user was found)
        if (userId != 0) {
          // Store the userId using shared preferences
          await _storeUserId(userId);

          // Store it in a static variable
          // Login2.userId = userId;

          // You can also set the login state here if needed
          await SharedPreferencesUtil.setLoginState(true);

          print('User ID stored: $userId');
        } else {
          print('User not found'); // Handle this case appropriately
        }
      }
    } catch (error) {
      print("An error occurred: $error");
    }
  }
  // Future<int> _getUserId() async {
  //   final GraphQLClient client = GraphQLClient(
  //     cache: GraphQLCache(),
  //     link: httpLink, // Replace with your GraphQL HTTP link
  //   );
  //
  //   final String getUserQuery = '''
  //   query CustomerLoginByMobile(\$mobileNumber: String!) {
  //     customerLoginByMobile(mobileNumber: \$mobileNumber) {
  //       id
  //     }
  //   }
  // ''';
  //
  //   print('UserMobileNumber: ${UserFormFields.userMobileNumber.toString()}');
  //   final QueryOptions options = QueryOptions(
  //     document: gql(getUserQuery),
  //     variables: {'mobileNumber': UserFormFields.userMobileNumber.toString()}, // Use UserFormFields.userMobileNumber
  //   );
  //
  //   try {
  //     final QueryResult result = await client.query(options);
  //
  //     if (result.hasException) {
  //       throw result.exception!;
  //     }
  //
  //     final dynamic user = result.data?['customerLoginByMobile'];
  //     if (user == null) {
  //
  //       print("USer not foundddd\n\n\n\n\n\n\n\n\n");
  //       return 0;// User not found
  //     } else {
  //       final int userId = int.parse(user['id']);
  //       print("$userId\n\n\n\n\n\n\n\n\n");
  //
  //       return userId; // User found
  //     }
  //   } catch (error) {
  //     throw error;
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.lightGreen.shade50,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        leading: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            padding: const EdgeInsets.all(0),
          ),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SizedBox(
        height: height,
        child: Padding(
            padding:
            const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Padding(
                      padding: EdgeInsets.only(
                          left: 70, right: 0, top: 0, bottom: 30),
                      child: Text(
                        "Create Profile",
                        style: GoogleFonts.playfairDisplay(
                            fontSize: 26,
                            color: Color(0xFF50694C),
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // TextField(
                    //   controller: _usernameController, // Assign the controller
                    //   onTap: () {
                    //     _isSelectedTextBox = true;
                    //   },
                    //   onChanged: (value) {
                    //     setState(() {
                    //       UserFormFields.userName = value;
                    //     });
                    //   },
                    //   keyboardType: TextInputType.text,
                    //   style: const TextStyle(
                    //     color: Colors.black,
                    //   ),
                    //   decoration: InputDecoration(
                    //     labelText: 'Username',
                    //     labelStyle: const TextStyle(
                    //       color: Colors.black,
                    //     ),
                    //     border: OutlineInputBorder(
                    //       borderSide: const BorderSide(
                    //         color: Colors.black,
                    //       ),
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide: const BorderSide(
                    //         color: Colors.black,
                    //       ),
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 0, right: 0, top: 0, bottom: 30),
                      child: TextFormField(
                        controller: _usernameController,
                        onTap: () {
                          _isSelectedTextBox = true;
                        },
                        onChanged: (value) {
                          setState(() {
                            UserFormFields.userName = value;
                          });
                        },
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        // Validation logic for the username
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username is required';
                          } else if (value.length <4) {
                            return 'Username must be at least 4 characters';
                          }
                          return null; // No validation error
                        },
                      ),
                    ),

                    // Padding(
                    //   padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 30),
                    //   child: TextFormField(
                    //     controller: _passwordController, // Assign the controller
                    //     onTap: () {
                    //       _isSelectedTextBox = true;
                    //     },
                    //     onChanged: (value) {
                    //       setState(() {
                    //         UserFormFields.password = value;
                    //       });
                    //     },
                    //     keyboardType: TextInputType.text,
                    //     style: const TextStyle(
                    //       color: Colors.black,
                    //     ),
                    //     decoration: InputDecoration(
                    //       labelText: 'Password',
                    //       labelStyle: const TextStyle(
                    //         color: Colors.black,
                    //       ),
                    //       border: OutlineInputBorder(
                    //         borderSide: const BorderSide(
                    //           color: Colors.black,
                    //         ),
                    //         borderRadius: BorderRadius.circular(15),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: const BorderSide(
                    //           color: Colors.black,
                    //         ),
                    //         borderRadius: BorderRadius.circular(15),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    Padding(
                      padding:
                      EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
                      child: TextFormField(
                        controller: _passwordController,
                        onTap: () {
                          _isSelectedTextBox = true;
                        },
                        onChanged: (value) {
                          setState(() {
                            UserFormFields.userPassword = value;
                          });
                        },
                        keyboardType: TextInputType.text,
                        obscureText: true, // Hide the password characters
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        // Validation logic for the password
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          } else if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          return null; // No validation error
                        },
                      ),
                    ),
                     Padding(
                      padding: EdgeInsets.only(
                          left: 0, right: 0, top: 0, bottom: 30),
                      child: Text(
                        "Must be at least eight characters",
                        style: GoogleFonts.playfairDisplay(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w100),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    // Padding(
                    //   padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 30),
                    //   child: TextFormField(
                    //     controller: _mobileNumberController, // Assign the controller
                    //     onTap: () {
                    //       _isSelectedTextBox = true;
                    //     },
                    //     onChanged: (value) {
                    //       setState(() {
                    //         UserFormFields.userMobileNumber = value;
                    //       });
                    //     },
                    //     keyboardType: TextInputType.number,
                    //     style: const TextStyle(
                    //       color: Colors.black,
                    //     ),
                    //     decoration: InputDecoration(
                    //       labelText: 'Mobile Number',
                    //       labelStyle: const TextStyle(
                    //         color: Colors.black,
                    //       ),
                    //       border: OutlineInputBorder(
                    //         borderSide: const BorderSide(
                    //           color: Colors.black,
                    //         ),
                    //         borderRadius: BorderRadius.circular(15),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: const BorderSide(
                    //           color: Colors.black,
                    //         ),
                    //         borderRadius: BorderRadius.circular(15),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    Padding(
                      padding:
                      EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
                      child: TextFormField(
                        controller: _mobileNumberController,
                        onTap: () {
                          _isSelectedTextBox = true;
                        },
                        onChanged: (value) {
                          setState(() {
                            UserFormFields.userMobileNumber = value;
                          });
                        },
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Mobile Number',
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        // Validation logic for the mobile number
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Mobile number is required';
                          } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                            return 'Mobile number must be 10 digits';
                          }
                          return null; // No validation error
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 0, right: 0, top: 0, bottom: 30),
                      child: Text(
                        "Enter ten digit mobile number",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: "Georgia",
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, top: 50, bottom: 20),
                      child: SizedBox(
                        height: 45,
                        width: width,
                        child: ElevatedButton(
                          onPressed:() async {
                          print(UserFormFields.userMobileNumber);
                          print(UserFormFields.userPassword);

                          int userCountMobile = await _getUsersCountByMobileNumber(UserFormFields.userMobileNumber.toString());
                          print("Number of users $userCountMobile");

                          if (userCountMobile == 1) {
                          int userCountPassword = await _getUsersCountByMobileNumberAndPassword(UserFormFields.userMobileNumber.toString(), UserFormFields.userPassword);
                          print("Number of users $userCountPassword");

                          if (userCountPassword == 1) {
                          int userId = await _getUserId(UserFormFields.userMobileNumber.toString(),UserFormFields.userPassword);
                          setState(() {
                          UserFormFields.userId = userId;
                          });
                          print("User ID ${UserFormFields.userId}\n\n\n\n\n\n\n\n");

                          await SharedPreferencesUtil.setLoginState(true);
                          await _storeUserId(UserFormFields.userId);

                          Navigator.pushReplacementNamed(context, 'bottomnavigation');
                          } else {
                          showDialog(
                          context: context,
                          builder: (BuildContext context) {
                          return AlertDialog(
                          title: const Text('Alert'),
                          content: const Text('User with mobile Number already Exist Check your password.'),
                          actions: [
                          TextButton(
                          onPressed: () {
                          // Close the dialog when the "OK" button is pressed.
                          Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                          ),
                          ],
                          );
                          },
                          );
                          }
                          }
                            else if (_formKey.currentState!.validate()) {
                              // If the form is valid, execute your logic
                              _createUser(context);

                              await SharedPreferencesUtil.setLoginState(true);
                              print("User has been created\n\n\n\n\n\n\n\n");
                              final updateduserId = await _getUserId(UserFormFields.userMobileNumber.toString(),UserFormFields.userPassword);
                              //var updatedUserId =await _storeUserId(userId);
                              setState(() {
                                UserFormFields.userId=updateduserId;
                              });
                              print('User ID: $updateduserId');

                              print(UserFormFields.userMobileNumber);
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));
                            }
                            else {
                              print("Alert");
                              showAlertDialog(
                                  context, 'Please fill in all fields.');
                            }
                          }
                          //     () async {
                          //   print('clicked \n\n\n\n\n\n');
                          //   if (_formKey.currentState!.validate()) {
                          //     // If the form is valid, execute your logic
                          //     _createUser(context);
                          //
                          //     await SharedPreferencesUtil.setLoginState(true);
                          //     print("User has been created\n\n\n\n\n\n\n\n");
                          //     final updateduserId = await _getUserId();
                          //     //var updatedUserId =await _storeUserId(userId);
                          //     setState(() {
                          //       UserFormFields.userId=updateduserId;
                          //     });
                          //     print('User ID: $updateduserId');
                          //
                          //     print(UserFormFields.userMobileNumber);
                          //     Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));
                          //   } else {
                          //     print("Alert");
                          //     showAlertDialog(
                          //         context, 'Please fill in all fields.');
                          //   }
                          //
                          //   // _createUser(context);
                          //   //
                          //   // // int userId = await _getUserId();
                          //   // // print("User Id on call " + userId.toString());
                          //   // // setState(() {
                          //   // //   Login2.userId = userId;
                          //   // // });
                          //   // //
                          //   // // print(Login2.userId);
                          //   // //
                          //   // // await _storeUserId(userId);
                          //   // // await SharedPreferencesUtil.setBool('isLoggedIn', true);
                          //   // await SharedPreferencesUtil.setLoginState(true);
                          //   //
                          //   // print("User has been created\n\n\n\n\n\n\n\n");
                          //   // print(UserFormFields.userMobileNumber);
                          //   // Navigator.pushNamed(context, 'bottomnavigation');
                          // },

                          ,style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF50694C),
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: const BorderSide(
                                color: Color(0xFF2F482D),
                              ),
                            ),
                          ),
                          child: Text(
                            'Login',
                            style: GoogleFonts.playfairDisplay(
                                fontSize: 26,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  void showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter appropriate details'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}