import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/database/task_db.dart';

class TaskDataProvider extends ChangeNotifier {
  Box<Task> taskBox = Hive.box<Task>('task_db');

//method to return all the tasks.
  List<Task> getAllTasks() {
    return taskBox.values
        .toList(); //getting the values from the db & converting them to a list.
  }

  //add a task to a list
  addTask(String taskName) {
    Task task = Task();
    task.id =
        DateTime.now().toString(); //generating id based on current date time.
    task.title = taskName;
    taskBox.add(task);
    notifyListeners();
  }

  //update already existing task
  updateTask(int index, String taskName) {
    Task updatedTask = Task();
    updatedTask.id = DateTime.now().toString();
    updatedTask.title = taskName;
    taskBox.putAt(index, updatedTask);
  }

  //remove a task from the list
  removeTask(int index) {
    taskBox.deleteAt(index);
    notifyListeners();
  }
}
