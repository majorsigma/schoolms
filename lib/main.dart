import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schoolms/pages/home_page.dart';
import 'package:schoolms/utils/schoolms_colors.dart';

void main() async {
  runApp(const SchoolMsApp());
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}

class SchoolMsApp extends StatefulWidget {
  const SchoolMsApp({super.key});

  @override
  State<SchoolMsApp> createState() => _SchoolMsAppState();
}

class _SchoolMsAppState extends State<SchoolMsApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primaryColorDark: SchoolMsColors.primary,
          backgroundColor: SchoolMsColors.primary,
          accentColor: SchoolMsColors.primary,
          primarySwatch: Colors.blue,
        ),
      ),
      home: const HomePage(),
    );
  }
}
