import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return SingleChildScrollView(
      child: Column(
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
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return const ListTile(
                title: Text("Your task here..."),
              );
            },
            itemCount: 20,
          ),
        ],
      ),
    );
  }
}
