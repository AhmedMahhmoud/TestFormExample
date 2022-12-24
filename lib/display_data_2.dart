import 'package:flutter/material.dart';

import 'model-2/form_builder_2.dart';

class DisplayForm2 extends StatelessWidget {
  final FormBuilder2 form;
  const DisplayForm2({required this.form, super.key});

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
                    Text(
                      "Form information results",
                      style: TextStyle(
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Expanded(
                      child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Text("${form.formDataList[index].label} : "),
                                Text(form.formDataList[index].value.toString())
                              ],
                            );
                          },
                          itemCount: form.formDataList.length),
                    ),
                    const Divider(
                      thickness: 1,
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
