import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kudaopenapi/kudaopenapi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var apikey = '';
  var email = '@GMAIL.COM';
  var baseurl = 'https://kuda-openapi.kuda.com/v2.1';

  @override
  void initState() {
    ApiService.initialize(baseurl, email, apikey);
    super.initState();
    _fetchBillers();
  }

  String? selectedBiller;
  List<Biller> billers = [];
  List<BillItem> billItems = [];

  void _fetchBillers() async {
    Map<String, dynamic> billingtype = {'BillTypeName': 'betting'};

    BillingResponse airtimeres =
        await KudaBilling().GET_BILLERS_BY_TYPE(billingtype, '9999999');

    // String jsonString = await DefaultAssetBundle.of(context)
    //     .loadString('assets/data/billing_response.json');

    // BillingResponse billingResponse = billingResponseFromJson(jsonString);
    billers = airtimeres.data.billers;
    setState(() {});
  }

  void _onBillerSelected(String? billerId) {
    selectedBiller = billerId;
    billItems.clear();
    for (Biller biller in billers) {
      if (biller.id == selectedBiller) {
        billItems.addAll(biller.billItems);
      }
    }
    setState(() {});
  }

  // Widget _buildBillItemsDropdown() {
  //   return DropdownButton<String>(
  //     value: billItems[0].kudaIdentifier,
  //     onChanged: (String? billItem) {
  //       // Do something when the billItem is selected.
  //     },
  //     items: billItems.map<DropdownMenuItem<String>>((BillItem billItem) {
  //       return DropdownMenuItem<String>(
  //         value: billItem.kudaIdentifier.toString(),
  //         child: Text(billItem.name.toString()),
  //       );
  //     }).toList(),

  //     // items: billItems
  //     //     .map((billItem) => DropdownMenuItem(
  //     //         value: billItem, child: Text(billItem.name ?? 'jj')))
  //     //     .toList(),
  //   );
  // }

  Widget _buildBillItemsDropdown() {
    return DropdownButton<BillItem>(
      value: null,
      onChanged: (BillItem? billItem) {
        // Do something when the billItem is selected.
      },
      items: billItems
          .map((billItem) => DropdownMenuItem(
              value: billItem, child: Text(billItem.name ?? '')))
          .toList(),
      isExpanded: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Get BillersItem'),
        ),
        body: Column(
          children: [
            DropdownButton<String>(
              value: selectedBiller,
              onChanged: _onBillerSelected,
              items: billers
                  .map((biller) => DropdownMenuItem(
                      value: biller.id, child: Text(biller.name ?? 'ssss')))
                  .toList(),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: billItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(billItems[index].name ?? 'ss'),
                  subtitle: Text('Amount: ${billItems[index].amount}'),
                );
              },
            ),
            _buildBillItemsDropdown(),
          ],
        ),
      ),
    );
  }
}
