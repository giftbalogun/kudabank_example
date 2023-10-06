// ignore_for_file: implementation_imports, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:kudaexample/screens/billingdetails.dart';
import '../utilities/themeStyles.dart';

class Billings extends StatefulWidget {
  const Billings({super.key});

  @override
  State<Billings> createState() => _BillingsState();
}

class _BillingsState extends State<Billings> {
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
                  ListView(
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.car_rental),
                        title: const Text('Buy Airtime'),
                        trailing: const Icon(Icons.more_vert),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const BillingsDetail(billingget: 'airtime'),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.flight),
                        title: const Text('Buy Internet Data'),
                        trailing: const Icon(Icons.more_vert),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BillingsDetail(
                                  billingget: 'internet Data'),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.train),
                        title: const Text('Buy Electricity'),
                        trailing: const Icon(Icons.more_vert),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BillingsDetail(
                                  billingget: 'electricity'),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.train),
                        title: const Text('Buy Betting Credit'),
                        trailing: const Icon(Icons.more_vert),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const BillingsDetail(billingget: 'betting'),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.train),
                        title: const Text('Buy TV Subscription'),
                        trailing: const Icon(Icons.more_vert),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const BillingsDetail(billingget: 'cableTv'),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
