import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'Screens/sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

//import 'Theme/theme.dart';

const Map<int, Color> colorSwatch = {
  50: Color(0xFFE0F2E9),
  100: Color(0xFFB2E1C7),
  200: Color(0xFF80CDA3),
  300: Color(0xFF4B8D5F),
  400: Color(0xFF388A52),
  500: Color(0xFF007A3D),
  600: Color(0xFF006A34),
  700: Color(0xFF005A2C),
  800: Color(0xFF004A24),
  900: Color(0xFF003A1C),
};

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    // Change default factory on the web
    databaseFactory = databaseFactoryFfiWeb;
  } else if (defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.linux) {
    // Initialize FFI for Windows/Linux
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  } else {
    // Use the normal sqflite for mobile platforms (Android, iOS)
    databaseFactory = databaseFactory;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My page',
      theme: ThemeData(
        //primarySwatch: Colors.green,
        primarySwatch: const MaterialColor(0xFF4B8D5F, colorSwatch),
        //inputDecorationTheme: MyInputDecorationTheme().myInputDecorationTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: const Sign_In(),
    );
  }
}
