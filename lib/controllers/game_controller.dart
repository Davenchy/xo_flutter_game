import 'dart:math';

import 'package:flutter/material.dart';

import 'board_controller.dart';
import '../utils/cell_value.dart';
import '../utils/game_logic.dart' as GameLogic;

class GameController extends ChangeNotifier {
  GameController({
    required this.boardController,
    this.aiAutoPlay = CellValue.empty,
  }) {
    randomStart();
  }

  CellValue aiAutoPlay;
  bool _isPlaying = true;
  BoardController boardController;
  bool _isPlayerXTurn = true;
  CellValue _winner = CellValue.empty;

  bool get isPlayerXTurn => _isPlayerXTurn;
  bool get hasWinner => _winner != CellValue.empty;
  bool get isDraw => _winner == CellValue.draw;
  CellValue get winner => _winner;
  bool get isPlaying => _isPlaying;

  CellValue get currentPlayer => _isPlayerXTurn ? CellValue.x : CellValue.o;
  String get currentPlayerString => mapCellValueToString(currentPlayer);
  Color get currentPlayerColor => mapCellValueToColor(currentPlayer);

  void randomStart() {
    _isPlayerXTurn = Random().nextBool();
    notifyListeners();
    if (aiAutoPlay == currentPlayer) aiPlay();
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
    _isPlaying = true;
    boardController.resetBoard();
    notifyListeners();
  }

  void onCellTap(int index) {
    if (!_isPlaying) return;
    if (currentPlayer == aiAutoPlay) return;

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

    checkWinner();

    if (aiAutoPlay == currentPlayer) aiPlay();
  }

  void checkWinner() {
    final winner = GameLogic.checkWinner(boardController.getBoard());
    if (winner == CellValue.draw) {
      _winner = CellValue.draw;
      _isPlaying = false;
    } else if (winner != CellValue.empty) {
      _winner = winner;
      _isPlaying = false;
      notifyListeners();
    }
  }

  void aiPlay() {
    if (hasWinner) return;

    final aiMove = GameLogic.getAiMove(
      boardController.getBoard(),
      currentPlayer,
      currentPlayer == CellValue.x ? CellValue.o : CellValue.x,
    );

    boardController.setCellValue(aiMove, currentPlayer);
    changeTurn();
    checkWinner();
  }
}
