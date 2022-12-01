import 'package:flutter/material.dart';

Future alert(BuildContext context, bool dismiss, String title, String content) => showDialog(
  context: context,
  barrierDismissible: dismiss,
  builder: (_) => AlertDialog(
    title:  Text(title),
    content: Text(content),
    actions: [
      TextButton(
        child: const Text("OK"),
        onPressed: () => Navigator.pop(context),
      )
    ]
  )
);

Future input(
  BuildContext context,
  String title,
  String cancel,
  bool obscure,
  bool isNum,
  String? hint,
  TextEditingController ctl,
  Function(String) value
) => showDialog(
  context: context,
  barrierDismissible: false,
  builder: (_) => AlertDialog(
    title: Text(title),
    content: TextField(
      controller: ctl,
      obscureText: obscure,
      enableSuggestions: !obscure,
      keyboardType: isNum ? TextInputType.number : null,
      autocorrect: !obscure,
      decoration: hint != null
        ? InputDecoration(hintText: hint)
        : null,
    ),
    actions: [
      TextButton(
        child: Text(cancel),
        onPressed: () {
          value("");
          Navigator.pop(context);
        },
      ),
      TextButton(
        child: const Text("OK"),
        onPressed: () {
          value(ctl.text);
          Navigator.pop(context);
        },
      )
    ]
  )
);

Future yesNoAlert(
  BuildContext context,
  String title,
  String content,
  bool dismiss,
  String yesTitle,
  String noTitle,
  VoidCallback yesCall,
  VoidCallback noCall
) => showDialog(
  context: context,
  barrierDismissible: dismiss,
  builder: (_) => AlertDialog(
    title:  Text(title),
    content: Text(content),
    actions: [
      TextButton(
        child: Text(yesTitle),
        onPressed: () {
          yesCall();
          Navigator.pop(context);
        }
      ),
      TextButton(
        child: Text(noTitle),
        onPressed: () {
          noCall();
          Navigator.pop(context);
        },
      )
    ]
  )
);

dynamic snackBar(BuildContext context, String text) => ScaffoldMessenger.of(context)
  .showSnackBar(SnackBar(
    content: Text(text),
    duration: const Duration(seconds: 2)
  ));