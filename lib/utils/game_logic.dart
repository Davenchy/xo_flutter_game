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

// int ai_think(List<CellValue> board) {
//   return 0;
// }
