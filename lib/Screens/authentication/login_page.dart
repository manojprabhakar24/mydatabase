import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import '../confirmation/confirmation_screen.dart';

class Service {
  final String name;
  final double price;

  Service({
    required this.name,
    required this.price,
    // Other properties of the Service class can be added here
  });
}

class LoginPage extends StatefulWidget {
  static const String countryCode = '+91';
  final DateTime selectedDate;
  final List<String> selectedTimeSlots;
  final List<Service> selectedServices;

  const LoginPage({
    Key? key,
    required this.selectedDate,
    required this.selectedTimeSlots,
    required this.selectedServices,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String errorMessage = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController =
  TextEditingController(text:  LoginPage.countryCode);
  final TextEditingController otpController = TextEditingController();
  TwilioFlutter twilioFlutter = TwilioFlutter(
    accountSid: 'AC45d39b3d898206fef90d4ed67fb4a7bc',
    authToken: '12e9130843dedf996dda766ec0c5191b',
    twilioNumber: '+12816168209',
  );

  String generatedOTP = '';

  String generateOTP() {
    int otpLength = 6;
    String otp = '';
    for (int i = 0; i < otpLength; i++) {
      otp += Random().nextInt(9).toString();
    }
    return otp;
  }

  void sendOTP() {
    String name = nameController.text.trim();
    String phoneNumber = phoneNumberController.text.trim();
    generatedOTP = generateOTP(); // Save the generated OTP

    try {
      twilioFlutter.sendSMS(
        toNumber: phoneNumber,
        messageBody: 'Hi $name, your OTP for verification is: $generatedOTP',
      );
      print('OTP sent successfully!');

      // Show OTP verification dialog after sending OTP
      showOTPDialog();
    } catch (e) {
      print('Failed to send OTP: $e');
    }
  }

  void verifyOTPInDialog() {
    String enteredOTP = otpController.text.trim();
    if (enteredOTP == generatedOTP) {
      String enteredName = nameController.text.trim();
      String enteredPhoneNumber = phoneNumberController.text.trim();
      String bookingMessage =
          'Hi $enteredName, your booking has been confirmed for ${widget.selectedDate}.${widget.selectedTimeSlots}.${widget.selectedServices}';
      sendBookingMessage(enteredPhoneNumber, bookingMessage);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmationScreen(
            name: enteredName,
            phoneNumber: enteredPhoneNumber,
            selectedDate: widget.selectedDate,
            selectedTimeSlots: widget.selectedTimeSlots,
          ),
        ),
      );
    } else {
      setState(() {
        // Update UI to display incorrect OTP message
        errorMessage = 'Incorrect OTP!';
      });
      print('Incorrect OTP!');
    }
  }

  void sendBookingMessage(String phoneNumber, String message) {
    try {
      twilioFlutter.sendSMS(
        toNumber: phoneNumber,
        messageBody: message,
      );
      print('Booking message sent successfully!');
    } catch (e) {
      print('Failed to send booking message: $e');
    }
  }

  void showOTPDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter OTP'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                cursorColor: Colors.brown,
                cursorWidth: 2.0,
                cursorHeight: 18.0,
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter OTP',
                  labelStyle: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      color: Colors.brown,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.brown, width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.brown, width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(150, 50),
                  primary: Colors.brown[900],

                ),
                onPressed: verifyOTPInDialog,
                child: Text('Verify',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              if (errorMessage.isNotEmpty) // Show error message if not empty
                Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    otpController.dispose();
    super.dispose();
  }
  void _saveData() {
    String text1 = nameController.text;
    String text2 = phoneNumberController.text;

    Timestamp timestamp = Timestamp.fromDate(widget.selectedDate);

    // Create a reference to the merged collection
    CollectionReference combinedCollection =
    FirebaseFirestore.instance.collection('combinedData');

    // Access widget.selectedServices here
    combinedCollection.add({
      'name': text1,
      'phoneNumber': text2,
      'selectedDate': timestamp,
      'selectedTimeSlots': widget.selectedTimeSlots,
      'services': widget.selectedServices.map((service) => {
        'serviceName': service.name,
        'servicePrice': service.price,
        // Add other properties of the service here
      }).toList(),
    }).then((value) {
      print("Data saved successfully!");
    }).catchError((error) {
      print("Failed to save data: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.8),
            ),
            child: Column(
              children: [
                Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(5, 10, 10, 0)),
                    Image.asset(
                      'assets/Scissors-image-remove.png',
                      width: 100,
                      height: 100,
                    ),
                  ],
                ),
                Row(children: [
                  Padding(padding: EdgeInsets.symmetric(horizontal: 17.0)),
                  Text(
                    "Scissor's",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ]),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Enter Your Details",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 430,
                      maxHeight: 300,
                    ),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextFormField(
                                cursorColor: Colors.brown,
                                cursorWidth: 2.0,
                                cursorHeight: 18.0,
                                controller: nameController,
                                decoration: InputDecoration(
                                  labelText: 'Enter Name',
                                  labelStyle: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        color: Colors.brown[900],
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.brown, width: 1.0),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.brown, width: 1.0),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      cursorColor: Colors.brown,
                                      cursorWidth: 2.0,
                                      cursorHeight: 18.0,
                                      controller: phoneNumberController,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        labelText: 'Enter Phone Number',

                                        labelStyle: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              color: Colors.brown[900],
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.brown, width: 1.0),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.brown, width: 1.0),
                                          borderRadius: BorderRadius.circular(8),
                                        ),

                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a phone number';
                                        } else if (!value.startsWith('+91')) {
                                          return 'Please enter a valid Indian phone number';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(150, 50),
                                      primary: Colors.brown[900],

                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!
                                          .validate()) {

                                        sendOTP();
                                        _saveData();
                                      }
                                    },
                                    child: Text('Send OTP',
                                      style: TextStyle(color: Colors.white),

                                    ),

                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }
}