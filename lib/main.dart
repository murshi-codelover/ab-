import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'dbmodels/models.dart';
import 'dbmodels/profile.dart';
import 'firebase_options.dart';
import 'responsive/desktop.dart';
import 'responsive/mobile.dart';
import 'responsive/responsive_layout.dart';
import 'responsive/tablet.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  void main() async {
    WidgetsFlutterBinding
        .ensureInitialized(); // Ensure bindings are initialized
    await Hive.initFlutter();

    // Only register the adapter if it hasn't been registered already
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ProfileAdapter()); // Register the Profile adapter
    }

    // Open Hive boxes
    await Hive.openBox<Profile>('profileBox');
    await Hive.openBox<Collection>('collectionsBox');
    await Hive.openBox('myBox');
    await Hive.openBox('calcHistory');

    runApp(const MyApp());
  }

  Hive.registerAdapter(StudentAdapter());
  Hive.registerAdapter(CollectionAdapter());

  // Open the necessary boxes
  await Hive.openBox<Profile>('profileBox');
  await Hive.openBox<Collection>('collectionsBox');
  await Hive.openBox('myBox');
  await Hive.openBox('calcHistory');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'A B M',
      debugShowCheckedModeBanner: false,
      home: ResponsiveLayout(
        mobileScaffold: MobileScreen(),
        tabletScaffold: TabletScreen(),
        desktopScaffold: DesktopScreen(),
      ),
    );
  }
}
