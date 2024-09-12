// ignore_for_file: use_build_context_synchronously

import 'package:expense_tracker/constants/form_decoration.dart';
import 'package:expense_tracker/constants/snackbar.dart';
import 'package:expense_tracker/constants/theme.dart';
import 'package:expense_tracker/provider/expense_provider.dart';
//import 'package:expense_tracker/provider/refresh_provider.dart';
import 'package:expense_tracker/view/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String amount = '';
  String? name;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colour.darkWhite,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            const SizedBox(
              height: 80,
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 40,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    child: Text(
                      "Add your expense",
                      style: customTextStyle,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              flex: 3,
              child: Form(
                  child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.5),
                      child: TextFormField(
                        onChanged: (value) {
                          amount = value;
                        },
                        autofocus: true,
                        cursorColor: Colour.dark,
                        style: const TextStyle(
                          letterSpacing: 2,
                          fontSize: 24,
                          color: Colour.dark,
                        ),
                        decoration: customDecoration,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.2),
                      child: TextFormField(
                        onChanged: (value) {
                          name = value;
                        },
                        decoration:
                            customDecoration.copyWith(labelText: 'Name'),
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 20,
                          color: Colour.dark,
                        ),
                        autocorrect: true,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Consumer<ExpenseProvider>(
                        builder: (BuildContext context, ExpenseProvider value,
                            Widget? child) {
                          return RawMaterialButton(
                            padding: const EdgeInsets.all(10),
                            onPressed: () async {
                              setState(() {
                                loading = true;
                              });
                              await value.addExpense(
                                  name: name,
                                  amount: int.parse(amount),
                                  invoice: "Landrine");
                              if (value.state == Status.success) {
                                //print("success");
                                // Provider.of<RefreshProvider>(context)
                                //     .refreshPage();
                                setState(() {
                                  loading = false;
                                });
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Homepage()));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  customSnackBar(
                                      content: "Expense added succesfully",
                                      icon: Icons.add_task_outlined,
                                      colour: Colour.green),
                                );
                              } else {
                                Navigator.pop(context);
                                 ScaffoldMessenger.of(context).showSnackBar(
                                  customSnackBar(
                                      content: "Error occured, check your network connection",
                                      icon: Icons.error_outline,
                                      colour: Colour.red),
                                );
                              }
                            },
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Colour.blue,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            fillColor: Colour.darkBlue,
                            child: loading
                                ? const CircularProgressIndicator(
                                    color: Colour.white,
                                  )
                                : const Text(
                                    "Add",
                                    style: TextStyle(
                                      color: Colour.white,
                                      fontSize: 14,
                                    ),
                                  ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
