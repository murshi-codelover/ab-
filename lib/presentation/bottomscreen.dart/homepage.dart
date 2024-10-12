import 'dart:io';

import 'package:_abm/dbmodels/models.dart';
import 'package:_abm/presentation/mydrawer.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  final List<Student> studentsWithLessThanAmount;

  const HomePage({super.key, required this.studentsWithLessThanAmount});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final remainderController = TextEditingController();
  String remainder = '';
  DateTime? selectedDateremainder;
  final ImagePicker _picker = ImagePicker();
  List<File> images = [];
  List<Map<String, dynamic>> ongoingEvents = [];
  List<File> memoriesImages = [];

  final Box box = Hive.box('myBox');

  @override
  void initState() {
    super.initState();
    loadMemories();
  }

  void loadMemories() {
    List<dynamic> storedMemories = box.get('memories', defaultValue: []);
    setState(() {
      memoriesImages =
          storedMemories.map((memory) => File(memory['imagePath'])).toList();
    });
  }

  void saveMemories() {
    box.put('memories',
        memoriesImages.map((memory) => {'imagePath': memory.path}).toList());
  }

  Future<void> pickImageForMemories() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        memoriesImages.insert(0, File(image.path));
      });
      saveMemories();
    }
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        images.add(File(image.path)); // Add the picked image to the list
      });
    }
  }

  Future<void> requestPermissions() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }

    status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('A B M'),
        ),
        backgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
      ),
      drawer: MyDrawer(),
      backgroundColor: Colors.white70,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Balance',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          SizedBox(
              width: double.infinity,
              height: 160,
              //color: Colors.purple.shade100,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.grey.shade300,
                            ),
                          ),
                          Positioned(
                            bottom: -1,
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.of(context).push(
                                //     MaterialPageRoute(builder: (context)=>LessThanAmountPage(collection:Collection(title: title, amount: amount, studentList: studentList))));
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Color.fromRGBO(0, 128, 128, 1),
                                ),
                                child: Center(
                                    child: Text(
                                  'STATI\n   10',
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  })),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Memories',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.70,
              ),
              itemCount: memoriesImages.length + 1,
              itemBuilder: (context, index) {
                if (index < memoriesImages.length) {
                  return GestureDetector(
                    onLongPress: () {},
                    onTap: () {
                      onTapMemories(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: FileImage(memoriesImages[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: pickImageForMemories,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey.shade300,
                      ),
                      child:
                          Icon(Icons.add_a_photo, color: Colors.grey.shade700),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void onTapMemories(int currentIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Image.file(
              memoriesImages[currentIndex],
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  // void deleteImage(int index) {
  //   setState(() {
  //     memoriesImages.removeAt(index); // Remove image from list
  //     isLongPressed.removeAt(index); // Remove from isLongPressed list
  //   });
  //   saveMemories(); // Update Hive storage
  // }
}
