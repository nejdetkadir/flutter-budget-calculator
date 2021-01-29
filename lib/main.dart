import 'package:flutter/material.dart';
import 'package:budget_calculator/shared/bottom-nav-bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Budget Calculator',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  List<Widget> pages;
  List<Color> colors;
  List<String> titles;

  @override
  void initState() {
    super.initState();
    pages = [createView(), dataTableView(), detailsView()];
    colors = [Colors.green, Colors.yellow.shade900, Colors.brown];
    titles = ["Create", "Data Table", "Details"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors[currentIndex],
        title: Text(titles[currentIndex]),
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: titles[currentIndex],
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_chart),
            label: titles[currentIndex],
            backgroundColor: Colors.yellow.shade900,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: titles[currentIndex],
              backgroundColor: Colors.brown)
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
    );
  }

  createView() {
    return Center(
      child: Text("createView"),
    );
  }

  dataTableView() {
    return Center(
      child: Text("dataTableView"),
    );
  }

  detailsView() {
    return Center(
      child: Text("detailsView"),
    );
  }
}
