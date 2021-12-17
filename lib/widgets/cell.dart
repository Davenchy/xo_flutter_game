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

class Cell extends StatefulWidget {
  const Cell({
    Key? key,
    this.initialValue,
    required this.width,
    required this.onPressed,
  }) : super(key: key);

  final double width;
  final CellValue? initialValue;
  final CellValue? Function(CellValue lastValue) onPressed;

  @override
  State<Cell> createState() => _CellState();
}

class _CellState extends State<Cell> {
  late CellValue _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue ?? CellValue.empty;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: () {
          final newValue = widget.onPressed(_value);
          if (newValue != null && newValue != _value) {
            setState(() => _value = newValue);
          }
        },
        child: Container(
          width: widget.width,
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: mapCellValueToColor(_value),
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          child: Text(
            mapCellValueToString(_value),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
        ),
      ),
    );
  }
}
