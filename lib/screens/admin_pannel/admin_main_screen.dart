import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Admin_Main_Screen extends StatefulWidget {
  const Admin_Main_Screen({super.key});

  @override
  State<Admin_Main_Screen> createState() => _Admin_Main_ScreenState();
}

class _Admin_Main_ScreenState extends State<Admin_Main_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin pannel"),
      ),
    );
  }
}
