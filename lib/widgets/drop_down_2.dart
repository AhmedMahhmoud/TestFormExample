import 'package:first_test/model-2/form_data_model.dart';
import 'package:flutter/material.dart';

class DropDown2 extends StatelessWidget {
  final FormDataModel element;
  const DropDown2({required this.element, super.key});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setstate) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            element.label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          DropdownButton(
            items: element.items!.map((items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            value: element.value,
            onChanged: (value) {
              setstate(() {
                element.value = value.toString();
              });
            },
          ),
        ],
      );
    });
  }
}
