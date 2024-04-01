import 'package:decoy/repo/todo_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends HydratedBloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState()) {
    on<InitialTodo>(_initialTodo);
    on<AddTodo>(_addTodo);
    on<UpdateTodo>(_updateTodo);
    on<RemoveTodo>(_removeTodo);
  }

  void _initialTodo(InitialTodo event, Emitter<TodoState> emit) {
    if (state.status == TodoStatus.success) return;
    emit(state.copyWith(todos: state.todos, status: TodoStatus.loading));
  }

  void _addTodo(AddTodo event, Emitter<TodoState> emit) {
    emit(state.copyWith(
      status: TodoStatus.loading,
    ));
    try {
      List<Todo> temp = [];
      temp.addAll(state.todos);
      temp.insert(0, event.todo);
      emit(state.copyWith(todos: temp, status: TodoStatus.success));
    } catch (e) {
      state.copyWith(status: TodoStatus.failure);
    }
  }

  void _removeTodo(RemoveTodo event, Emitter<TodoState> emit) {
    emit(state.copyWith(
      status: TodoStatus.loading,
    ));
    try {
      state.todos
          .remove(state.todos.where((element) => element.id == event.id).first);
      emit(state.copyWith(todos: state.todos, status: TodoStatus.success));
    } catch (e) {
      state.copyWith(status: TodoStatus.failure);
    }
  }

  void _updateTodo(UpdateTodo event, Emitter<TodoState> emit) {
    emit(state.copyWith(
      status: TodoStatus.loading,
    ));
    try {
      Todo todos = state.todos.where((element) => element.id == event.id).first;
      todos.isComplete = !todos.isComplete;
      emit(state.copyWith(todos: state.todos, status: TodoStatus.success));
    } catch (e) {
      state.copyWith(status: TodoStatus.failure);
    }
  }

  // Add New Edit Methods

  @override
  TodoState? fromJson(Map<String, dynamic> json) {
    return TodoState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(TodoState state) {
    return state.toJson();
  }
}
