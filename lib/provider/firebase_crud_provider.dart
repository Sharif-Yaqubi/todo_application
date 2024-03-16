import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/model/todo_model.dart';

final provider =
    StateProvider<FirebaseCrudProvider>((ref) => FirebaseCrudProvider());
final fetchData = StreamProvider<List<TodoModel>>((ref) async* {
  final getData = FirebaseFirestore.instance
      .collection('todoApp')
      .snapshots()
      .map((event) => event.docs
          .map((snapshot) => TodoModel.fromSnapshot(snapshot))
          .toList());
  yield* getData;
});

class FirebaseCrudProvider {
  FirebaseCrudProvider();
  final todoCollection = FirebaseFirestore.instance.collection('todoApp');

  void addNewTask(TodoModel todoModel) => todoCollection.add(todoModel.toMap());

  void updateTask(String? id, bool? isDone) =>
      todoCollection.doc(id).update({'isDone': isDone});

  void deleteTask(String? id) => todoCollection.doc(id).delete();
}
