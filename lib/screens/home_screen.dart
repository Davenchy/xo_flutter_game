import 'package:flutter/material.dart';

import '../widgets/cell.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cellWidth = screenWidth / 3;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: cellWidth * 3,
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                shrinkWrap: true,
                children: [
                  for (int i = 0; i < 9; i++)
                    Cell(
                      width: cellWidth,
                      initialValue: i % 2 == 0 ? CellValue.x : CellValue.o,
                      onPressed: (_) =>
                          _ == CellValue.x ? CellValue.o : CellValue.x,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
