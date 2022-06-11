import 'package:cf_app/custom_alert.dart';
import 'package:cf_app/global.dart';
import 'package:cf_app/screens/campaigns/model.dart';
import 'package:cf_app/screens/payments/model.dart';
import 'package:cf_app/widgets/decorated-text-field.dart';
import 'package:flutter/material.dart';

// enum AlertStatus { success, error, warning }
// String alertImage = '';

class OTPAlertWidget extends StatefulWidget {
  final AlertStatus alertStatus;
  final String message;
  final InitiatePaymentResponse responseInitPayment;
  final CampaignEntry campaignEntry;
  final String uiAmount;

  const OTPAlertWidget(
      {Key? key,
      required this.alertStatus,
      required this.message,
      required this.responseInitPayment,
      required this.campaignEntry,
      required this.uiAmount})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => OTPAlert();
}

class OTPAlert extends State<OTPAlertWidget> {
  @override
  Widget build(BuildContext context) {
    switch (widget.alertStatus) {
      case AlertStatus.success:
        alertImage = 'assets/icons/ic_check.png';
        break;
      case AlertStatus.error:
        alertImage = 'assets/icons/ic_error.png';
        break;
      case AlertStatus.warning:
        alertImage = 'assets/icons/ic_warning.png';
        break;
      default:
        alertImage = 'assets/icons/ic_info.png';
    }

    return AlertDialog(
      actions: <Widget>[
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Color.fromARGB(255, 110, 10, 126).withOpacity(0.5);
                }
                return Color.fromARGB(
                    255, 110, 10, 126); // Use the component's default.
              },
            )),
            onPressed: () async {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => const AlertDialog(
                  content: ListTile(
                    leading: CircularProgressIndicator(),
                    title: Text('Processing OTP Verification ... please wait'),
                  ),
                ),
              );

              PaymentApi api = PaymentApi(dataSource, "token");

              var response = await api.submitOTP(
                  "012345",
                  widget.responseInitPayment,
                  widget.campaignEntry.id.replaceAll('c-', 'campaign-'),
                  widget.uiAmount);

              Navigator.of(context).pop();
              await showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => CustomAlert(
                    alertStatus: AlertStatus.success, message: response),
              );
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('OK'))
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
            child: Helper.getAssetImageIcon(alertImage, size: 96.0),
          ),
          Text(
            widget.message,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 16.0,
          ),
          DecoratedFormTextField(
            icon: Icons.password,
            focusNode: FocusNode(),
            hintText: "OTP",
            labelText: "OTP",
            controller: TextEditingController(),
            keyboardType: TextInputType.number,
            hasError: false,
            validator: (value) => validateAmount(value, "invalid OTP"),
            maxLength: 6,
            counterText: '',
          ),
        ],
      ),
    );
  }

  String? validateAmount(String? value, String error) {
    try {
      if (double.parse(value.toString()) > 0) {
        return null;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

class Helper {
  //ImageIcon class doesn't handle image own colors so this is a workaround
  static Image getAssetImageIcon(String assetPath, {size = 20.0}) {
    return Image(
      image: AssetImage(assetPath),
      width: size,
      height: size,
      color: null,
      fit: BoxFit.scaleDown,
      alignment: Alignment.center,
    );
  }
}
