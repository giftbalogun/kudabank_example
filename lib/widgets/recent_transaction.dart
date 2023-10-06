import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kudaopenapi/kudaopenapi.dart';

import '../utilities/themeStyles.dart';
import 'transaction.dart';

class RecentTransactions extends StatefulWidget {
  @override
  _RecentTransactionsState createState() => _RecentTransactionsState();
}

class _RecentTransactionsState extends State<RecentTransactions> {
  @override
  Map<String, dynamic> tdata = {
    'PageSize': "8",
    'PageNumber': "1",
  };
  String requestRef = Random().nextInt(100000).toString();
  final currencyFormatter = NumberFormat.currency(locale: 'en_NG', symbol: '₦');

  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              bottom: 16.0,
              top: 32.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Transactions', style: ThemeStyles.primaryTitle),
                Text('See All', style: ThemeStyles.seeAll),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: FutureBuilder<KudaTransactionlog>(
              future:
                  KudaBank().admin_main_account_transaction(tdata, requestRef),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.data.postingsHistory.length,
                    itemBuilder: (context, index) {
                      final transaction =
                          snapshot.data!.data.postingsHistory[index];
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(transaction.realDate);
                      return TransactionCard(
                        color: Colors.amberAccent,
                        letter: 'E',
                        title: transaction.beneficiaryName ?? 'Gift Balogun',
                        subTitle: formattedDate,
                        price: currencyFormatter.format(
                            (transaction.amount / 100) - transaction.charge),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return TransactionCard(
                  color: Colors.black,
                  letter: 'L',
                  title: 'Loading',
                  subTitle: 'Loading.....',
                  price: '0.00',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
