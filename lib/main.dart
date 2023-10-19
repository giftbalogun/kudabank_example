import 'package:flutter/material.dart';
import 'package:kudaopenapi/kudaopenapi.dart';

import 'screens/billings.dart';
import 'screens/dashboard.dart';
import 'package:flutter_svg/svg.dart';

import 'screens/transaction_details.dart';
import 'screens/transaction_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var apikey = '*';
  var email = '*';
  var baseurl = 'https://kuda-openapi.kuda.com/v2.1';

  @override
  void initState() {
    ApiService.initialize(baseurl, email, apikey);
    super.initState();
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      DashboardScreen(),
      TrasnsactionList(),
      Billings(),
      DashboardScreen(),
    ];

    void onTabTapped(index) {
      setState(() {
        selectedIndex = index;
      });
    }

    return Scaffold(
      body: widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0,
        onTap: onTabTapped,
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/home-icon.svg'),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/transactions-icon.svg'),
            label: 'Transaction',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/settings-icon.svg'),
            label: 'Billings',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/smiley-icon.svg'),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
