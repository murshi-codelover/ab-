import 'package:hive/hive.dart';

part 'db_models.g.dart'; // Run `flutter packages pub run build_runner build` to generate this file

@HiveType(typeId: 1)
class Reminder {
  @HiveField(0)
  String text;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  bool isCompleted;

  Reminder({required this.text, required this.date, this.isCompleted = false});
}

@HiveType(typeId: 1)
class OngoingEvent {
  @HiveField(0)
  String imagePath;

  @HiveField(1)
  DateTime expiryDate;

  OngoingEvent({required this.imagePath, required this.expiryDate});
}

@HiveType(typeId: 2)
class Memory {
  @HiveField(0)
  String imagePath;

  Memory({required this.imagePath});
}
