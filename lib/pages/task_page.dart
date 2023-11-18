import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/database/task_db.dart';
import 'package:todo/state_management/task_data_provider.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  TextEditingController taskNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<TaskDataProvider>(
        builder: (BuildContext context, TaskDataProvider taskDataProvider,
                Widget? child) =>
            Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              addTaskToTasksList();
            },
            label: const Text('Add a Task'),
            icon: const Icon(Icons.add),
          ),
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('TO-DO'),
          ),
          body: ListView.builder(
            itemCount: taskDataProvider.tasks.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(
                  taskDataProvider.tasks[index].id.toString(),
                ),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: const Color(0xffff3838),
                  child: const Padding(
                    padding: EdgeInsets.only(right: 30.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                onDismissed: (direction) {
                  Provider.of<TaskDataProvider>(context, listen: false)
                      .removeTask(index);
                },
                child: ListTile(
                  title: Text(
                    taskDataProvider.tasks[index].title!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  trailing: IconButton(
                    tooltip: 'Edit Task',
                    onPressed: () {
                      editExistingTask(index, taskDataProvider.tasks[index]);
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  addTaskToTasksList() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: taskNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
              )
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('CANCEL'),
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<TaskDataProvider>(context, listen: false).addTask(
                  taskNameController.text,
                );
                taskNameController.clear();
                Navigator.pop(context);
              },
              child: const Text('SAVE'),
            ),
          ],
        );
      },
    );
  }

  editExistingTask(int index, Task task) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        TextEditingController updatedtaskNameController =
            TextEditingController();
        updatedtaskNameController.text = task.title!;
        return AlertDialog(
          title: const Text('Add a Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: updatedtaskNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
              )
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('CANCEL'),
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<TaskDataProvider>(context, listen: false)
                    .updateTask(
                  index,
                  updatedtaskNameController.text,
                );
                taskNameController.clear();
                Navigator.pop(context);
              },
              child: const Text('SAVE'),
            ),
          ],
        );
      },
    );
  }
}
