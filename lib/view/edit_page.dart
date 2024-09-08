// ignore_for_file: use_build_context_synchronously

import 'package:expense_tracker/constants/form_decoration.dart';
import 'package:expense_tracker/constants/snackbar.dart';
import 'package:expense_tracker/constants/theme.dart';
import 'package:expense_tracker/provider/expense_provider.dart';
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
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colour.darkWhite,
      body: Column(
        children: [
          const SizedBox(
            height: 100,
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
          Consumer<ExpenseProvider>(
            builder:
                (BuildContext context, ExpenseProvider value, Widget? child) {
              return GestureDetector(
                onTap: () async {
                  loading = true;
                  await value.deleteExpense(expenseId: widget.expenseId!);

                  if (value.state == Status.success) {
                    print("success");
                    setState(() {
                      loading = false;
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      customSnackBar(
                          content: "Expense deleted succesfully",
                          icon: Icons.delete_forever,
                          colour: Colour.green),
                    );
                  } else {
                    print('Error');
                  }
                },
                child: loading
                    ? const SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(),
                      )
                    : const Icon(
                        Icons.delete_rounded,
                        color: Colour.darkBlue,
                      ),
              );
            },
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
                    child: RawMaterialButton(
                      padding: const EdgeInsets.all(10),
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colour.blue,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Colour.darkBlue,
                      child: const Text(
                        "Edit",
                        style: TextStyle(
                          color: Colour.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
          )
        ],
      ),
    );
  }
}
