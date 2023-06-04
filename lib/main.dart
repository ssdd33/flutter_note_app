import 'package:flutter/material.dart';
import 'package:flutter_note_app/presentation/notes/notes_screen.dart';
import 'package:flutter_note_app/ui/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.white,
            canvasColor: darkgrey,
            floatingActionButtonTheme:
                Theme.of(context).floatingActionButtonTheme.copyWith(
                      backgroundColor: Colors.white,
                      foregroundColor: darkgrey,
                    ),
            appBarTheme: Theme.of(context)
                .appBarTheme
                .copyWith(backgroundColor: darkgrey)),
        home: const NotesScreen());
  }
}
