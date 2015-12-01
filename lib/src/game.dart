part of tetris;

int blockWidth = 20;

Map<int, String> colorsMap = {
  1: 'red',
  2: 'green',
  3: 'blue',
  4: 'yellow',
  5: 'orange',
  6: 'purple'
};

class Game {
  // The component provided to mount our game into
  html.Element parent;
  // The container of our game
  html.DivElement tetrisContainer;

  Board tetrisBoard;
  Stats tetrisStats;

  int _rows;
  int _cols;

  // the clock used to advance the pieces
  async.Timer _roundTimer;

  Piece activePiece;

  Game(this.parent, [this._rows = 50, this._cols = 20]) {
    _intializeContainer();
    tetrisBoard = new Board(this.tetrisContainer, this._rows, this._cols);
    tetrisStats = new Stats(this.tetrisContainer, this._rows);

    // setup keyboard event handlers.
    new EventHandler(this);
  }

  // called once to start the game.
  start() {
    if (_roundTimer == null) {
      _roundTimer = new async.Timer.periodic(new Duration(seconds: 1), _advancePiece);
      _spawnPiece();
      // start up the render loop
      html.window.animationFrame.then(renderGame);
    }
  }

  renderGame(_) {
    tetrisBoard.redrawPieces(activePiece);

    // Queue up the next frame
    html.window.animationFrame.then(renderGame);
  }

  // will move the piece down a row.
  _advancePiece(_) {
    bool moveSuccessful = activePiece.moveDown(tetrisBoard.boardArray);
    if (!moveSuccessful) {
      // TODO: permanently add the piece to the board
      _savePiece();

      // span a freshie.
      _spawnPiece();
    }
  }

  _spawnPiece() {
    activePiece = new LinePiece((this._cols / 2).floor());
  }

  // used to save the piece to the board after it is no longer active.
  _savePiece() {
    tetrisBoard.savePiece(activePiece);
  }

  _intializeContainer() {
    this.tetrisContainer = new html.DivElement();

    tetrisContainer.setAttribute('class', 'tetris-container');
    tetrisContainer.style.setProperty('width', '${this._cols * blockWidth + 100}px');

    this.parent.append(tetrisContainer);
  }
}
