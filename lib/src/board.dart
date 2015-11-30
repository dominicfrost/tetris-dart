part of tetris;

class Board {
  int _rows;
  int _cols;
  html.DivElement parent;
  svg.SvgSvgElement tetrisBoard;

  Array2d<int> boardArray;

  Board(this.parent, this._rows, this._cols) {
    _createTetrisBoard();

    // creates some fake data
    boardArray = new Array2d(this._cols, this._rows, defaultValue: 0);
  }

  _createTetrisBoard() {
    tetrisBoard = new svg.SvgSvgElement();

    tetrisBoard.setAttribute('class', 'tetris-board');

    tetrisBoard.attributes['height'] = '${this._rows * blockWidth}px';
    tetrisBoard.attributes['width'] = '${this._cols * blockWidth}px';

    tetrisBoard.style.setProperty('height', '${this._rows * blockWidth}px');
    tetrisBoard.style.setProperty('width', '${this._cols * blockWidth}px');
    tetrisBoard.style.setProperty('border', '1px solid #ccc');
    tetrisBoard.style.setProperty('box-sizing', 'border-box');
    tetrisBoard.style.setProperty('float', 'left');

    this.parent.append(tetrisBoard);
  }

  // function adds the piece permanenetly to the board.
  savePiece(Piece activePiece) {
    activePiece.drawPoints.forEach((Point<int> point) {
      boardArray[point.x][point.y] = activePiece.color;
    });
  }

  redrawPieces(Piece activePiece) {
    svg.RectElement getBlock(int x, int y, int color) {
      svg.RectElement block = new svg.RectElement();
      block.attributes["x"] = (x * blockWidth).toString();
      block.attributes["y"] = (y * blockWidth).toString();
      block.attributes["height"] = blockWidth.toString();
      block.attributes["width"] = blockWidth.toString();
      block.attributes["fill"] = colorsMap[color];
      block.attributes["stroke"] = "white";
      block.attributes["stroke-width"] = "1px";
      return block;
    }
    // clear out the old blocks on the board.
    tetrisBoard.children.clear();

    // create new shiny blocks.
    var blocks = new svg.GElement();
    blocks.attributes["class"] = "blocks";
    tetrisBoard.append(blocks);
    for (var i = 0; i < boardArray.array.length; i++) {
      for (var j = 0; j < boardArray[i].length; j++) {
        if (boardArray[i][j] != 0) {
          blocks.append(getBlock(i, j, boardArray[i][j]));
        }
      }
    }

    // add blocks from the active piece
    activePiece.drawPoints.forEach((Point<int> point) {
      blocks.append(getBlock(point.x, point.y, activePiece.color));
    });
  }
}
