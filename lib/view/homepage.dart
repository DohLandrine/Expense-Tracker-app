import 'package:expense_tracker/constants/snackbar.dart';
import 'package:expense_tracker/constants/theme.dart';
import 'package:expense_tracker/view/add_page.dart';
import 'package:expense_tracker/view/edit_page.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/provider/expense_provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colour.darkWhite,
      appBar: AppBar(
        backgroundColor: Colour.darkBlue,
        centerTitle: true,
        elevation: 5,
        shadowColor: Colour.blue,
        title: const Text(
          "Expense tracker",
          style: TextStyle(color: Colour.white),
        ),
      ),
      body: Flex(
        direction: Axis.vertical,
        children: [
          const SizedBox(
            height: 15,
          ),
          const Align(
            child: Text("Let's track your expense", style: customTextStyle),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: FutureBuilder(
              initialData: [],
              future: ExpenseProvider.instance.getExpense(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colour.blue,
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return const Center(
                    child: Text('Please turn on your mobile data'),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data == null) {
                    return GestureDetector(
                      child: Container(
                        color: Colour.darkWhite,
                      ),
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        customSnackBar(
                            content:
                                "An error occured, Please turn on your mobile data",
                            icon: Icons.e_mobiledata,
                            colour: Colour.red),
                      ),
                    );
                  } else {
                    return SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ListView.separated(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditPage(
                                      amount: snapshot.data![index].amount!,
                                      name: snapshot.data![index].name!,
                                      expenseId: snapshot.data![index].id,
                                    ),
                                  ),
                                );
                              },
                              trailing: SizedBox(
                                width: 80,
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  '${snapshot.data![index].date}',
                                ),
                              ),
                              subtitle: Text(
                                '${snapshot.data![index].name}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              title: Text(
                                '${snapshot.data![index].amount}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colour.dark),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              // tileColor: Colour.white,
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 20,
                          );
                        },
                      ),
                    );
                  }
                } else {
                  return const Text("Error ohh");
                }
              },
            ),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
      floatingActionButton: RawMaterialButton(
          padding: const EdgeInsets.all(20),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddPage(),
              ),
            );
          },
          shape: const CircleBorder(
            side: BorderSide(
              color: Colour.blue,
            ),
          ),
          fillColor: Colour.darkBlue,
          child: const Icon(
            Icons.add,
            color: Colour.white,
          )),
    );
  }
}
