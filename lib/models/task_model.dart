class TaskModel {
  String id;
  String title;
  String description;
  DateTime createdAt;
  bool isComplete;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.isComplete,
  });

  // Convert a TaskModel to a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'isComplete': isComplete,
    };
  }

  // Convert a map to a TaskModel
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'].toString(),
      title: json['title'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toString()),
      isComplete: json['isComplete'] ?? json['completed'] ?? false,
    );
  }
}
