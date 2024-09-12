// ignore_for_file: use_build_context_synchronously

import 'package:expense_tracker/constants/form_decoration.dart';
import 'package:expense_tracker/constants/snackbar.dart';
import 'package:expense_tracker/constants/theme.dart';
import 'package:expense_tracker/provider/expense_provider.dart';
//import 'package:expense_tracker/provider/refresh_provider.dart';
import 'package:expense_tracker/view/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditPage extends StatefulWidget {
  final int amount;
  final String name;
  final String? expenseId;

  const EditPage(
      {super.key,
      required this.amount,
      required this.name,
      required this.expenseId});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late String amount;
  late String name;
  bool deleteLoading = false;
  bool editLoading = false;

  @override
  void initState() {
    amount = widget.amount.toString();
    name = widget.name.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colour.darkWhite,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          const SizedBox(
            height: 50,
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
                    "Edit your expense",
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
                      initialValue: amount,
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
                    height: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.2),
                    child: TextFormField(
                      initialValue: name,
                      onChanged: (value) {
                        name = value;
                      },
                      decoration: customDecoration.copyWith(labelText: 'Name'),
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
                            editLoading = true;
                            
                              
                              await value.updateExpense(
                                  name: name,
                                  amount: int.parse(amount),
                                  invoice: "Landrine",
                                  expenseId: widget.expenseId!);
                          
                        
                            if (value.state == Status.success) {
                              //print("success");
                              // Provider.of<RefreshProvider>(context)
                              //     .refreshPage();
                              setState(() {
                                editLoading = false;
                              });
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const Homepage()));
                              ScaffoldMessenger.of(context).showSnackBar(
                                customSnackBar(
                                    content: "Expense edited succesfully",
                                    icon: Icons.edit,
                                    colour: Colour.green),
                              );
                            } else {
                              setState(() {
                                editLoading = false;
                              });
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                customSnackBar(
                                    content: "An error occured",
                                    icon: Icons.error,
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
                          child: editLoading
                              ? const SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: CircularProgressIndicator(
                                    color: Colour.green,
                                  ),
                                )
                              : const Text(
                                  "Edit",
                                  style: TextStyle(
                                    color: Colour.white,
                                    fontSize: 14,
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                  Consumer<ExpenseProvider>(
                    builder: (BuildContext context, ExpenseProvider value,
                        Widget? child) {
                      return Align(
                        alignment: Alignment.bottomLeft,
                        child: RawMaterialButton(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colour.blue,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(6),
                          fillColor: Colour.red,
                          onPressed: () async {
                            deleteLoading = true;
                            await value.deleteExpense(
                                expenseId: widget.expenseId!);

                            if (value.state == Status.success) {
                              //print("success");
                              // Provider.of<RefreshProvider>(context)
                              //     .refreshPage();
                              setState(() {
                                deleteLoading = false;
                              });
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Homepage()));
                              ScaffoldMessenger.of(context).showSnackBar(
                                customSnackBar(
                                    content: "Expense deleted succesfully",
                                    icon: Icons.delete_forever,
                                    colour: Colour.green),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                customSnackBar(
                                    content: "An error occured",
                                    icon: Icons.error,
                                    colour: Colour.red),
                              );
                              Navigator.pop(context);
                            }
                          },
                          child: deleteLoading
                              ? const SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: CircularProgressIndicator(
                                    color: Colour.green,
                                  ),
                                )
                              : const Icon(
                                  size: 30,
                                  Icons.delete_rounded,
                                  color: Colour.blue,
                                ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )),
          )
        ],
      ),
    );
  }
}
