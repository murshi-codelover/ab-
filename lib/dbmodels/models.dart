import 'package:hive/hive.dart';

part 'models.g.dart';

@HiveType(typeId: 0)
class Student {
  @HiveField(0)
  String name;

  @HiveField(1)
  bool isSelected;

  @HiveField(2)
  String paymentMethod;

  @HiveField(3)
  String? balance;

  // @HiveField(4)
  // List<Student> studentsWithLessThanAmount;

  Student({
    required this.name,
    this.isSelected = false,
    this.paymentMethod = '',
    this.balance,
    // required this.studentsWithLessThanAmount,
  });
}

@HiveType(typeId: 1)
class Collection extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String amount;

  @HiveField(2)
  List<Student> studentList;

  Collection({
    required this.title,
    required this.amount,
    required this.studentList,
  });
}
