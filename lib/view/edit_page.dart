
import 'package:expense_tracker/constants/form_decoration.dart';
import 'package:expense_tracker/constants/theme.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final int amount;
  final String name;

  const EditPage({super.key, required this.amount, required this.name});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
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
