part of tetris;

int blockWidth = 20;

class Game {
  // The component provided to mount our game into
  html.Element parent;
  // The container of our game
  html.DivElement tetrisContainer;

  Board tetrisBoard;
  Stats tetrisStats;

  int _rows;
  int _cols;

  /// [_paused] will kill the game tick.
  bool _paused = false;
  bool _debug = false;

  // the clock used to advance the pieces
  async.Timer _roundTimer;

  Piece activePiece;

  final math.Random rand = new math.Random();

  Game(this.parent, {int rows: 40, cols: 20, debug: false}) {
    this._rows = rows;
    this._cols = cols;
    this._debug = debug;

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

  pause() {
    _roundTimer.cancel();
  }

  resume() {
    _roundTimer?.cancel();
    _roundTimer = new async.Timer.periodic(new Duration(seconds: 1), _advancePiece);
  }

  renderGame([_]) {
    tetrisBoard.redrawPieces(activePiece);

    // Queue up the next frame
    html.window.animationFrame.then(renderGame);
  }

  // will move the piece down a row.
  _advancePiece(_) {
    bool moveSuccessful = activePiece.moveDown(tetrisBoard.boardArray);
    print('moving down, success: $moveSuccessful');
    if (!moveSuccessful) {
      // save the piece off into the board.
      tetrisBoard.commitPiece(activePiece);

      // span a new piece.
      _spawnPiece();
    }
  }

  _spawnPiece() {
    // int fate = rand.nextInt(6);
    // if (fate == 0) {
    activePiece = new IPiece((this._cols / 2).floor());
    // } else {
    //   activePiece = new LPiece((this._cols / 2).floor());
    // }
  }

  _intializeContainer() {
    this.tetrisContainer = new html.DivElement();

    tetrisContainer.setAttribute('class', 'tetris-container');
    tetrisContainer.style.setProperty('width', '${this._cols * blockWidth + 100}px');

    this.parent.append(tetrisContainer);
  }
}
