import 'package:flutter/material.dart';

class DisplayFormFieldList extends StatelessWidget {
  final List<TextFormField> textFormFields;

  const DisplayFormFieldList({required this.textFormFields, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            width: double.infinity,
            height: textFormFields.length * 85,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return textFormFields[index];
              },
              itemCount: textFormFields.length,
              separatorBuilder: (context, index) => const Divider(
                height: 10,
              ),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
