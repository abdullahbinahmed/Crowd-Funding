import 'package:flutter/material.dart';

enum AlertStatus { success, error, warning }
String alertImage = '';

class CustomAlert extends StatelessWidget {
  final AlertStatus alertStatus;
  final String message;

  const CustomAlert({required this.alertStatus, required this.message});

  @override
  Widget build(BuildContext context) {
    switch (alertStatus) {
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
            onPressed: () {
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
            message,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
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
