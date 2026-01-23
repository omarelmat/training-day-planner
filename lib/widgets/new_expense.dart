import 'package:training_day_planner/model/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  final void Function(Expense expense) submitExpense;

  const NewExpense({super.key, required this.submitExpense});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  /*var expenseTitle = "";

  void _saveExpenseTitle(String value) {
    expenseTitle = value;
  }*/

  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  void _displayDatePicker() async {
    final datePicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), //default date shown/selected
      firstDate: DateTime(
        DateTime.now().year,
        DateTime.now().month - 1,
        DateTime.now().day,
      ), //earliest date selectable in the past
      lastDate: DateTime.now(), //latest date selectable in the future
    );
    //this follow is executed once the user selects a date or cancel
    setState(() {
      _selectedDate = datePicked;
    });

    /* showDatePicker(
      context: context,
      initialDate: DateTime.now(), //default date shown/selected
      firstDate: DateTime(
        DateTime.now().year,
        DateTime.now().month - 1,
        DateTime.now().day,
      ), //earliest date selectable in the past
      lastDate: DateTime.now(), //latest date selectable in the future
    ).then((value) {
      setState(() {
        _selectedDate = value;
      });
    });*/
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    //tryParse returns null if parsing fails
    //tryParse ('Hello') => null tryParse('12.34') => 12.34

    if (enteredAmount == null ||
        enteredAmount <= 0 ||
        _titleController.text.trim().isEmpty ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Invalid Input"),
          content: Text(
            "Please make sure a valid title, amount, date and category was entered.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
      //show error message
      return;
    }

    //new instance of expense
    var newExpense = Expense(
      title: _titleController.text.trim(),
      amount: enteredAmount,
      date: _selectedDate!,
      category: _selectedCategory,
    );
    widget.submitExpense(newExpense);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(25),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            maxLength: 50,
            keyboardType: TextInputType.text,
            //onChanged: _saveExpenseTitle,
            controller: _titleController,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    prefixText: '€',
                  ),
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No Date Selected'
                          : formatter.format(_selectedDate!).toString(),
                    ),
                    IconButton(
                      onPressed: _displayDatePicker,
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(
                width: 120,
                child: DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
              ),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel"),
                    ),
                    SizedBox(width: 5),
                    ElevatedButton(
                      onPressed: _submitExpenseData,
                      child: Text("Save Expense"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
