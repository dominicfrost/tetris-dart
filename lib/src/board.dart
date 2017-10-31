part of tetris;

/// [Board] is an object that maintains a model of the board state as well as the elements
/// required for rendering it.
class Board {
  int _rows;
  int _cols;
  html.DivElement parent;
  svg.SvgSvgElement tetrisBoard;

  /// [boardArray] descibes the state of the board. When peices are committed, they
  /// are added to this model. The (0,0) coordinate is the top left square of the board.
  List<List<PieceType>> boardArray;

  Board(this.parent, this._rows, this._cols) {
    _initializeTetrisBoardUi();

    // initialize board with provided dimensions.
    // [[(0,0), (0,1)],
    //  [(1,0), (1,1)]]
    // x == row
    // y == col
    boardArray = new List<List<PieceType>>(_cols);
    for (var x = 0; x < _cols; x++) {
      boardArray[x] = new List<PieceType>(_rows);
      for (var y = 0; y < _rows; y++) {
        boardArray[x][y] = PieceType.none;
      }
    }
  }

  /// [_initializeTetrisBoardUi] initializes the tetris board svg and appends it into
  /// it's parent.
  void _initializeTetrisBoardUi() {
    tetrisBoard = new svg.SvgSvgElement();

    tetrisBoard.setAttribute('class', 'tetris-board');

    tetrisBoard.attributes['height'] = '${this._rows * blockWidth}px';
    tetrisBoard.attributes['width'] = '${this._cols * blockWidth}px';

    tetrisBoard.style.setProperty('height', '${this._rows * blockWidth}px');
    tetrisBoard.style.setProperty('width', '${this._cols * blockWidth}px');
    tetrisBoard.style.setProperty('border', '1px solid #ccc');
    tetrisBoard.style.setProperty('box-sizing', 'border-box');
    tetrisBoard.style.setProperty('float', 'left');
    tetrisBoard.style.setProperty('fill', 'light-grey');

    this.parent.append(tetrisBoard);
  }

  /// [commitPiece] will commit the points of the currently active piece to the board.
  void commitPiece(Piece activePiece) {
    activePiece.getDrawPoints().forEach((Point<int> point) {
      boardArray[point.x][point.y] = activePiece.type;
    });
  }

  // Draws all the blocks that exist in the blocksArray,
  // and then draws the blocks from the active piece.
  // (since they do not exist in the blocksArray)
  void redrawPieces(Piece activePiece) {
    svg.RectElement getBlock(int x, int y, PieceType type) {
      svg.RectElement block = new svg.RectElement();
      block.attributes["x"] = (x * blockWidth).toString();
      block.attributes["y"] = (y * blockWidth).toString();
      block.attributes["height"] = blockWidth.toString();
      block.attributes["width"] = blockWidth.toString();
      block.attributes["fill"] = getColorForPiece(type);
      block.attributes["stroke"] = "white";
      block.attributes["stroke-width"] = "1px";
      return block;
    }

    // clear out the old blocks on the board.
    tetrisBoard.children.clear();

    // add all blocks that have been committed to the board.
    var blocks = new svg.GElement();
    blocks.attributes["class"] = "blocks";
    for (var i = 0; i < boardArray.length; i++) {
      for (var j = 0; j < boardArray[i].length; j++) {
        if (boardArray[i][j] != 0) {
          blocks.append(getBlock(i, j, boardArray[i][j]));
        }
      }
    }

    // add blocks from the active piece
    activePiece.getDrawPoints().forEach((Point<int> point) {
      blocks.append(getBlock(point.x, point.y, activePiece.type));
    });

    tetrisBoard.append(blocks);
  }
}
