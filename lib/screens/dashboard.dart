// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kudaexample/widgets/accounts.dart';

import '../widgets/recent_transaction.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 15.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: SvgPicture.asset('assets/analytics-icon.svg'),
                        onPressed: null,
                      ),
                      IconButton(
                        icon: SvgPicture.asset('assets/search-icon.svg'),
                        onPressed: null,
                      ),
                      IconButton(
                        icon: SvgPicture.asset('assets/more-icon.svg'),
                        onPressed: null,
                      )
                    ],
                  )
                ],
              ),
            ),
            AccountsScreen(),
            RecentTransactions(),
          ],
        ),
      ),
    );
  }
}
