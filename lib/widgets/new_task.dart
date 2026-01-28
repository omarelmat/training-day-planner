import 'package:training_day_planner/model/task.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; 
import 'package:training_day_planner/notification_helper.dart';





class NewTask extends StatefulWidget {
  final void Function(Task task) submitTask;



  const NewTask({super.key, required this.submitTask});



  @override
  State<NewTask> createState() {
    return _NewTaskState();
  }
}



class _NewTaskState extends State<NewTask> {
  /*var expenseTitle = "";



  void _saveExpenseTitle(String value) {
    expenseTitle = value;
  }*/



  DateTime? _selectedDate;
  TaskCategory _selectedCategory = TaskCategory.work;



  final _titleController = TextEditingController();
  final _durationController = TextEditingController();



  String? _photoPath;  
final ImagePicker _picker = ImagePicker();



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
    _durationController.dispose();
    super.dispose();
  }



  void _takePicture() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    
    if (photo != null) {
      setState(() {
        _photoPath = photo.path;
      });
    }
  }



    void _submitTaskData() {
    final enteredDuration = double.tryParse(_durationController.text);
    //tryParse returns null if parsing fails
    //tryParse ('Hello') => null tryParse('12.34') => 12.34


    if (enteredDuration == null ||
        enteredDuration <= 0 ||
        _titleController.text.trim().isEmpty ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Invalid Input"),
          content: Text(
            "Please make sure a valid title, duration, date and category was entered.",
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


    //new instance of task
    var newTask = Task(
      id: uuid.v4(),
      title: _titleController.text.trim(),
      duration: enteredDuration,
      date: _selectedDate!,
      category: _selectedCategory,
      photoPath: _photoPath,
    );
    
    widget.submitTask(newTask);
    
    // Close screen FIRST
    Navigator.pop(context);
    
    // THEN show notification (no await needed)
    NotificationHelper.showNotification(
      title: 'Task Saved!',
      body: '${newTask.title} - ${newTask.duration.toInt()} minutes',
    );
  }




      @override
    Widget build(BuildContext context) {
      return SingleChildScrollView(  // ADDed THIS to make scrollable
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                maxLength: 50,
                keyboardType: TextInputType.text,
                controller: _titleController,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Duration',
                        suffixText: 'min',
                      ),
                      keyboardType: TextInputType.number,
                      controller: _durationController,
                    ),
                  ),
                  SizedBox(width: 10),  
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
                  DropdownButton(  
                    value: _selectedCategory,
                    items: TaskCategory.values
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
                  SizedBox(width: 10),  // ← Spacing
                  IconButton(
                    onPressed: _takePicture,
                    icon: Icon(Icons.camera_alt),
                  ),
                  if (_photoPath != null)
                    Icon(Icons.check, color: Colors.green),
                  Spacer(),  // Push buttons to right
                ],
              ),
              
              SizedBox(height: 20),  // Spacing before buttons
              
              // BUTTONS ROW (Separate for clarity)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(  
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _submitTaskData,
                    child: Text("Save Task"),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
}
