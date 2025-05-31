import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/catalogue/screen/catalogue_page.dart';
import 'features/dashboard/screens/dashboard_page.dart';
import 'features/estimate/print_handler/receipt_ui.dart';
import 'features/estimate/screens/estimate_page.dart';
import 'features/today_rate/screens/today_rate_page.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, // Set default background to white
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          background: Colors.white,
        ),
        // Optional: Override other background-related colors if needed
        canvasColor: Colors.white,
        cardColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      // initialRoute: '/',
      // routes: {
      //   '/todaysRate': (context) => TodayRatePage(),
      //   '/stockEntry': (context) => CataloguePage(),
      //   '/crm': (context) => CataloguePage(),
      //   '/jewelleryCatalogue': (context) => CataloguePage(),
      //   '/purchase': (context) => CataloguePage(),
      //   '/counterChange': (context) => CataloguePage(),
      //   '/pos': (context) => CataloguePage(),
      //   '/customerFeedback': (context) => CataloguePage(),
      //   '/goldScheme': (context) => CataloguePage(),
      //   '/estimate': (context) => EstimatePage(),
      //   '/orders': (context) => CataloguePage(),
      // },
      home: ReceiptUi(),
    );
  }
}
