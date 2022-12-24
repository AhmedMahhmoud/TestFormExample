import 'package:first_test/model-2/form_data_model.dart';
import 'package:first_test/widgets/drop_down_2.dart';
import 'package:first_test/widgets/radio_fields_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'display_data_2.dart';
import 'model-2/form_builder_2.dart';

class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

List<TextFormField>? formFieldsList = [];
List<TextEditingController>? formFieldsControllers = [];

List<List<RadioListTile>>? radioList = [];
List<DropdownButton>? dropDownList = [];
late Future<FormBuilder2> getData;
late FormBuilder2 formData;
bool isFormItemsIntialized = false;

class _Home2State extends State<Home2> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getData = readJson();

    super.initState();
  }

  List<Widget> formWidgetList = [];
  Future<FormBuilder2> readJson() async {
    await Future.delayed(const Duration(seconds: 1));
    final String response = await rootBundle.loadString('assets/form2.json');
    final data = json.decode(response);
    formData = FormBuilder2.fromMap(data);
    for (var element in formData.formDataList) {
      switch (element.dataType) {
        case "input_text_field":
          await fillFormFields(element);
          formWidgetList.add(formFieldsList![formFieldsList!.length - 1]);
          break;
        case "drop_down":
          formWidgetList.add(DropDown2(
            element: element,
          ));
          break;
        case "radio_button":
          formWidgetList.add(RadioButtons2(
            element: element,
          ));
          break;
        default:
      }
    }

    return formData;
  }

  fillFormFields(FormDataModel element) {
    formFieldsControllers!.add(TextEditingController());
    formFieldsList!.add(TextFormField(
      validator: (value) {
        if (element.isRequired == true) {
          if (value!.isEmpty) {
            return "Required";
          }
          return null;
        }
        return null;
      },
      onChanged: (newValue) {
        element.value = newValue;
      },
      controller: formFieldsControllers![formFieldsControllers!.length - 1],
      obscureText: element.label == "password" ? true : false,
      decoration: InputDecoration(
        label: Text(element.label),
        hintText: element.label,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 50,
                child: FutureBuilder(
                    future: getData,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (isFormItemsIntialized == false) {
                          // initializeFormDisplay();
                        }
                        return Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: ListView.separated(
                            separatorBuilder: (context, index) => const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10)),
                            itemBuilder: (context, index) {
                              return formWidgetList[index];
                            },
                            itemCount: formWidgetList.length,
                          ),
                        );
                      }
                    }),
              ),
              MaterialButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DisplayForm2(form: formData),
                        ));
                  } else {
                    return;
                  }
                },
                child: Column(
                  children: const [
                    Divider(
                      thickness: 2,
                      color: Colors.black,
                    ),
                    Text("Submit"),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
