// ignore_for_file: avoid_unnecessary_containers, use_build_context_synchronously

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kudaopenapi/kudaopenapi.dart';

import '../utilities/themeStyles.dart';

class BillingsDetail extends StatefulWidget {
  final String billingget;
  const BillingsDetail({super.key, required this.billingget});

  @override
  State<BillingsDetail> createState() => _BillingsDetailState();
}

class _BillingsDetailState extends State<BillingsDetail> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late TextEditingController _numberController;
  late TextEditingController _amountController;

  String? selectairtimebiller;
  String? subbiller;
  String? customername;
  List<Biller> airtimelist = [];
  List<BillItem> subbillerlist = [];

  String? selectedBiller;
  List<Biller> billers = [];
  List<BillItem> billItems = [];

  void _fetchBillers() async {
    Map<String, dynamic> billingtype = {'BillTypeName': widget.billingget};

    BillingResponse airtimeres =
        await KudaBilling().GET_BILLERS_BY_TYPE(billingtype, '9999999');
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

  String requestRef = Random().nextInt(100000).toString();

  @override
  void initState() {
    super.initState();
    _fetchBillers();
    _numberController = TextEditingController();
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    _numberController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> verifybiller(String accountNumber) async {
    try {
      String requestRef = Random().nextInt(100000).toString();
      Map<String, dynamic> verifydata = {
        'KudaBillItemIdentifier': subbiller,
        'CustomerIdentification': accountNumber,
      };

      print(verifydata);
      VerifyBillingResponse response =
          await KudaBilling().VERIFY_BILL_CUSTOMER(verifydata, requestRef);

      print(response);
      print("Request Reference $requestRef");

      setState(() {
        customername = response.data.customerName;
      });
    } catch (error) {
      print('Error fetching account name: $error');
    }
  }

  Future<void> performMoneyTransfer(BuildContext context) async {
    try {
      String phonenumber = _numberController.text;
      String? bankCode = selectairtimebiller;
      int j = int.parse(_amountController.text) * 100;
      String t = "$j";

      Map<String, dynamic> purchasedata = {
        "Amount": t,
        "BillItemIdentifier": bankCode,
        "PhoneNumber": phonenumber,
        "CustomerIdentifier": phonenumber
      };

      print(purchasedata);

      print("Request Reference $requestRef");

      PurcahseBillingResponse response =
          await KudaBilling().ADMIN_PURCHASE_BILL(purchasedata, requestRef);

      print("Status Code");
      print(response.status);

      // Check the response for success
      if (response.status == true) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Airtime Purchase'),
            content: const Text('Successful!'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Airtime Purchase'),
            content: const Text('Transfer failed!'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Money Transfer'),
          content: Text('Purchase failed: ${error.toString()}'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.billingget),
          ),
          body: Container(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                          bottom: 10.0,
                          top: 10.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Billings', style: ThemeStyles.primaryTitle),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      _buildTransferForm(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

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

  Widget _buildTransferForm() {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DropdownButton<String>(
              hint: const Text('Select Network'),
              // onChanged: (String? newValue) {
              //   setState(() {
              //     selectairtimebiller = newValue;
              //   });
              // },

              value: selectedBiller,
              onChanged: _onBillerSelected,
              items: billers.map<DropdownMenuItem<String>>((biller) {
                return DropdownMenuItem<String>(
                  value: biller.id.toString(),
                  child: Text(biller.name.toString()),
                );
              }).toList(),
            ),

            // DropdownButton<String>(
            //   value: selectedBiller,
            //   onChanged: _onBillerSelected,
            //   items: billers
            //       .map((biller) => DropdownMenuItem(
            //           value: biller.id, child: Text(biller.name ?? 'ssss')))
            //       .toList(),
            // ),

            const SizedBox(height: 4),
            Text(
              'Selected Network: $selectedBiller',
              style: const TextStyle(color: Colors.green, fontSize: 15),
            ),
            const SizedBox(height: 4),
            //_buildBillItemsDropdown(),

            DropdownButton<String>(
              value: subbiller,
              hint: const Text('Select Sub-Network'),
              onChanged: (String? newValue) {
                setState(() {
                  subbiller = newValue;
                });
              },
              items:
                  billItems.map<DropdownMenuItem<String>>((BillItem billItem) {
                return DropdownMenuItem<String>(
                  value: billItem.kudaIdentifier.toString(),
                  child: Text(billItem.name.toString()),
                );
              }).toList(),
            ),
            const SizedBox(height: 3),
            Text(
              'Selected Network: $subbiller',
              style: const TextStyle(color: Colors.green, fontSize: 15),
            ),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Mobile Number.',
                filled: true,
                isDense: true,
              ),
              controller: _numberController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (value.length == 10) {
                  verifybiller(value);
                } else {
                  setState(() {
                    customername = null;
                  });
                }
              },
              autocorrect: false,
            ),
            const SizedBox(height: 33),
            Text(
              'Account Name: ${customername ?? 'N/A'}',
              style: const TextStyle(color: Colors.green, fontSize: 15),
            ),
            const SizedBox(
              height: 6,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Amount',
                filled: true,
                isDense: true,
              ),
              keyboardType: TextInputType.number,
              controller: _amountController,
              //validator: (val) => _validateRequired(val, 'Password'),
            ),
            // const SizedBox(
            //   height: 16,
            // ),
            // TextFormField(
            //   decoration: const InputDecoration(
            //     labelText: 'Narration',
            //     filled: true,
            //     isDense: true,
            //   ),
            //   controller: _narrationController,
            //   //validator: (val) => _validateRequired(val, 'Password'),
            // ),
            const SizedBox(
              height: 14,
            ),
            MaterialButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child: const Text('Make Transfer'),
              onPressed: () {
                performMoneyTransfer(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
