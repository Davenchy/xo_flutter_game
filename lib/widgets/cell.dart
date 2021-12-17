import 'package:flutter/material.dart';

enum CellValue {
  empty,
  x,
  o,
}

String mapCellValueToString(CellValue value) {
  switch (value) {
    case CellValue.empty:
      return '';
    case CellValue.x:
      return 'X';
    case CellValue.o:
      return 'O';
  }
}

Color mapCellValueToColor(CellValue value) {
  switch (value) {
    case CellValue.empty:
      return Colors.white;
    case CellValue.x:
      return Colors.red;
    case CellValue.o:
      return Colors.blue;
  }
}

CellValue mapStringToCellValue(String value) {
  switch (value) {
    case '':
      return CellValue.empty;
    case 'X':
      return CellValue.x;
    case 'O':
      return CellValue.o;
    default:
      throw Exception('Invalid cell value: $value');
  }
}

class Cell extends StatelessWidget {
  const Cell({
    Key? key,
    required this.width,
    required this.value,
  }) : super(key: key);

  final double width;
  final CellValue value;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        width: width,
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: mapCellValueToColor(value),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: Text(
          mapCellValueToString(value),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
      ),
    );
  }
}
