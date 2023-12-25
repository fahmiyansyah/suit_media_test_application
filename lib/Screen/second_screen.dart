import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suit_media_test_application/Screen/third_screen.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String selected = "Selected User Name";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            size: 20,
          ),
          color: Color(0xFF554AF0),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Second Screen',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Container(
        height: double.maxFinite,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Text(
                      widget.name,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              selected,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _navigateToThirdScreen(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2B637B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  minimumSize: Size(310.0, 41.00)),
              child: Text(
                'Choose a User',
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
    );
  }

  Future<void> _navigateToThirdScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ThirdScreen()),
    );

    if (result != null) {
      setState(() {
        selected = result;
      });
    }
  }
}
