import 'dart:ffi';

import 'package:cf_app/screens/campaigns/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final CampaignEntry campaignEntry;

  const PaymentScreen({Key? key, required this.campaignEntry})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contribute to camapign'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(children: [
        ListTile(
          leading: const Icon(Icons.perm_identity),
          title: Text(widget.campaignEntry.name),
          subtitle: const Text('Campaign Name'),
        ),
        //show related fields and a Text box of amount
        ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('CANCEL'),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return const Color.fromARGB(255, 110, 10, 126)
                        .withOpacity(0.5);
                  }
                  return const Color.fromARGB(
                      255, 110, 10, 126); // Use the component's default.
                },
              )),
            ),
            ElevatedButton(
              onPressed: doPayment,
              child: const Text('PAY'),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return const Color.fromARGB(255, 110, 10, 126)
                        .withOpacity(0.5);
                  }
                  return const Color.fromARGB(
                      255, 110, 10, 126); // Use the component's default.
                },
              )),
            ),
          ],
        )
      ]),
    );
  }

  Future<String> doPayment() async {
    return "";
  }
}
