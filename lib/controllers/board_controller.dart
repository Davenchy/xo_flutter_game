import 'package:flutter/material.dart';

import '../utils/cell_value.dart';

class BoardController extends ChangeNotifier {
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
