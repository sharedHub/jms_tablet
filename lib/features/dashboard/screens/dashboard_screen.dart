import 'package:flutter/material.dart';
import '../../../shared/widgets/app_bar.dart';
import '../widgets/icon_grid.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFF3F8FF),
                    Color(0xFFD5E5FB),
                  ],
                ),
                border: Border.all(
                  color: Color(0xFFB4C4D9),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/notendas_logo.png',
                    fit: BoxFit.cover,
                  ),

                  SizedBox(height: 20),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.04,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xFFC7D7EF),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.search,
                            color: Color(0xFFC7D7EF),
                            size: 20,
                          ),
                        ),

                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search for quick result..',
                              hintStyle: TextStyle(color: Color(0xFFC7D7EF)),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 38, left: 8, right: 8, bottom: 8),
              child: Center(
                child: Text("Daily Operations, at your FingerTips...", style: TextStyle(color: Colors.black),),
              ),
            ),
            Expanded(child: IconGrid()),
          ]
        ),
      ),
    );
  }
}
