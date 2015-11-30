part of tetris;

/**
 *  __
 * |  |
 * |  |
 * |  |
 * |  |
 * |  |
 *  ‾‾
 **/

class LinePiece extends Piece {
  LinePiece(midPoint) : super(midPoint);

  moveLeft(Array2d board);

  moveRight(Array2d board) {
    // first check if you can move right
    //     we are at the bottom of the board
    if (location.x == board.array.length - 1) return false;
    //     we will run into another piece.
    if (board[location.x + 1][location.y] != 0) return false;
    if (location.y >= 1 && board[location.x + 1][location.y - 1] != 0) return false;
    if (location.y >= 2 && board[location.x + 1][location.y - 2] != 0) return false;
    if (location.y >= 3 && board[location.x + 1][location.y - 3] != 0) return false;
    if (location.y >= 4 && board[location.x + 1][location.y - 4] != 0) return false;

    // Now move right
    location.x++;

    return true;
  }

  bool moveDown(Array2d board) {
    // first check if we can move down
    //     we are at the bottom of the board
    if (location.y == board[location.x].length - 1) return false;
    //     we will run into another piece.
    if (board[location.x][location.y + 1] != 0) return false;

    // Now move down
    location.y++;
    return true;
  }

  rotateClockwise(Array2d board);

  rotateCounterClockwise(Array2d board);

  moveToBottom(Array2d board);

  List<Point<int>> get drawPoints {
    if (rotation == Rotation.zero || rotation == rotation.one_eighty) {
      var points = new List();
      if (location.y >= 0) points.add(new Point(location.x, location.y));
      if (location.y >= 1) points.add(new Point(location.x, location.y - 1));
      if (location.y >= 2) points.add(new Point(location.x, location.y - 2));
      if (location.y >= 3) points.add(new Point(location.x, location.y - 3));
      if (location.y >= 4) points.add(new Point(location.x, location.y - 4));
      return points;
    }
    return new List();
  }

  int get color => 1;
}
