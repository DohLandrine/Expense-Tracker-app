import 'dart:convert';
import 'package:expense_tracker/model/express_model.dart';
import 'package:expense_tracker/services/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExpenseProvider extends ChangeNotifier {
  static ExpenseProvider instance = ExpenseProvider();
  State state = State.nothing;
  ExpenseProvider() {
    //
  }

  Future<List<ExpenseModel>> getExpense() async {
    state = State.loading;
    notifyListeners();
    final response = await http.get(Uri.parse(Url.getAllExpennse));
    if (response.statusCode == 200 || response.statusCode == 201) {
      state = State.success;
      notifyListeners();
      List jsonData = jsonDecode(response.body);
      return jsonData.map((data) => ExpenseModel.fromJson(data)).toList();
    } else {
      state = State.error;
      notifyListeners();
      return [];
    }
  }

  void addExpense(
      {required String? name,
      required int? amount,
      required String? invoice}) async {
    state = State.loading;
    notifyListeners();
    Map<String, dynamic> data = {
      "name": name,
      "amount": amount,
      "invoice": invoice
    };
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final response = await http.post(Uri.parse(Url.addExpense),
        body: json.encode(data), headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      state = State.success;
      notifyListeners();
    } else {
      state = State.error;
      notifyListeners();
    }
  }

  void deleteExpense({required String expenseId}) async {
    state = State.loading;
    notifyListeners();
    Map<String, String> body = {"expenseID": expenseId};
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final response = await http.delete(Uri.parse(Url.deleteExpense),
        body: json.encode(body), headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      state = State.success;
      notifyListeners();
    } else {
      state = State.error;
      notifyListeners();
    }
  }

  void updateExpense(
      {required String? name,
      required int? amount,
      required String? invoice,
      required String expenseId
      }) async {
    state = State.loading;
    notifyListeners();
    Map<String, dynamic> data = {
      "expenseID": expenseId,
      "name": name,
      "amount": amount,
      "invoice": invoice
    };
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final response = await http.put(Uri.parse(Url.addExpense),
        body: json.encode(data), headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      state = State.success;
      notifyListeners();
    } else {
      state = State.error;
      notifyListeners();
    }
  }
  

  
}

enum State {
  nothing,
  loading,
  success,
  error,
}
