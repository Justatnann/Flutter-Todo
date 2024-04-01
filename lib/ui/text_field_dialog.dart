import 'package:decoy/repo/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void showAddDialog(BuildContext context, Function addTodo) {
  showDialog(
      context: context,
      builder: (context) {
        TextEditingController controllerText = TextEditingController();
        return AlertDialog(
          title: const Text('Add Text'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controllerText,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    hintText: "Enter your text",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey))),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                addTodo(Todo(
                  id: const Uuid().v4(),
                  todo: controllerText.text,
                  isComplete: false,
                ));
                controllerText.clear();
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: const Text("Add")),
            ),
          ],
        );
      });
}
