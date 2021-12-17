import 'dart:developer';

import 'package:flutter/material.dart';

import 'cell.dart';

class XOBoard extends StatelessWidget {
  const XOBoard({
    Key? key,
    required this.controller,
    required this.onCellTap,
  }) : super(key: key);

  final XOBoardController controller;
  final void Function(int index) onCellTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: LayoutBuilder(builder: (context, box) {
        return SizedBox(
          width: box.maxWidth,
          height: box.maxWidth,
          child: AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                final board = controller.getBoard();
                log('rebuild board: ${board[0]}');
                return GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  shrinkWrap: true,
                  children: [
                    for (int i = 0; i < board.length; i++)
                      GestureDetector(
                        onTap: () => onCellTap(i),
                        child: Cell(
                          width: box.maxWidth / 3,
                          value: board[i],
                        ),
                      ),
                  ],
                );
              }),
        );
      }),
    );
  }
}

class XOBoardController extends ChangeNotifier {
  final List<CellValue> _board = List<CellValue>.filled(9, CellValue.empty);

  List<CellValue> getBoard() => List.unmodifiable(_board);

  CellValue getCellValue(int index) => _board[index];

  void setCellValue(int index, CellValue value) {
    if (_board[index] == value) return;
    _board[index] = value;
    notifyListeners();
  }

  void resetBoard() {
    for (int i = 0; i < _board.length; i++) {
      _board[i] = CellValue.empty;
    }
    notifyListeners();
  }
}
