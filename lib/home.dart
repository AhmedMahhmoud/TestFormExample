import 'dart:developer';

import 'package:first_test/model/form_builder_model.dart';
import 'package:first_test/model/radio_button_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'model/text_field_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

List<TextFormField>? formFieldsList = [];
List<TextEditingController>? formFieldsControllers = [];
List<String>? selectedRadio = [];
List<List<RadioListTile>>? radioList = [];
late Future<List<TextFormField>?> getData;
late FormBuilder formData;

class _HomeState extends State<Home> {
  Future<List<TextFormField>?> readJson() async {
    final String response = await rootBundle.loadString('assets/form.json');
    final data = await json.decode(response)['fields'] as List;
    formData = data.map((e) => FormBuilder.fromMap(e)).first;
    fillRadioTiles(formData.radioButtonsList);
    return fillFormFields(formData.textFieldsList);
  }

  final _formKey = GlobalKey<FormState>();
  Future<List<List<RadioListTile>>?> fillRadioTiles(
      List<RadioButtonModel> radioFields) async {
    for (int i = 0; i < radioFields.length; i++) {
      radioList!.insert(i, []);
      selectedRadio!.insert(i, radioFields[i].value);
      for (int j = 0; j < radioFields[i].items.length; j++) {
        radioList![i].add(RadioListTile(
          title: Text(radioFields[i].items[j]),
          controlAffinity: ListTileControlAffinity.trailing,
          value: radioFields[i].items[j],
          groupValue: selectedRadio![i],
          onChanged: (value) {},
        ));
      }
    }
    return radioList;
  }

  Future<List<TextFormField>?>? fillFormFields(
      List<TextFieldModel> inputFields) async {
    for (int i = 0; i < inputFields.length; i++) {
      formFieldsControllers!.add(TextEditingController());
      formFieldsList!.add(TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Required";
          }
        },
        controller: formFieldsControllers![i],
        obscureText: inputFields[i].label == "password" ? true : false,
        decoration: InputDecoration(
          label: Text(inputFields[i].label),
          hintText: inputFields[i].label,
        ),
      ));
    }
    log(formFieldsList!.length.toString());
    await Future.delayed(Duration(seconds: 1));
    return formFieldsList;
  }

  @override
  void initState() {
    getData = readJson();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print(selectedRadio![0].toString()),
      child: Scaffold(
          body: FutureBuilder(
              future: getData,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: SizedBox(
                            width: double.infinity,
                            height: formFieldsList!.length * 90,
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                return formFieldsList![index];
                              },
                              itemCount: formFieldsList!.length,
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                height: 10,
                              ),
                            ),
                          ),
                        ),
                        for (int i = 0; i < radioList!.length; i++)
                          SizedBox(
                            width: double.infinity,
                            height: radioList![i].length * 90,
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                        formData.radioButtonsList[i].label)),
                                Expanded(
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return RadioListTile(
                                        value: radioList![i][index].value,
                                        groupValue: selectedRadio![i],
                                        title: Text(
                                          radioList![i][index].value,
                                        ),
                                        onChanged: (value) {
                                          print(value);
                                          setState(() {
                                            selectedRadio![i] = value;
                                          });
                                        },
                                      );
                                    },
                                    itemCount: radioList![i].length,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Spacer(),
                        Center(
                          child: MaterialButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                              } else {
                                return;
                              }
                            },
                            child: Column(
                              children: [
                                Divider(
                                  thickness: 2,
                                  color: Colors.black,
                                ),
                                Text("validate"),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
              })),
    );
  }
}
