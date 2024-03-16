import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? docID;
  final String titleText;
  final String description;
  final String category;
  final String dateTask;
  final String timeTask;
  final bool isDone;

  TodoModel({
    this.docID,
    required this.titleText,
    required this.description,
    required this.category,
    required this.dateTask,
    required this.timeTask,
    required this.isDone,
  });

  Map<String, dynamic> toMap() => {
        'titleText': titleText,
        'description': description,
        'category': category,
        'dateTask': dateTask,
        'timeTask': timeTask,
        'isDone': isDone,
      };

  factory TodoModel.fromMap(Map<String, dynamic> map) => TodoModel(
        docID: map['docID'] != null ? map['docID'] as String : null,
        titleText: map['titleText'] as String,
        description: map['description'] as String,
        category: map['category'] as String,
        dateTask: map['dateTask'] as String,
        timeTask: map['timeTask'] as String,
        isDone: map['isDone'] as bool,
      );

  factory TodoModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) =>
      TodoModel(
        docID: doc.id,
        titleText: doc['titleText'],
        description: doc['description'],
        category: doc['category'],
        dateTask: doc['dateTask'],
        timeTask: doc['timeTask'],
        isDone: doc['isDone'],
      );
}
