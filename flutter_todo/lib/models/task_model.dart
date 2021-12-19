import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String title;
  String? taskId;

  Task(this.title, [this.taskId]);

  factory Task.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    return Task(snapshot["title"], snapshot.id);
  }
}
