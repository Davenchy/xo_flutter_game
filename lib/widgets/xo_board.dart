import 'package:flutter/material.dart';

import 'cell.dart';
import '../controllers/board_controller.dart';

class XOBoard extends StatelessWidget {
  const XOBoard({
    Key? key,
    required this.controller,
    required this.onCellTap,
  }) : super(key: key);

  final BoardController controller;
  final void Function(int index) onCellTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: LayoutBuilder(builder: (context, box) {
        return SizedBox(
          width: box.maxWidth,
          height: box.maxWidth,
          child: AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                final board = controller.getBoard();

                return GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  shrinkWrap: true,
                  children: [
                    for (int i = 0; i < board.length; i++)
                      GestureDetector(
                        onTap: () => onCellTap(i),
                        child: Cell(
                          width: box.maxWidth / 3,
                          value: board[i],
                        ),
                      ),
                  ],
                );
              }),
        );
      }),
    );
  }
}
