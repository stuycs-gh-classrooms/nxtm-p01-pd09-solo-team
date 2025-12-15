class Cell {
  int cols, rows;
  int cellSize;
  int[][] grid;
  int[][] nextGrid;
//states
  int live = 1;
  int dead = 0;
//rules
  int[] bMin;
  int[] bMax;
  int[] sMin;
  int[] sMax;

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

//general formula ?

  int birthMin(int min, int neighbors) {
    int[] bmin = bMin;
    for (r=0; r< bMin.length; r++) {
      if (neighbors >= bmin[r]) {
        return 1;
      }
      return 0;
      int sum;
      sum+= bmin[r];
    }
    if (sum == bmin.length) {
      return 1;
    }return 0;
  }
  
  int birthMax(int max, int neighbors) {
    int[] bmax = bMax;
    for (r=0; r< bMin.length; r++) {
      if (neighbors <= bmax[r]) {
        return 1;
      }
      return 0;
      int sum;
      sum+= bmax[r];
    }
    if (sum == bmax.length) {
      return 1;
    }return 0;
  }
  
  int surviveMin(int min, int neighbors) {
    int[] smin = sMin;
    for (r=0; r< sMin.length; r++) {
      if (neighbors >= smin[r]) {
        return 1;
      }
      return 0;
      int sum;
      sum+= smin[r];
    }
    if (sum == smin.length) {
      return 1;
    }return 0;
  }
  
  int surviveMax(int max, int neighbors) {
    int[] smax = sMax;
    for (r=0; r< sMax.length; r++) {
      if (neighbors <= smax[r]) {
        return 1;
      }
      return 0;  
      int sum;
      sum+= smax[r];
    }
    if (sum == smax.length) {
      return 1;
    }return 0;
  }
  
  int birth(int min, int max, int nb) {
    if (birthMin(min, nb) + birthMax(max, nb) == 2) {
      return 1;
    }return 0;
  }
  
  int survive(int min, int max, int nb) {
    if (surviveMin(min, nb) + surviveMax(max, nb) == 2) {
      return 1;
    }return 0;
  }
  
  int gameRule(int state, int bmin, int bmax, int smin, int smax, int nb) {
    int b;
    int s;
    if (state == live) {
      b = birth(bmin, bmax, nb);
    } 
    if (state == dead) {
      s = survive(smin, smax, nb);
    }
    return 0;
  }  
  
 void testGen() {
    for (int r = 0; r < cols; r++) {
      for (int c = 0; c < rows; c++) {
        int neighbors = countNeighbors(r, c);
        nextGrid[r][c] = gameRule(grid[r][c], bMin, bMax, sMin, sMax, neighbors);
      }
    }
    int[][] buffer = grid;
    grid = nextGrid;
    nextGrid = buffer;
  }

}
