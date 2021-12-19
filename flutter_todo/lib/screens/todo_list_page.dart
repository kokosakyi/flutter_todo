import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/models/task_model.dart';

class TodoListPage extends StatelessWidget {
  TodoListPage({Key? key}) : super(key: key);

  final TextEditingController _textController = TextEditingController();

  void _addTask() {
    FirebaseFirestore.instance.collection("todos").add(
      {
        "title": _textController.text,
      },
    );
    _textController.text = "";
  }

  void _deleteTask(Task task) async {
    await FirebaseFirestore.instance
        .collection("todos")
        .doc(task.taskId)
        .delete();
  }

  Widget _buildListItem(Task task) {
    return Dismissible(
      key: Key(task.taskId!),
      onDismissed: (direction) {
        _deleteTask(task);
      },
      background: Container(
        color: Colors.pink,
      ),
      child: ListTile(
        title: Text(task.title),
      ),
    );
  }

  Widget _buildList(QuerySnapshot snapshot) {
    return ListView.builder(
        itemCount: snapshot.docs.length,
        itemBuilder: (context, index) {
          final doc = snapshot.docs[index];
          final task = Task.fromDocumentSnapshot(doc);
          return _buildListItem(task);
          return ListTile(
            title: Text(task.title),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('To do List'),
            ],
          ),
        ),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        const Text(
          'Adwuma',
          style: TextStyle(fontSize: 30),
        ),
        const SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(hintText: 'Add task...'),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        MaterialButton(
          color: Colors.orange,
          onPressed: () {
            _addTask();
          },
          child: const Text(
            'Add Task',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("todos").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const LinearProgressIndicator();
            }
            return Expanded(
              child: _buildList(snapshot.data!),
            );
          },
        ),
      ],
    );
  }
}
