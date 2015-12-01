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

  moveLeft(Array2d board) {
    if (rotation == Rotation.zero || rotation == Rotation.one_eighty) {
      // first check if you can move left
      //     we are at the bottom of the board
      if (location.x == 0) return false;
      //     we will run into another piece.
      if (board[location.x - 1][location.y] != 0) return false;
      if (location.y >= 1 && board[location.x - 1][location.y - 1] != 0) return false;
      if (location.y >= 2 && board[location.x - 1][location.y - 2] != 0) return false;
      if (location.y >= 3 && board[location.x - 1][location.y - 3] != 0) return false;
      if (location.y >= 4 && board[location.x - 1][location.y - 4] != 0) return false;

      // Now move left
      location.x--;
    }
    return true;
  }

  moveRight(Array2d board) {
    if (rotation == Rotation.zero || rotation == Rotation.one_eighty) {
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
    }
    return true;
  }

  bool moveDown(Array2d board) {
    if (rotation == Rotation.zero || rotation == Rotation.one_eighty) {
      // first check if we can move down
      //     we are at the bottom of the board
      if (location.y == board[location.x].length - 1) return false;
      //     we will run into another piece.
      if (board[location.x][location.y + 1] != 0) return false;

      // Now move down
      location.y++;
    }
    if (rotation == Rotation.ninty || rotation == Rotation.two_seventy) {
      // first check if we can move down
      //     we are at the bottom of the board
      if (location.y == board[location.x].length - 1) return false;
      //     we will run into another piece.
      if (location.x >= 1 && board[location.x][location.y + 1] != 0) return false;
      if (location.x >= 1 && board[location.x + 1][location.y + 1] != 0) return false;
      if (location.x >= 2 && board[location.x + 2][location.y + 1] != 0) return false;
      if (location.x >= 3 && board[location.x + 3][location.y + 1] != 0) return false;
      if (location.x >= 4 && board[location.x + 4][location.y + 1] != 0) return false;

      // Now move down
      location.y++;
    }
    return true;
  }

  rotateClockwise(Array2d board) {
    // TODO: add validation to rotation logic...
    rotation =
        Rotation.values[(rotation.index + Rotation.values.length + 1) % Rotation.values.length];

    // how must we modify our coodinates given out new rotation state?
    switch (rotation) {
      case Rotation.zero:
      case Rotation.one_eighty:
        location.x += 2;
        break;
      case Rotation.ninty:
      case Rotation.two_seventy:
        location.x -= 2;
        break;
      default:
        print('well, that should never happen..');
    }
  }

  rotateCounterClockwise(Array2d board) {
    // TODO add validation to this rotation logic.
    rotation =
        Rotation.values[(rotation.index + Rotation.values.length - 1) % Rotation.values.length];

    // how must we modify our coodinates given out new rotation state?
    switch (rotation) {
      case Rotation.zero:
      case Rotation.one_eighty:
        location.x += 2;
        break;
      case Rotation.ninty:
      case Rotation.two_seventy:
        location.x -= 2;
        break;
      default:
        print('well, that should never happen..');
    }
  }

  moveToBottom(Array2d board) {
    // move down, forever.
    while (moveDown(board));
  }

  List<Point<int>> getDrawPoints(Array2d board) {
    var points = new List();
    if (rotation == Rotation.zero || rotation == Rotation.one_eighty) {
      if (location.y >= 0) points.add(new Point(location.x, location.y));
      if (location.y >= 1) points.add(new Point(location.x, location.y - 1));
      if (location.y >= 2) points.add(new Point(location.x, location.y - 2));
      if (location.y >= 3) points.add(new Point(location.x, location.y - 3));
      if (location.y >= 4) points.add(new Point(location.x, location.y - 4));
      return points;
    }

    if (rotation == Rotation.ninty || rotation == Rotation.two_seventy) {
      if (location.y >= 0) points.add(new Point(location.x, location.y));
      if (location.y >= 0) points.add(new Point(location.x + 1, location.y));
      if (location.y >= 0) points.add(new Point(location.x + 2, location.y));
      if (location.y >= 0) points.add(new Point(location.x + 3, location.y));
      if (location.y >= 0) points.add(new Point(location.x + 4, location.y));
      return points;
    }

    return points;
  }

  int get color => 1;
}
