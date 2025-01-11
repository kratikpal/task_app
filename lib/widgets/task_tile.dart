import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks/constants/color_constants.dart';
import 'package:tasks/models/task_model.dart';

class TaskTile extends StatelessWidget {
  final TaskModel task;
  final Function(bool, TaskModel) onToDoChanged; // Update the callback type
  final Function(TaskModel) onDeleteItem;

  const TaskTile({
    super.key,
    required this.task,
    required this.onToDoChanged,
    required this.onDeleteItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              onToDoChanged(!task.isComplete, task);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            tileColor: Colors.white,
            leading: Icon(
              task.isComplete ? Icons.check_box : Icons.check_box_outline_blank,
              color: ColorConstants.tdBlue,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 16,
                    color: ColorConstants.tdBlack,
                    decoration:
                        task.isComplete ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  task.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorConstants.tdGrey,
                    decoration:
                        task.isComplete ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat('dd/MM/yyyy').format(task.createdAt),
                  style: const TextStyle(
                    fontSize: 12,
                    color: ColorConstants.tdGrey,
                  ),
                ),
              ],
            ),
            trailing: Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.symmetric(vertical: 12),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: ColorConstants.tdRed,
                borderRadius: BorderRadius.circular(5),
              ),
              child: IconButton(
                color: Colors.white,
                iconSize: 18,
                icon: const Icon(Icons.delete),
                onPressed: () {
                  onDeleteItem(task);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
