import 'package:flutter/material.dart';

class DisplayRadioFieldsList extends StatelessWidget {
  final String label;
  final Function radioFunc;
  final String selectedRadioVal;
  final List<RadioListTile> radioListTile;
  const DisplayRadioFieldsList(
      {required this.selectedRadioVal,
      required this.label,
      required this.radioFunc,
      required this.radioListTile,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
        ),
        SizedBox(
          width: double.infinity,
          height: radioListTile.length * 60,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return RadioListTile(
                controlAffinity: ListTileControlAffinity.trailing,
                value: radioListTile[index].value,
                groupValue: selectedRadioVal,
                title: Text(
                  radioListTile[index].value,
                ),
                onChanged: (value) => radioFunc(value),
              );
            },
            itemCount: radioListTile.length,
          ),
        ),
        const Divider(
          thickness: 1,
        ),
      ],
    );
  }
}
