import 'package:flutter/material.dart';
import 'package:golab/model/model_pages.dart';
import 'package:golab/ui/mypage/researcher/page_researcher.dart';

import 'home.dart';

class ResearcherHome extends StatefulWidget {
  const ResearcherHome({Key? key}) : super(key: key);

  @override
  _ResearcherHomeState createState() => _ResearcherHomeState();
}

class _ResearcherHomeState extends State<ResearcherHome> with SingleTickerProviderStateMixin{

  final List<Pages> _pages = [
    Pages(Icons.home, const Home()),
    Pages(Icons.person, const ResearcherPage()),
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
            borderSide: BorderSide(width: 0),
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