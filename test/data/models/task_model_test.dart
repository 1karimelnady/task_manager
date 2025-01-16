import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/features/task/data/model/task_model.dart'; // تأكد من المسار الصحيح

void main() {
  group('TaskModel', () {
    final Map<String, dynamic> json = {
      'id': 1,
      'todo': 'Test Task',
      'completed': true,
    };

    test('should create a TaskModel from JSON', () {
      final taskModel = TaskModel.fromJson(json);

      expect(taskModel.id, 1);
      expect(taskModel.title, 'Test Task');
      expect(taskModel.completed, true);
    });

    test('should convert TaskModel to JSON', () {
      final taskModel = TaskModel(
        id: 1,
        title: 'Test Task',
        completed: true,
      );

      final taskJson = taskModel.toJson();

      expect(taskJson['id'], 1);
      expect(taskJson['todo'], 'Test Task');
      expect(taskJson['completed'], true);
    });

    test('should throw an exception if JSON is missing required fields', () {
      final Map<String, dynamic> incompleteJson = {
        'id': "1",
      };

      expect(
          () => TaskModel.fromJson(incompleteJson), throwsA(isA<TypeError>()));
    });
  });
}
