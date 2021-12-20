import 'cell_value.dart';

const List<List<int>> kXORules = [
  // horizontal
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  // vertical
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  // diagonals
  [0, 4, 8],
  [2, 4, 6],
];

CellValue checkWinner(List<CellValue> board) {
  for (List<int> rule in kXORules) {
    final List<CellValue> pickedItems = pickItems(board, rule);
    final bool isRepeated = isItemsRepeated(pickedItems);
    if (isRepeated) return board[rule[0]];
  }

  if (board.every((c) => c != CellValue.empty)) return CellValue.draw;

  return CellValue.empty;
}

List<T> pickItems<T>(List<T> items, List<int> indices) {
  final List<T> pickedItems = [];
  for (int i = 0; i < indices.length; i++) {
    pickedItems.add(items[indices[i]]);
  }
  return pickedItems;
}

bool isItemsRepeated<T>(Iterable<T> list) {
  for (int i = 0; i < list.length - 1; i++) {
    if (list.elementAt(i) != list.elementAt(i + 1)) {
      return false;
    }
  }
  return true;
}

int getAiMove(
  List<CellValue> board,
  CellValue winPlayer,
  CellValue lossPlayer,
) {
  int bestScore = 0;
  int bestMove = -1;

  for (int i = 0; i < board.length; i++) {
    if (board[i] != CellValue.empty) continue;

    final List<CellValue> newBoard = List.from(board);
    newBoard[i] = winPlayer;

    final score = minMaxAi(newBoard, winPlayer, lossPlayer, false);

    if (bestMove == -1 || score > bestScore) {
      bestScore = score;
      bestMove = i;
    }
  }

  return bestMove;
}

int minMaxAi(
  List<CellValue> board,
  CellValue winPlayer,
  CellValue lossPlayer,
  bool isMin,
) {
  for (int i = 0; i < board.length; i++) {
    if (board[i] != CellValue.empty) continue;

    final List<CellValue> newBoard = List.from(board);
    newBoard[i] = isMin ? lossPlayer : winPlayer;

    final CellValue winner = checkWinner(newBoard);

    if (winner == winPlayer) {
      return 10;
    } else if (winner == lossPlayer) {
      return -10;
    } else if (winner == CellValue.draw) {
      return 0;
    } else {
      return minMaxAi(newBoard, winPlayer, lossPlayer, !isMin);
    }
  }

  return 0;
}
