// task.dart
class Task {
  String name;
  bool isEditing;

  Task({required this.name, this.isEditing = false});

  void toggleEdit() {
    isEditing = !isEditing;
  }
}
