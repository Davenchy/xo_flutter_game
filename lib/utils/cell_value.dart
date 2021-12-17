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
