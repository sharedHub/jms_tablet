import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar();


  void _handleLogout(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logged out')),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double appBarHeight = height * 0.06;

    return Container(
      height: appBarHeight,
      decoration: const BoxDecoration(
        color: Color(0xFF3C61D7),
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(20),
        //   topRight: Radius.circular(20),
        // ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: appBarHeight * 0.6,
            height: appBarHeight * 0.6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Color(0xFF85A1FA),
                // width: 2.0,
              ),
            ),
            padding: const EdgeInsets.all(2),
            child: ClipOval(
              child: Image.asset(
                'assets/logo/jms_logo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          Expanded(
            child: Center(
              child: Text(
                'MAHESH NOTENDASS (BANDRA)',
                style: TextStyle(
                  color: Color(0XFFEEF2FF),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          GestureDetector(
            onTap: () => _handleLogout(context),
            child: Container(
              width: appBarHeight * 0.6,
              height: appBarHeight * 0.6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color(0xFF7791E6), // Stroke color
                  width: 2,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.power_settings_new,
                  color: Colors.white, // Icon color
                  size: 24, // Adjust size if needed
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
