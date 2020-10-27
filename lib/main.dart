import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './screens/main_menu_screen.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintPointersEnabled = true;
  // debugPaintBaselinesEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  ErrorWidget.withDetails(
    message: 'Please Contact Developer For problem resolution',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription( label: 'Tower of Hanoi'));
    return MaterialApp(
      title: 'Tower of Hanoi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.deepOrange, accentColor: Colors.lightBlue),
      home: MainMenuScreen(),
    );
  }
}
