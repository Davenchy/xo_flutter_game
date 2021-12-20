import 'package:flutter/material.dart';

enum CellValue {
  empty,
  x,
  o,
  draw,
}

String mapCellValueToString(CellValue value) {
  switch (value) {
    case CellValue.empty:
      return 'Empty';
    case CellValue.draw:
      return 'Draw';
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
    case CellValue.draw:
      return Colors.white;
    case CellValue.x:
      return Colors.red;
    case CellValue.o:
      return Colors.blue;
  }
}

CellValue mapStringToCellValue(String value) {
  switch (value) {
    case 'Empty':
      return CellValue.empty;
    case 'Draw':
      return CellValue.draw;
    case 'X':
      return CellValue.x;
    case 'O':
      return CellValue.o;
    default:
      throw Exception('Invalid cell value: $value');
  }
}
