import 'dart:math';

import 'package:flutter/material.dart';

import 'board_controller.dart';
import '../utils/cell_value.dart';

class GameController extends ChangeNotifier {
  GameController(this.boardController) {
    randomStart();
  }

  BoardController boardController;
  bool _isPlayerXTurn = true;
  CellValue _winner = CellValue.empty;

  bool get isPlayerXTurn => _isPlayerXTurn;
  bool get hasWinner => _winner != CellValue.empty;
  CellValue get winner => _winner;

  void randomStart() {
    _isPlayerXTurn = Random().nextBool();
    notifyListeners();
  }

  void changeTurn() {
    _isPlayerXTurn = !_isPlayerXTurn;
    notifyListeners();
  }

  /// restart the game and choose player to start
  ///
  /// use random player if [randomPlayer] is true (**default**)
  ///
  /// use [player] __y__ if [randomPlayer] is false,
  /// __y__ is the [CellValue] to start with
  ///
  /// use last winner if [hasWinner]
  ///
  /// finally set player to `CellValue.x` if all above is false
  ///
  void restartGame({bool randomPlayer = true, CellValue? player}) {
    if (randomPlayer) {
      randomStart();
    } else if (player != null) {
      _isPlayerXTurn = player == CellValue.x;
    } else if (hasWinner) {
      _isPlayerXTurn = _winner == CellValue.x;
    } else {
      _isPlayerXTurn = true;
    }

    _winner = CellValue.empty;
    boardController.resetBoard();
    notifyListeners();
  }

  void onCellTap(int index) {
    final oldValue = boardController.getCellValue(index);
    if (oldValue != CellValue.empty) return;

    late CellValue newValue;
    if (isPlayerXTurn) {
      newValue = CellValue.x;
    } else {
      newValue = CellValue.o;
    }

    changeTurn();
    boardController.setCellValue(index, newValue);
  }

  void checkWinner() {
    // TODO: add game logic
  }
}
