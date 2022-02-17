import 'package:flutter/material.dart';
import 'package:golab/model/model_pages.dart';
import 'package:golab/ui/mypage/student/page_student.dart';

import 'home.dart';


class StudentHome extends StatefulWidget {
  const StudentHome({Key? key}) : super(key: key);

  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> with SingleTickerProviderStateMixin{

  final List<Pages> _pages = [
    Pages(Icons.home, const Home()),
    Pages(Icons.person, const StudentPage()),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _pages.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Material(
        color: const Color.fromRGBO(240, 240, 240, 100),
        child: TabBar(
          indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(width: 0)
          ),
          controller: _tabController,
          tabs: _pages.map((Pages tab) => Tab(child: Icon(tab.icon))).toList(),
          labelColor: Colors.blueAccent,
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: _pages.map((tab) => tab.widget).toList(),
        ),
      ),
    );
  }
}
