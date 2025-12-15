class Cell {
  int cols, rows;
  int cellSize;
  int[][] grid;
  int[][] nextGrid;
//states
  int live = 1;
  int dead = 0;
//rules
  int[] b;
  int[] s;

  Cell(int numCols, int numRows, int cs, float density) {
    cols = numCols;
    rows = numRows;
    cellSize = cs;
    grid = new int[cols][rows];
    nextGrid = new int[cols][rows];
    dens(density);
  }

//random setup
  void dens(float density) {
    for (int r = 0; r < cols; r++) {
      for (int c = 0; c < rows; c++) {
        if (random(2) > density) {
          grid[r][c] = dead;
        } else {
          grid[r][c] = live;
        }
      }
    }
  }

//moore neighborhood - 8 neighbors
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
          if (PINKMODE == true) {
            fill(#FFC0CB);
          }
        } else if (grid[r][c] == dead) {
          fill(0);
        }
        noStroke();
        rect(r * cellSize, c * cellSize, cellSize, cellSize);
      }
    }
  }

//conway's game of life rules
  int conway(int state, int neighbors) {
    if ((state == live && (neighbors == 2 || neighbors == 3)) ||
      (state == dead && neighbors == 3)) {
      return 1;
    } else if (PINKMODE == true) {
      if ((state == live && (neighbors == 4 || neighbors == 2)) ||
        (state == live && neighbors == 3)) {
        return 1;
      }
    }
    return 0;
  }

//conway generation
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

//general formula ? not sure if it works

int birth(int[] num, int neighbors) {
    int[] bnum = b;
    for (r=0; r< b.length; r++) {
      if (neighbors == bnum[r]) { 
        return 1;
      }
      return 0;
      int sum;
      sum+= bnum[r];
    }
    if (sum >= 1) {
      return 1;
    }return 0;
  }
  
  int survive(int[] num, int neighbors) {
    int[] snum = s;
    for (r=0; r< b.length; r++) {
      if (neighbors >= s[r]) {
        return 1;
      }return 0;
      int sum;
      sum+= snum[r];
    }
    if (sum >= 1) {
      return 1;
    }return 0;
  }
  
  int gameRule(int state, int[] b, int[] s, int nb) {
    int b;
    int s;
    if (state == live) {
      b = birth(b, nb);
      return b;
    } 
    if (state == dead) {
      s = survive(s, nb);
      return s;
    }
    return 0;
  }  
  
 void testGen() {
    for (int r = 0; r < cols; r++) {
      for (int c = 0; c < rows; c++) {
        int neighbors = countNeighbors(r, c);
        nextGrid[r][c] = gameRule(grid[r][c], b, s, neighbors);
      }
    }
    int[][] buffer = grid;
    grid = nextGrid;
    nextGrid = buffer;
  }

}
