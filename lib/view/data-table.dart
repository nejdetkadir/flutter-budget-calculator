import 'package:flutter/material.dart';
import 'package:budget_calculator/main.dart';

class DataTableView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DataTableView();
}

class _DataTableView extends State<DataTableView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: MyHomePage.listData.length,
          itemBuilder: (context, index) {
            return Dismissible(
              onDismissed: (direction) {
                setState(() {
                  MyHomePage.listData.removeAt(index);
                  MyHomePage.calculateData();
                });
              },
              direction: DismissDirection.startToEnd,
              key: Key(MyHomePage.listData[index].id.toString()),
              child: Card(
                elevation: 8,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: MyHomePage.listData[index].type == "+"
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  child: ListTile(
                    title: Text(MyHomePage.listData[index].description),
                    trailing: Text(
                      "${MyHomePage.listData[index].type} ${MyHomePage.listData[index].amount.toString()}",
                      style: TextStyle(
                          color: MyHomePage.listData[index].type == "+"
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
