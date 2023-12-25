import 'package:flutter/material.dart';
import 'package:suit_media_test_application/Screen/second_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController palindromeController = TextEditingController();
  bool isPalindrome = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background 1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 116.0,
                    height: 116.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                  Icon(
                    Icons.person_add_alt_outlined,
                    size: 40.0,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(height: 70),
              Container(
                width: 310.0,
                height: 39.88,
                padding: EdgeInsets.fromLTRB(16, 16, 0, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: Colors.white,
                    width: 0.5,
                  ),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    border: InputBorder.none,
                    hintStyle: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 16.0,
                          color: const Color(0xFF686777).withOpacity(0.36),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(height: 25),
              Container(
                width: 310.0,
                height: 39.88,
                padding: EdgeInsets.fromLTRB(16, 16, 0, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: Colors.white,
                    width: 0.5,
                  ),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: palindromeController,
                  decoration: InputDecoration(
                    hintText: 'Palindrome',
                    border: InputBorder.none,
                    hintStyle: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 16.0,
                          color: const Color(0xFF686777).withOpacity(0.36),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(height: 45),
              ElevatedButton(
                onPressed: () {
                  bool isInputValid = palindromeController.text.isNotEmpty;

                  if (isInputValid) {
                    setState(() {
                      isPalindrome = checkPalindrome(palindromeController.text);
                    });
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Palindrome Checker'),
                        content: Text(
                            isPalindrome ? 'Palindrome' : 'Not Palindrome'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Warning'),
                        content: Text('Please fill in the data first.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2B637B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    minimumSize: Size(310.0, 41.00)),
                child: Text(
                  'CHECK',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      height: 21.0 / 16.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  bool isInputValid = nameController.text.isNotEmpty;

                  if (isInputValid) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondScreen(
                          name: nameController.text,
                        ),
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Warning'),
                        content: Text('Please fill in the data first.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2B637B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    minimumSize: Size(310.0, 41.00)),
                child: Text(
                  'NEXT',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      height: 21.0 / 16.0,
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

  bool checkPalindrome(String text) {
    String cleanText = text.replaceAll(' ', '').toLowerCase();
    String reversedText = cleanText.split('').reversed.join();
    return cleanText == reversedText;
  }
}
