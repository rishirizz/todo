import 'package:hive/hive.dart';
part 'task_db.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? title;
}
