import 'package:flutter/material.dart';

import '../widgets/cell.dart';
import '../widgets/xo_board.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final XOBoardController controller;
  bool isPlayerXTurn = true;

  @override
  void initState() {
    super.initState();
    controller = XOBoardController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text('Click a cell when it\'s your move.'),
            const Text('Player X\'s turn.'),
            XOBoard(controller: controller, onCellTap: onCellTap),
            ElevatedButton(
              child: const Text('Restart Game'),
              onPressed: controller.resetBoard,
            ),
          ],
        ),
      ),
    );
  }

  void onCellTap(int index) {
    final oldValue = controller.getCellValue(index);
    if (oldValue != CellValue.empty) return;

    late CellValue newValue;
    if (isPlayerXTurn) {
      newValue = CellValue.x;
    } else {
      newValue = CellValue.o;
    }

    isPlayerXTurn = !isPlayerXTurn;
    controller.setCellValue(index, newValue);
  }
}
