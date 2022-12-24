import 'package:first_test/model/radio_button_model.dart';
import 'package:first_test/model/text_field_model.dart';
import 'package:flutter/material.dart';

class DisplayForm extends StatelessWidget {
  final List<TextFieldModel>? textFields;
  final List<RadioButtonModel>? selectedRadios;
  const DisplayForm({this.selectedRadios, this.textFields, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    const Text(
                      "Form information results",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: textFields!.length * 40,
                      child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Text("${textFields![index].label} : "),
                                Text(textFields![index].value.toString())
                              ],
                            );
                          },
                          itemCount: textFields!.length),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: selectedRadios!.length * 40,
                      child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Text("${selectedRadios![index].label} : "),
                                Text(selectedRadios![index].value.toString())
                              ],
                            );
                          },
                          itemCount: selectedRadios!.length),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
