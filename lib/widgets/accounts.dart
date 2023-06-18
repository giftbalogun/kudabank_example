import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kudaopenapi/kudaopenapi.dart';

import '../utilities/themeColors.dart';
import '../utilities/themeStyles.dart';

class AccountsScreen extends StatefulWidget {
  @override
  _AccountsScreenState createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  String requestRef = Random().nextInt(100000).toString();

  double? accountbalance;

  final currencyFormatter = NumberFormat.currency(locale: 'en_NG', symbol: '₦');

  Future<void> getbalance() async {
    try {
      BankAccount gbalance = await KudaBank().getadminbalance(requestRef);
      setState(() {
        accountbalance = gbalance.data.availableBalance / 100;
      });
    } catch (error) {
      print('Error Loading Account Balance: $error');
    }
  }

  @override
  void initState() {
    getbalance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 32.0, left: 15.0, right: 15.0, bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Acconnts', style: ThemeStyles.primaryTitle),
                Text('See All', style: ThemeStyles.seeAll),
              ],
            ),
          ),
          Container(
            height: 226.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 200,
                width: 340,
                decoration: BoxDecoration(
                  color: ThemeColors.black,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 20.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            accountbalance == null
                                ? Text(currencyFormatter.format(1000),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 24.0))
                                : Text(currencyFormatter.format(accountbalance),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 24.0)),
                            SvgPicture.asset('assets/hide-icon.svg'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 24.0,
                          bottom: 32.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Magent Black',
                                style: ThemeStyles.cardDetails),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 6.0),
                                  child: Text('4756',
                                      style: ThemeStyles.cardDetails),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6.0),
                                  child:
                                      SvgPicture.asset('assets/card-dots.svg'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6.0),
                                  child:
                                      SvgPicture.asset('assets/card-dots.svg'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 6.0),
                                  child: Text('9018',
                                      style: ThemeStyles.cardDetails),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DotIndicator extends StatefulWidget {
  final bool isActive;
  DotIndicator(this.isActive);
  @override
  _DotIndicatorState createState() => _DotIndicatorState();
}

class _DotIndicatorState extends State<DotIndicator> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        height: 8.0,
        width: 8.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: widget.isActive ? ThemeColors.black : ThemeColors.grey,
        ),
      ),
    );
  }
}
