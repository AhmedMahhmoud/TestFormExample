import 'package:first_test/model-2/form_data_model.dart';
import 'package:flutter/material.dart';

class RadioButtons2 extends StatelessWidget {
  final FormDataModel element;
  const RadioButtons2({required this.element, super.key});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setstate) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(element.label),
          SizedBox(
            width: double.infinity,
            height: element.items!.length * 60,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return RadioListTile(
                  controlAffinity: ListTileControlAffinity.trailing,
                  value: element.items![index],
                  groupValue: element.value,
                  title: Text(
                    element.items![index],
                  ),
                  onChanged: (value) {
                    setstate(() {
                      element.value = value.toString();
                    });
                  },
                );
              },
              itemCount: element.items!.length,
            ),
          ),
        ],
      );
    });
  }
}
