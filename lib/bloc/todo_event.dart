part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class InitialTodo extends TodoEvent {}

class AddTodo extends TodoEvent {
  final Todo todo;
  const AddTodo(this.todo);
  @override
  List<Object> get props => [todo];
}

class RemoveTodo extends TodoEvent {
  final String id;
  const RemoveTodo(this.id);
  @override
  List<Object> get props => [id];
}

class UpdateTodo extends TodoEvent {
  final String id;
  // final String todo;

  const UpdateTodo(this.id);
  @override
  List<Object> get props => [id];
}
