import 'dart:ffi';

import 'package:cf_app/custom_alert.dart';
import 'package:cf_app/global.dart';
import 'package:cf_app/screens/campaigns/model.dart';
import 'package:cf_app/screens/payments/alert_otp.dart';
import 'package:cf_app/screens/payments/model.dart';
import 'package:cf_app/widgets/decorated-text-field.dart';
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
  final FocusNode _amountFocusNode = FocusNode();
  final TextEditingController _amountController = TextEditingController();
  //late InitiatePaymentResponse responseInitializePayment;

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
        ListTile(
          leading: const Icon(Icons.details),
          title: Text(widget.campaignEntry.description),
          subtitle: const Text('Campaign Description'),
        ),
        ListTile(
          leading: const Icon(Icons.date_range),
          title: Text(widget.campaignEntry.startdate
                  .replaceFirst('T', ' ', 0)
                  .replaceFirst('.000Z', ' ') +
              " - " +
              widget.campaignEntry.enddate
                  .replaceFirst('T', ' ', 0)
                  .replaceFirst('.000Z', ' ')),
          subtitle: const Text('Campaign date range '),
        ),
        ListTile(
          leading: const Icon(Icons.start),
          title: Text(widget.campaignEntry.createddate
              .replaceFirst('T', ' ', 0)
              .replaceFirst('.000Z', ' ')),
          subtitle: const Text('Campaign Created date'),
        ),
        ListTile(
          leading: const Icon(
            Icons.attach_money_sharp,
            color: Colors.red,
          ),
          title: Text(widget.campaignEntry.uitargetAmount),
          subtitle: const Text('Target amount'),
        ),
        ListTile(
          leading: const Icon(
            Icons.attach_money_sharp,
            color: Colors.green,
          ),
          title: Text(widget.campaignEntry.uiamountAchieved),
          subtitle: const Text('Acheived Amount'),
        ),
        const SizedBox(
          height: 8.0,
        ),
        const Divider(),
        const SizedBox(
          height: 8.0,
        ),
        const ListTile(
          leading: Icon(
            Icons.house,
          ),
          title: Text('NIFT Test Bank'),
          subtitle: Text('Bank name'),
        ),
        const ListTile(
          leading: Icon(
            Icons.house,
          ),
          title: Text('Account Number'),
          subtitle: Text('788-xxxxxxxxx-11'),
        ),
        //show related fields and a Text box of amount
        DecoratedFormTextField(
          icon: Icons.money,
          focusNode: _amountFocusNode,
          hintText: "Amount to donate",
          labelText: "Amount",
          controller: _amountController,
          keyboardType: Theme.of(context).platform == TargetPlatform.iOS
              ? TextInputType.numberWithOptions(decimal: true)
              : TextInputType.phone,
          hasError: false,
          validator: (value) => validateAmount(value, "invalid amount"),
          maxLength: 5,
          counterText: '',
        ),
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
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const AlertDialog(
        content: ListTile(
          leading: CircularProgressIndicator(),
          title: Text('Processing payment verification ... please wait'),
        ),
      ),
    );

    PaymentApi api = PaymentApi(dataSource, "token");
    InitiatePaymentResponse response = await api.initiateTxn(
        _amountController.text,
        widget.campaignEntry.id.replaceAll('c', "campaign"));

    // setState(() {
    //   responseInitializePayment = response;
    // });

    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => OTPAlertWidget(
        alertStatus: AlertStatus.success,
        message: "Payment successfully done. Enter OTP",
        responseInitPayment: response,
        campaignEntry: widget.campaignEntry,
        uiAmount: _amountController.text,
      ),
    );
    //Navigator.pop(context);
    return "";
  }

  String? validateAmount(String? value, String error) {
    try {
      if (double.parse(value.toString()) > 0) {
        return null;
      } else {
        return error;
      }
    } catch (e) {
      return error;
    }
  }
}
