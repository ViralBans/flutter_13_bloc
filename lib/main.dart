import 'package:flutter/material.dart';
import 'package:flutter_13_bloc/service_provider.dart';
import 'package:flutter_13_bloc/ui/screens/bloc_screen.dart';

void main() {
  initializeServices();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BloC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BlocScreen(),
    );
  }
}