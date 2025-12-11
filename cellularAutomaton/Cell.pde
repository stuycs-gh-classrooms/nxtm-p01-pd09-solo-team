class Cell {
  int cols, rows;         
  int cellSize;
  int[][] grid;
  int[][] nextGrid;
  int live = 1;
  int dead = 0;

  Cell(int numCols, int numRows, int cs, float density) {
    cols = numCols;
    rows = numRows;
    cellSize = cs;
    grid = new int[cols][rows];
    nextGrid = new int[cols][rows];
    dens(density);
  }

  void dens(float density) {
    for (int r = 0; r < cols; r++) {
      for (int c = 0; c < rows; c++) {
        if (random(2) > density) {
          grid[r][c] = dead; 
        }else{
          grid[r][c] = live;
        }
      }
    }
  }

  int countNeighbors(int x, int y) {
    int sum = 0;
    for (int r = -1; r <= 1; r++) {
      for (int c = -1; c <= 1; c++) {
        if (!(r == 0 && c == 0)) {
          int nx = abs((x + r) % cols);
          int ny = abs((y + c) % rows);
          sum += grid[nx][ny];
        }
      }
    }
    return sum;
  }

//funny NW gliding
  int countNW(int x, int y) {
    int sum = 0;
    for (int r = 0; r <= 2; r++) {
      for (int c = 0; c <= 2; c++) {
        if (!(r == 1 && c == 1)) {
          int nx = ((x + r) % cols);
          int ny = ((y + c) % rows);
          sum += grid[nx][ny];
        }
      }
    }
    return sum;
  }

  void display() {
    for (int r = 0; r < cols; r++) {
      for (int c = 0; c < rows; c++) {
        if (grid[r][c] == live) {
          fill(255);
        }else if (grid[r][c] == dead){ 
          fill(0);
        }
        noStroke();
        rect(r * cellSize, c * cellSize, cellSize, cellSize);
      }
    }
  }
  
  int conway(int state, int neighbors) {
      if ((state == live && (neighbors == 2 || neighbors == 3)) ||
          (state == dead && neighbors == 3)) {
        return 1;
      }return 0;
  }

  void nextGen() {
    for (int r = 0; r < cols; r++) {
      for (int c = 0; c < rows; c++) {
        int neighbors = countNeighbors(r, c);
        nextGrid[r][c] = conway(grid[r][c], neighbors);
      }
    }
    int[][] buffer = grid;
    grid = nextGrid;
    nextGrid = buffer;
  }
  
}
