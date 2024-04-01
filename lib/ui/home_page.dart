import 'package:decoy/bloc/todo_bloc.dart';
import 'package:decoy/repo/todo_model.dart';
import 'package:decoy/ui/text_field_dialog.dart';
import 'package:decoy/ui/todo_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    addTodo(Todo todo) {
      context.read<TodoBloc>().add(AddTodo(todo));
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAddDialog(context, addTodo);
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          title: const Text("Your Todo List"),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.pending_actions),
              ),
              Tab(
                icon: Icon(Icons.done),
              )
            ],
          ),
        ),
        body: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            var unfinishedTodos =
                state.todos.where((element) => !element.isComplete).toList();
            var finishedTodos =
                state.todos.where((element) => element.isComplete).toList();
            if (state.status == TodoStatus.success) {
              return TabBarView(
                children: [
                  ListView.builder(
                    itemCount:
                        unfinishedTodos.isEmpty ? 1 : unfinishedTodos.length,
                    itemBuilder: (context, int i) {
                      if (unfinishedTodos.isEmpty) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: const Center(
                              child: Text("No Unfinished Todo! Grats!")),
                        );
                      } else {
                        return TodoTile(
                          todo: unfinishedTodos[i],
                          index: i,
                        );
                      }
                    },
                  ),
                  ListView.builder(
                    itemCount: finishedTodos.isEmpty ? 1 : finishedTodos.length,
                    itemBuilder: (context, int i) {
                      if (finishedTodos.isEmpty) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: const Center(
                              child: Text("Better Start Working!")),
                        );
                      } else {
                        return TodoTile(
                          todo: finishedTodos[i],
                          index: i,
                        );
                      }
                    },
                  ),
                ],
              );
            } else if (state.status == TodoStatus.loading &&
                state.todos.isEmpty) {
              return const Center(
                child: Text("No Data Found"),
              );
            } else if (state.status == TodoStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text("Something went wrong"),
              );
            }
          },
        ),
      ),
    );
  }
}
