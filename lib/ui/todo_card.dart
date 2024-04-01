import 'package:decoy/bloc/todo_bloc.dart';
import 'package:decoy/repo/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatefulWidget {
  TodoTile({super.key, required this.todo, this.index = 0});
  final Todo todo;
  int index;

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  @override
  Widget build(BuildContext context) {
    alertTodo(String id) {
      context.read<TodoBloc>().add(UpdateTodo(id));
    }

    removeTodo(String id) {
      context.read<TodoBloc>().add(RemoveTodo(id));
    }

    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) => Card(
        margin: const EdgeInsets.all(10),
        color: const Color.fromARGB(255, 234, 234, 234),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Slidable(
              key: const ValueKey([0]),
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: <Widget>[
                  SlidableAction(
                    onPressed: (context) {
                      removeTodo(widget.todo.id);
                    },
                    icon: Icons.delete,
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    label: 'Delete',
                  ),
                ],
              ),
              child: Container(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    widget.todo.todo,
                    softWrap: true,
                  ),
                  trailing: Checkbox(
                    value: widget.todo.isComplete,
                    onChanged: (value) {
                      // Add Value isCompleted
                      alertTodo(widget.todo.id);
                    },
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
