import 'package:flutter/material.dart';

showMsg(BuildContext context, String msg) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

showSingleTextInputDialog({
  required BuildContext context,
  required String title,
  String pogBtnTxt = 'SAVE',
  String negBtnTxt = 'CANCEL',
  required Function(String) onSave,
}) {
  final controller = TextEditingController();
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
            title: Text(title),
            content: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.purple
                  )
                )
              ),
              controller: controller,
              autofocus: true,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(negBtnTxt),
              ),
              TextButton(
                onPressed: () {
                  if (controller.text.isEmpty) return;
                  Navigator.pop(context);
                  onSave(controller.text);
                },
                child: Text(pogBtnTxt),
              ),
            ],
          ));
}
