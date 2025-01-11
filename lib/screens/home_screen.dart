import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/constants/color_constants.dart';
import 'package:tasks/models/task_model.dart';
import 'package:tasks/providers/task_provider.dart';
import 'package:tasks/widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load tasks when the app starts
    Future.delayed(Duration.zero, () {
      Provider.of<TaskProvider>(context, listen: false).loadTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      backgroundColor: ColorConstants.tdBGColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.tdBGColor,
        centerTitle: true,
        title: const Text(
          "To Do",
          style: TextStyle(color: ColorConstants.tdBlack),
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                searchBox(taskProvider),
                const SizedBox(height: 20),
                Expanded(
                  child: taskProvider.getTasks.isNotEmpty
                      ? ListView.builder(
                          itemCount: taskProvider.getTasks.length,
                          itemBuilder: (context, index) {
                            final task = taskProvider.getTasks[index];
                            return TaskTile(
                              task: task,
                              onToDoChanged: taskProvider.updateTask,
                              onDeleteItem: taskProvider.removeTask,
                            );
                          },
                        )
                      : const Center(
                          child: Text(
                            "No tasks found",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
          if (taskProvider.isLoading) ...[
            const Opacity(
              opacity: 0.7,
              child: ModalBarrier(dismissible: false, color: Colors.grey),
            ),
            const Center(
              child: CircularProgressIndicator(),
            ),
          ]
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstants.tdBlue,
        child: const Icon(Icons.add),
        onPressed: () => _showAddTaskDialog(context, taskProvider),
      ),
    );
  }

  // Refactor the searchBox to use provider
  Widget searchBox(TaskProvider taskProvider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => taskProvider.searchTask(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: ColorConstants.tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: ColorConstants.tdGrey),
        ),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, TaskProvider taskProvider) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: const Text('Add New Task'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Task Title',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                  )
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty &&
                        descriptionController.text.isNotEmpty) {
                      taskProvider.addTask(
                        TaskModel(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          title: titleController.text.trim(),
                          description: descriptionController.text.trim(),
                          createdAt: DateTime.now(),
                          isComplete: false,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter title and description'),
                        ),
                      );
                    }
                    Navigator.of(context).pop();
                  },
                  child: const Text('Add Task'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
