import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  Todo({required this.todo, this.isComplete = false, this.id = ''});
  final String id;
  final String todo;
  bool isComplete = false;

  Todo copyWith({String? todo, bool? isComplete}) {
    return Todo(todo: this.todo, isComplete: this.isComplete);
  }

  @override
  List<Object?> get props => [todo];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todo': todo,
      'isComplete': isComplete,
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
        todo: json['todo'], isComplete: json['isComplete'], id: json['id']);
  }
}
