
//https://stackoverflow.com/questions/34570344/check-if-15-puzzle-is-solvable
bool isSolvable(List<int?> array, int width) {
  int parity = 0;

  int row = 0; // the current row we are on
  int blankRow = 0; // the row with the blank tile

  for (int i = 0; i < array.length; i++) {
    if (i % width == 0) {
      // advance to next row
      row++;
    }
    if (array[i] == null) {
      // the blank tile
      blankRow = row; // save the row on which encountered
      continue;
    }
    for (int j = i + 1; j < array.length; j++) {
      if (array[j] != null && array[i]! > array[j]!) {
        parity++;
      }
    }
  }

  if (width % 2 == 0) {
    // even grid
    if (blankRow % 2 == 0) {
      // blank on odd row; counting from bottom
      return parity % 2 == 0;
    } else {
      // blank on even row; counting from bottom
      return parity % 2 != 0;
    }
  } else {
    // odd grid
    return parity % 2 == 0;
  }
}
