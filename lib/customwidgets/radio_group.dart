import 'package:flutter/material.dart';

class RadioGroup extends StatelessWidget {
  final String text;
  final String groupValue;
  final String value;
  final Function(String) onChange;

  const RadioGroup({
    super.key,
    required this.text,
    required this.value,
    required this.groupValue,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: (value) {
            onChange(value!);
          },
        ),
        Text(value),
      ],
    );
  }
}
