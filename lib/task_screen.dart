// task_screen.dart
import 'package:flutter/material.dart';
import 'task.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List App'),
      ),
      body: Container(
        color: Colors.orange, // Set background color to black
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    color: tasks[index].isEditing ? Colors.grey : Colors.blue,
                    child: ListTile(
                      title: tasks[index].isEditing
                          ? TextFormField(
                              initialValue: tasks[index].name,
                              onChanged: (newName) {
                                setState(() {
                                  tasks[index].name = newName;
                                });
                              },
                            )
                          : Text(
                              tasks[index].name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      leading: const Icon(Icons.assignment_turned_in),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              setState(() {
                                tasks[index].toggleEdit();
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                tasks.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  _addTask();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Text('Add Task'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addTask() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTask = '';

        return AlertDialog(
          title: const Text('Add Task'),
          content: TextField(
            onChanged: (value) {
              newTask = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  tasks.add(Task(name: newTask));
                });
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}