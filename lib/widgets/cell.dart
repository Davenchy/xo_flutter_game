import 'package:flutter/material.dart';

import '../utils/cell_value.dart';

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
