// ignore_for_file: implementation_imports, use_build_context_synchronously

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kudaopenapi/kudaopenapi.dart';
import '../utilities/themeStyles.dart';
import '../widgets/transaction.dart';

class Billings extends StatefulWidget {
  const Billings({super.key});

  @override
  State<Billings> createState() => _BillingsState();
}

class _BillingsState extends State<Billings> {
  List<String> billingtypes = [
    'airtime',
    'betting',
    'internet Data',
    'electricity',
    'cableTv'
  ];

  String? slectedbiller = 'airtime';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.all(16),
      child: Container(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                      bottom: 16.0,
                      top: 22.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Billings', style: ThemeStyles.primaryTitle),
                      ],
                    ),
                  ),
                  TransactionCard(
                    color: Colors.black,
                    letter: 'A',
                    title: 'Airtime',
                    subTitle: 'Loading.....',
                    price: '0.00',
                  ),
                  TransactionCard(
                    color: Colors.black,
                    letter: 'ID',
                    title: 'Internet Data',
                    subTitle: 'Loading.....',
                    price: '0.00',
                  ),
                  TransactionCard(
                    color: Colors.black,
                    letter: 'TV',
                    title: 'Cable TV',
                    subTitle: 'Loading.....',
                    price: '0.00',
                  ),
                  TransactionCard(
                    color: Colors.black,
                    letter: 'E',
                    title: 'Electricity',
                    subTitle: 'Loading.....',
                    price: '0.00',
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
