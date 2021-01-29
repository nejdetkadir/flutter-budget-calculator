import 'package:flutter/material.dart';
import 'package:budget_calculator/main.dart';
import 'package:budget_calculator/model/record.dart';
import 'package:uuid/uuid.dart';

class CreateView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateView();
}

class _CreateView extends State<CreateView> {
  var uuid = Uuid();
  var formKey = GlobalKey<FormState>();
  String selectedType = "+ (income)";
  TextEditingController descriptionController;
  TextEditingController amountController;
  String description;
  double amount;

  @override
  void initState() {
    super.initState();
    descriptionController = TextEditingController();
    amountController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: descriptionController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.fact_check),
                  hintText: "Enter your description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
                maxLength: 30,
                validator: (value) {
                  if (value.length > 0) {
                    return null;
                  } else
                    return "Can not assign empty value!";
                },
                onSaved: (newValue) => description = newValue,
              ),
              Row(
                children: [
                  Expanded(
                      child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      onChanged: (value) {
                        setState(() {
                          selectedType = value;
                        });
                      },
                      value: selectedType,
                      items: [
                        DropdownMenuItem(
                          value: "+ (income)",
                          child: Text(
                            "+ (income)",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "- (expense)",
                          child: Text(
                            "- (expense)",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  )),
                  Expanded(
                    child: TextFormField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.attach_money),
                        hintText: "Amount",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                      validator: (value) {
                        try {
                          if (double.parse(value).runtimeType == double ||
                              int.parse(value).runtimeType == int) {
                            return null;
                          } else {
                            return "Enter amount";
                          }
                        } catch (e) {
                          return "Enter amount";
                        }
                      },
                      onSaved: (newValue) => amount = double.parse(newValue),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: RaisedButton.icon(
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      setState(() {
                        MyHomePage.listData.add(Record(uuid.v1().toString(),
                            description, selectedType[0], amount));
                        selectedType = "+ (income)";
                        descriptionController.text = "";
                        amountController.text = "";
                        MyHomePage.calculateData();
                      });
                    }
                  },
                  icon: Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                  label: Text(
                    "CREATE",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: selectedType[0] == "+" ? Colors.green : Colors.red,
                  elevation: 8,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
