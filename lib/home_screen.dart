import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_tags_app/strings_grid.dart';

import 'grid_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> listOfStrings = [];
  Random rnd = Random();
  List<GridItem> gridItems = [];
  int _childCallbackIndex = 0;
  bool limitIsFound = false;

  @override
  void initState() {
    listOfStrings = _generateStringsArray(100, 25);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fillGridItemsByStrings();
    insertCounter();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      limitIsFound = false;
    });

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return StringsGrid(
              itemWidgets: limitIsFound
                  ? gridItems.sublist(0, _childCallbackIndex + 1)
                  : gridItems);
        },
      ),
    );
  }

  void fillGridItemsByStrings() {
    gridItems = listOfStrings
        .map((item) => GridItem(
              index: listOfStrings.indexOf(item),
              text: item,
              onCallback: (index) {
                setState(() {
                  if (!limitIsFound) {
                    _childCallbackIndex = index;
                    limitIsFound = true;
                  }
                });
              },
            ))
        .toList();
  }

  void insertCounter() {
    gridItems.insert(
        _childCallbackIndex,
        GridItem(
          text: '+${(gridItems.length - _childCallbackIndex)} more',
          index: _childCallbackIndex - 3,
          backgroundColor: Colors.lightGreen,
          onCallback: (index) {},
        ));
  }

  List<String> _generateStringsArray(int listSize, int strLenLimit) {
    List<String> resultList = [];
    for (int i = 0; i < listSize; i++) {
      resultList.add(generateRandomString(rnd.nextInt(strLenLimit)));
    }
    return resultList;
  }

  String generateRandomString(int len) {
    return String.fromCharCodes(
        List.generate(len, (index) => rnd.nextInt(33) + 89));
  }
}
